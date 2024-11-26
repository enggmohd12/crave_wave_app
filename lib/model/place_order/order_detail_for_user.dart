import 'package:crave_wave_app/model/place_order/order_detail_for_user_key.dart';
import 'package:crave_wave_app/model/place_order/order_item_user.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class OrderDetailForUser {
  final String userId;
  final List<OrderItemUser> items;

  const OrderDetailForUser({
    required this.userId,
    required this.items,
  });

  Map<String, dynamic> toJson() => {
        OrderDetailForUserKey.userId: userId,
        OrderDetailForUserKey.items: items.map((item) => item.toJson()).toList(),
      };

  factory OrderDetailForUser.fromJson(Map<String, dynamic> json) {
    return OrderDetailForUser(
      userId: json[OrderDetailForUserKey.userId],
      items: (json[OrderDetailForUserKey.items] as List)
          .map((item) => OrderItemUser.fromJson(item))
          .toList(),
    );
  }
}
