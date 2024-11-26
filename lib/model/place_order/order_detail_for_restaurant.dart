import 'package:crave_wave_app/model/place_order/order_detail_for_restaurant_key.dart';
import 'package:crave_wave_app/typedef/user.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class OrderDetailForRestaurant {
  final UserId userid;
  final Map<String,double> itemprice;
  final Map<String,int> itemcount;
  final String restaurantId;
  final String orderId;
  final double totalPrice;

  const OrderDetailForRestaurant({
    required this.userid,
    required this.itemprice,
    required this.itemcount,
    required this.restaurantId,
    required this.orderId,
    required this.totalPrice,
  });

  Map<String,dynamic> toJson() => {
    OrderDetailForRestaurantKey.uid : userid,
    OrderDetailForRestaurantKey.itemPrice : itemprice,
    OrderDetailForRestaurantKey.itemCount : itemcount,
    OrderDetailForRestaurantKey.restaurantId : restaurantId,
    OrderDetailForRestaurantKey.orderId : orderId,
    OrderDetailForRestaurantKey.totalPrice : totalPrice,
  };

  factory OrderDetailForRestaurant.fromJson(Map<String, dynamic> json) {
    return OrderDetailForRestaurant(
      userid: json[OrderDetailForRestaurantKey.uid],
      itemprice: json[OrderDetailForRestaurantKey.itemPrice],
      itemcount: json[OrderDetailForRestaurantKey.itemCount],
      restaurantId: json[OrderDetailForRestaurantKey.restaurantId],
      orderId: json[OrderDetailForRestaurantKey.orderId],
      totalPrice: json[OrderDetailForRestaurantKey.totalPrice],
    );
  }
}