import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crave_wave_app/bloc/cart_menu_count/cart_menu_count_event.dart';
import 'package:crave_wave_app/bloc/cart_menu_count/cart_menu_count_state.dart';
import 'package:crave_wave_app/components/firebase_collection_name.dart';
import 'package:crave_wave_app/model/cart/cart.dart';
import 'package:crave_wave_app/model/cart/cart_item.dart';
import 'package:crave_wave_app/model/menu/menu_item_key.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartMenuBloc extends Bloc<CartMenuCountEvent, CartMenuCountState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CartMenuBloc()
      : super(
          const CartMenuInitialize(
            isLoading: false,
          ),
        ) {
    on<LoadCategories>(_onLoadCategories);
    on<UpdateItemCount>(_onUpdateItemCount);
  }

  Future<void> _onLoadCategories(
      LoadCategories event, Emitter<CartMenuCountState> emit) async {
    try {
      emit(
        const CartMenuInitialize(
          isLoading: true,
        ),
      );
      // Step 1: Fetch the available items
      final itemsSnapshot =
          await _firestore.collection(FirebaseCollectionName.menuItem).get();
      final availableItems = itemsSnapshot.docs.map((doc) {
        return {
          'itemId': doc.id,
          ...doc.data(),
        };
      }).toList();

      // Step 2: Fetch the user's cart data from Firestore using userId
      final cartDoc = await _firestore
          .collection(FirebaseCollectionName.cart)
          .doc(event.userId)
          .get();
      List<CartItem> cartItems =
          cartDoc.exists ? Cart.fromJson(cartDoc.data()!).items : [];

      // Step 3: Merge the items with the user's cart, defaulting to 0 if not found
      final mergedItems = availableItems.map((item) {
        final cartItem = cartItems.firstWhere(
          (ci) => ci.itemId == item['itemId'],
          orElse: () => CartItem(itemId: item['itemId'], count: 0),
        );
        return {
          'itemId': item['itemId'],
          'name': item[MenuItemkey.itemName], // Assuming each item has a 'name'
          'count': cartItem.count,
        };
      }).toList();

      // Step 4: Calculate the total count from cart items with non-zero count
      final totalCount = cartItems.fold(
        0,
        (x, item) => x + item.count,
      );

      emit(CartMenuData(
        data: mergedItems,
        isLoading: false,
        totalCount: totalCount,
      ));
    } catch (e) {
      emit(CartMenuInitialize(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onUpdateItemCount(
      UpdateItemCount event, Emitter<CartMenuCountState> emit) async {
    try {
      final cartRef =
          _firestore.collection(FirebaseCollectionName.cart).doc(event.userId);
      final cartDoc = await cartRef.get();

      List<CartItem> items =
          cartDoc.exists ? Cart.fromJson(cartDoc.data()!).items : [];

      // Check if the item exists, and update or add it accordingly
      final index = items.indexWhere((item) => item.itemId == event.itemId);

      if (index != -1) {
        items[index] = CartItem(itemId: event.itemId, count: event.newCount);
      } else if (event.newCount > 0) {
        items.add(CartItem(itemId: event.itemId, count: event.newCount));
      }

      // Save the updated cart
      final updatedCart = Cart(userId: event.userId, items: items);
      await cartRef.set(updatedCart.toJson());

      // Reload the categories after update
      add(LoadCategories(userId: event.userId));
    } catch (e) {
      emit(CartMenuInitialize(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }
}
