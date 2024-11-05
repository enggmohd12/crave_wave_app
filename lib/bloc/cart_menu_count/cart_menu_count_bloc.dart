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
    on<LoadCartData>(_onLoadCart);
    on<UpdateItemCountFromCart>(_onUpdateItemFromCartCount);
    on<LoadRestaurantBasedCartData>(_onLoadRestaurantBasedCart);
    on<UpdateRestaurantBasedItemCount>(_onUpdateRestaurantBasedItemCount);
  }

  Future<void> _onLoadCategories(
      LoadCategories event, Emitter<CartMenuCountState> emit) async {
    try {
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

  Future<void> _onLoadCart(
      LoadCartData event, Emitter<CartMenuCountState> emit) async {
    try {
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
      final mergedItems = availableItems.where((item) {
        // Check if the item exists in cartItems
        return cartItems.any((ci) => ci.itemId == item['itemId']);
      }).map((item) {
        final cartItem = cartItems.firstWhere(
          (ci) => ci.itemId == item['itemId'],
        );
        return {
          'itemId': item['itemId'],
          'name': item[MenuItemkey.itemName], // Assuming each item has a 'name'
          'count': cartItem.count,
          'price': item[MenuItemkey.itemPrice],
          'itemtype': item[MenuItemkey.itemType],
        };
      }).toList();

      //print(mergedItems);

      // Step 4: Calculate the total count from cart items with non-zero count
      final totalCount = cartItems.fold(
        0,
        (x, item) => x + item.count,
      );
      final totalPrice = mergedItems.fold(0, (y, item) {
        return y + ((item['price'] as int) * item['count'] as int);
      });

      emit(CartData(
        data: mergedItems,
        isLoading: false,
        totalCount: totalCount,
        totalPrice: totalPrice,
      ));
    } catch (e) {
      emit(CartMenuInitialize(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onLoadRestaurantBasedCart(LoadRestaurantBasedCartData event,
      Emitter<CartMenuCountState> emit) async {
    try {
      final itemsSnapshot = await _firestore
          .collection(FirebaseCollectionName.menuItem)
          .where(MenuItemkey.userId,
              isEqualTo: event.restaurantUID) // Filter items by uid
          .get();
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
          'price': item[MenuItemkey.itemPrice],
          'itemtype': item[MenuItemkey.itemType],
          'description': item[MenuItemkey.itemDescription],
          'fileUrl': item[MenuItemkey.fileUrl],
        };
      }).toList();

      //print(mergedItems);

      // Step 4: Calculate the total count from cart items with non-zero count
      final totalCount = cartItems.fold(
        0,
        (x, item) => x + item.count,
      );
      // final totalPrice = mergedItems.fold(0, (y, item) {
      //   return y + ((item['price'] as int) * item['count'] as int);
      // });

      emit(CartRestaurantMenuData(
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

  Future<void> _onUpdateRestaurantBasedItemCount(
      UpdateRestaurantBasedItemCount event,
      Emitter<CartMenuCountState> emit) async {
    try {
      final cartRef =
          _firestore.collection(FirebaseCollectionName.cart).doc(event.userId);
      final cartDoc = await cartRef.get();

      List<CartItem> items =
          cartDoc.exists ? Cart.fromJson(cartDoc.data()!).items : [];

      // Check if the item exists, and update or add it accordingly
      final index = items.indexWhere((item) => item.itemId == event.itemId);

      if (index != -1) {
        if (event.newCount > 0) {
          // Update the count if greater than zero
          items[index] = CartItem(itemId: event.itemId, count: event.newCount);
        } else {
          // Remove the item if the count is zero
          items.removeAt(index);
        }
      } else if (event.newCount > 0) {
        items.add(CartItem(itemId: event.itemId, count: event.newCount));
      }

      // Save the updated cart
      final updatedCart = Cart(userId: event.userId, items: items);
      await cartRef.set(updatedCart.toJson());

      // Reload the categories after update
      add(LoadRestaurantBasedCartData(
        userId: event.userId,
        restaurantUID: event.restaurantUID,
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
        if (event.newCount > 0) {
          // Update the count if greater than zero
          items[index] = CartItem(itemId: event.itemId, count: event.newCount);
        } else {
          // Remove the item if the count is zero
          items.removeAt(index);
        }
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

  Future<void> _onUpdateItemFromCartCount(
      UpdateItemCountFromCart event, Emitter<CartMenuCountState> emit) async {
    try {
      final cartRef =
          _firestore.collection(FirebaseCollectionName.cart).doc(event.userId);
      final cartDoc = await cartRef.get();

      List<CartItem> items =
          cartDoc.exists ? Cart.fromJson(cartDoc.data()!).items : [];

      // Check if the item exists, and update or add it accordingly
      final index = items.indexWhere((item) => item.itemId == event.itemId);

      if (index != -1) {
        if (event.newCount > 0) {
          // Update the count if greater than zero
          items[index] = CartItem(itemId: event.itemId, count: event.newCount);
        } else {
          // Remove the item if the count is zero
          items.removeAt(index);
        }
      } else if (event.newCount > 0) {
        items.add(CartItem(itemId: event.itemId, count: event.newCount));
      }

      // Save the updated cart
      final updatedCart = Cart(userId: event.userId, items: items);
      await cartRef.set(updatedCart.toJson());

      // Reload the categories after update
      add(LoadCartData(userId: event.userId));
    } catch (e) {
      emit(CartMenuInitialize(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }
}
