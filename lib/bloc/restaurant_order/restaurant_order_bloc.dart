import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crave_wave_app/bloc/restaurant_order/restaurant_order_event.dart';
import 'package:crave_wave_app/bloc/restaurant_order/restaurant_order_state.dart';
import 'package:crave_wave_app/components/firebase_collection_name.dart';
import 'package:crave_wave_app/model/restaurant_orders/item_details.dart';
import 'package:crave_wave_app/model/restaurant_orders/orders.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantOrderBloc
    extends Bloc<RestaurantOrderEvent, RestaurantOrderState> {
  RestaurantOrderBloc()
      : super(const RestaurantOrderInitializeState(
          isLoading: false,
        )) {
    on<LoadRestaurantOrders>(_loadPendingOrders);
  }

  Future<void> _loadPendingOrders(
      LoadRestaurantOrders event, Emitter<RestaurantOrderState> emit) async {
    emit(const RestaurantOrderInitializeState(
      isLoading: true,
    ));
    try {
      final pendingSnapshot = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.order)
          .where(
            'restaurantId',
            isEqualTo: event.restaurantId,
          )
          .get();
      List<ItemDetails> itemDetails = [];

      for (var doc in pendingSnapshot.docs) {
        Map<String, dynamic> itemsCount = doc.get('itemCount') ?? [];
        print(itemsCount);

        Map<String, dynamic> itemsPrice = doc.get('itemPrice') ?? [];
        print(itemsPrice);

        Iterable<String> itemCountkeys = itemsCount.keys;
        Iterable<String> itemPricekeys = itemsPrice.keys;

        for (var itemCount in itemCountkeys) {
          final keyC = itemCount;
          final checkig = itemsCount[keyC];
          final count = itemsCount[keyC];
          for (var itemPrice in itemPricekeys) {
            final keyP = itemPrice;
            final price = itemsPrice[keyP];
            if (keyC == keyP) {
              print('got same');
              final itemNameSnapShot = await FirebaseFirestore.instance
                  .collection(FirebaseCollectionName.menuItem)
                  .where(
                    FieldPath.documentId,
                    isEqualTo: keyC,
                  )
                  .get();
              String iM = '';
              try {
                for (var docitem in itemNameSnapShot.docs) {
                  final itemData = docitem.data();

                  print("Full Document Data: $itemData"); // ✅ Print full data
                  print(
                      "Type of itemName: ${itemData['itemName'].runtimeType}"); // ✅ Check type

                  iM = itemData['itemName']; // Assign value
                  print("Assigned itemName: $iM");

                  if (itemData['itemName'] is String) {
                    iM = itemData['itemName'];
                    print(iM);
                  } else {
                    iM = itemData['itemName'].toString();
                    print(iM);
                    // Convert to string
                  }
                }
              } catch (e) {
                print(e.toString());
              }

              final itemData = ItemDetails(
                itemId: keyC,
                itemPrice: price,
                itemCount: count,
                itemName: iM,
              );
              itemDetails.add(itemData);
              break;
            }
          }
        }
      }

      final pendingOrders = pendingSnapshot.docs
          .map((doc) => RestaurantOrder.fromFirestore(doc))
          .toList();

      emit(RestaurantOrderLoaded(
          pendingOrders: pendingOrders, completedOrders: [], isLoading: false));
    } catch (e) {
      emit(RestaurantOrderFailureState(
          isLoading: false, error: 'Failed to load pending orders: $e'));
    }
  }
}
