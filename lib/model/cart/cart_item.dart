import 'package:flutter/foundation.dart' show immutable;

@immutable
class CartItem {
  final String itemId;
  final int count;

  const CartItem({
    required this.itemId,
    required this.count,
  });

  Map<String, dynamic> toJson() => {
        'itemId': itemId,
        'count': count,
      };

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      itemId: json['itemId'],
      count: json['count'],
    );
  }
}
