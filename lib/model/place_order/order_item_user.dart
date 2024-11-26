import 'package:flutter/foundation.dart' show immutable;

@immutable
class OrderItemUser {
  final String itemId;
  final int count;
  final String status;

  const OrderItemUser({
    required this.itemId,
    required this.count,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
        'itemId': itemId,
        'count': count,
        'status':status,
      };

  factory OrderItemUser.fromJson(Map<String, dynamic> json) {
    return OrderItemUser(
      itemId: json['itemId'],
      count: json['count'],
      status: json['status'],
    );
  }
}
