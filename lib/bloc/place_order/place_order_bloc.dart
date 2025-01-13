import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crave_wave_app/bloc/place_order/place_order_event.dart';
import 'package:crave_wave_app/bloc/place_order/place_order_state.dart';
import 'package:crave_wave_app/components/firebase_collection_name.dart';
import 'package:crave_wave_app/model/cart/cart_key.dart';
import 'package:crave_wave_app/model/menu/menu_item_key.dart';
import 'package:crave_wave_app/model/place_order/order_detail_for_restaurant_key.dart';
import 'package:crave_wave_app/model/place_order/order_detail_for_user_key.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceOrderBloc extends Bloc<PlaceOrderEvent, PlaceOrderState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  PlaceOrderBloc()
      : super(
          const PlaceOrderInitializeState(isLoading: false),
        ) {
    on<PlaceOrderOfUserEvent>(_onFetchAndSaveUserOrder);
    on<FetchOrderDetails>(_onFetchUserOrder);
  }

  Future<void> _onFetchUserOrder(
    FetchOrderDetails event,
    Emitter<PlaceOrderState> emit,
  ) async {
    try {
      emit(
        const PlaceOrderInitializeState(isLoading: true),
      );
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName
              .userOrder) // Replace with your collection name
          .where(
            'userId',
            isEqualTo: event.userId,
          )
          .get();

      List<Map<String, dynamic>> groupedPendingOrders = [];

      // Process each document
      for (var doc in querySnapshot.docs) {
        // Get the items array and document ID
        List<dynamic> items = doc.get('items') ?? [];
        String docId = doc.id;

        // Filter items with status "pending"
        List<Map<String, dynamic>> pendingItems = items
            .where((item) => item['status'] == 'pending')
            .cast<Map<String, dynamic>>()
            .toList();

        // Add to the grouped list only if there are pending items
        if (pendingItems.isNotEmpty) {
          groupedPendingOrders.add({
            'orderId': docId, // Order ID or Document ID
            'userId': doc.get('userId'), // User ID for reference
            'pendingItems': pendingItems, // Filtered pending items
            'address': doc.get('address'),
          });
        }
      }

      // Emit success state with the order ID
      emit(PlaceOrderSuccessState(
        isLoading: false,
        items: groupedPendingOrders,
      )); // Pass the order ID here
    } catch (e) {
      emit(PlaceOrderFailureState(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }

  Future<void> _onFetchAndSaveUserOrder(
    PlaceOrderOfUserEvent event,
    Emitter<PlaceOrderState> emit,
  ) async {
    emit(const PlaceOrderInitializeState(
      isLoading: true,
    ));

    try {
      // Fetch data from the source collection
      final cartDoc = await _firestore
          .collection(FirebaseCollectionName.cart)
          .doc(event.userId)
          .get();

      if (!cartDoc.exists) {
        emit(const PlaceOrderFailureState(
            isLoading: false, error: 'No data found to place your order,'));
        return;
      }

      // Prepare the data for userOrder
      List<Map<String, dynamic>> items = [];

      // Use a for loop to handle async calls properly
      for (var item in cartDoc['item']) {
        final itemDoc = await _firestore
            .collection(FirebaseCollectionName.menuItem)
            .doc(item[CartKey.itemId])
            .get();

        if (!itemDoc.exists) {
          emit(const PlaceOrderFailureState(
              isLoading: false, error: 'No data found to place your order.'));
          return;
        }

        items.add({
          OrderDetailForUserKey.count: item[CartKey.count],
          OrderDetailForUserKey.itemId: item[CartKey.itemId],
          OrderDetailForUserKey.itemName: itemDoc[MenuItemkey.itemName],
          OrderDetailForUserKey.status: "pending", // Add your status field here
        });
      }

      // Insert transformed data into the userOrder collection and get the generated document ID
      final DocumentReference orderRef =
          await _firestore.collection(FirebaseCollectionName.userOrder).add({
        "userId": event.userId,
        "items": items,
        "address": event.address,
      });

      final orderId = orderRef.id;

      // Retrieve cart items (assuming `cartItems` is a list of maps with `itemId` and `count`)
      List<dynamic> cartItems = cartDoc[CartKey.item];

      // Step 2: Organize items by restaurantId, calculate total price, and item-wise price totals
      Map<String, Map<String, int>> restaurantData =
          {}; // Map<restaurantId, Map<itemId, count>>
      Map<String, double> restaurantTotalPrice =
          {}; // Map<restaurantId, totalPrice>
      Map<String, Map<String, double>> itemPrices =
          {}; // Map<restaurantId, Map<itemId, itemTotalPrice>>

      for (var item in cartItems) {
        String itemId = item[CartKey.itemId];
        int count = item[CartKey.count];

        // Fetch the item's details from the item collection
        final itemDoc = await FirebaseFirestore.instance
            .collection(FirebaseCollectionName.menuItem)
            .doc(itemId)
            .get();
        if (!itemDoc.exists) continue;

        String restaurantId = itemDoc[
            MenuItemkey.userId]; // Assuming `uid` represents `restaurantId`

        double itemPrice = (itemDoc[MenuItemkey.itemPrice] as int)
            .toDouble(); // Assuming each item document has `itemPrice` as price
  
        // Calculate total for this item
        double itemTotalPrice = itemPrice * count;

        // Initialize data structures for the restaurant if not already done
        if (restaurantData[restaurantId] == null) {
          restaurantData[restaurantId] = {};
          restaurantTotalPrice[restaurantId] = 0.0;
          itemPrices[restaurantId] = {};
        }

        // Save count for the item
        restaurantData[restaurantId]![itemId] = count;
        // Accumulate total price for the restaurant, ensuring it is initialized to 0.0
        restaurantTotalPrice[restaurantId] =
            (restaurantTotalPrice[restaurantId] ?? 0.0) + itemTotalPrice;
        // Accumulate item-specific total price in itemPrices
        itemPrices[restaurantId]![itemId] = itemTotalPrice;
      }

      for (String restaurantId in restaurantData.keys) {
        await FirebaseFirestore.instance
            .collection(FirebaseCollectionName.order)
            .add({
          OrderDetailForRestaurantKey.uid: event.userId,
          OrderDetailForRestaurantKey.restaurantId: restaurantId,
          OrderDetailForRestaurantKey.itemCount: restaurantData[restaurantId],
          OrderDetailForRestaurantKey.totalPrice:
              restaurantTotalPrice[restaurantId], // Total price per restaurant
          OrderDetailForRestaurantKey.itemPrice:
              itemPrices[restaurantId], // Each item's price * count
          OrderDetailForRestaurantKey.orderId: orderId,
          OrderDetailForRestaurantKey.address:
              event.address, // Grand total across all restaurants
        });
      }

      final cartrefdel = await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.cart,
          )
          .where(
            CartKey.userId,
            isEqualTo: event.userId,
          )
          .get();

      if (cartrefdel.docs.isNotEmpty) {
        for (QueryDocumentSnapshot doc in cartrefdel.docs) {
          await doc.reference.delete();
        }
      }

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName
              .userOrder) // Replace with your collection name
          .where(
            'userId',
            isEqualTo: event.userId,
          )
          .get();

      List<Map<String, dynamic>> groupedPendingOrders = [];

      // Process each document
      for (var doc in querySnapshot.docs) {
        // Get the items array and document ID
        List<dynamic> items = doc.get('items') ?? [];
        String docId = doc.id;

        // Filter items with status "pending"
        List<Map<String, dynamic>> pendingItems = items
            .where((item) => item['status'] == 'pending')
            .cast<Map<String, dynamic>>()
            .toList();

        // Add to the grouped list only if there are pending items
        if (pendingItems.isNotEmpty) {
          groupedPendingOrders.add({
            'orderId': docId, // Order ID or Document ID
            'userId': doc.get('userId'), // User ID for reference
            'pendingItems': pendingItems, // Filtered pending items
            'address': doc.get('address'),
          });
        }
      }

      // Emit success state with the order ID
      emit(PlaceOrderSuccessState(
        isLoading: false,
        items: groupedPendingOrders,
      )); // Pass the order ID here
    } catch (e) {
      emit(PlaceOrderFailureState(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }
}
