import 'package:crave_wave_app/typedef/user.dart';

abstract class CartMenuCountEvent {}

class LoadCategories extends CartMenuCountEvent {
  final String userId;
  LoadCategories({
    required this.userId,
  });
}

class LoadCartData extends CartMenuCountEvent {
  final UserId userId;
  LoadCartData({
    required this.userId,
  });
}

class LoadRestaurantBasedCartData extends CartMenuCountEvent {
  final UserId userId;
  final String restaurantUID;
  LoadRestaurantBasedCartData({
    required this.userId,
    required this.restaurantUID,
  });
}

class UpdateItemCountFromCart extends CartMenuCountEvent {
  final String itemId;
  final int newCount;
  final String userId;

  UpdateItemCountFromCart({
    required this.itemId,
    required this.newCount,
    required this.userId,
  });
}

class UpdateItemCount extends CartMenuCountEvent {
  final String itemId;
  final int newCount;
  final String userId;

  UpdateItemCount({
    required this.itemId,
    required this.newCount,
    required this.userId,
  });
}

class UpdateRestaurantBasedItemCount extends CartMenuCountEvent {
  final String itemId;
  final int newCount;
  final String userId;
  final String restaurantUID;

  UpdateRestaurantBasedItemCount({
    required this.itemId,
    required this.newCount,
    required this.userId,
    required this.restaurantUID,
  });
}
