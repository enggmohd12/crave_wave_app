import 'package:crave_wave_app/model/cart/cart_item.dart';
import 'package:crave_wave_app/model/cart/cart_key.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class Cart {
  final String userId;
  final List<CartItem> items;

  const Cart({
    required this.userId,
    required this.items,
  });

  Map<String, dynamic> toJson() => {
        CartKey.userId: userId,
        CartKey.item: items.map((item) => item.toJson()).toList(),
      };

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      userId: json[CartKey.userId],
      items: (json[CartKey.item] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
    );
  }
}
