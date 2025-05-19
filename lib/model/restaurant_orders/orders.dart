import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantOrder {
  final String orderId;
  final String address;
  final Map<String, int> itemCount;
  final Map<String, int> itemPrice;
  final String restaurantId;
  final int totalPrice;
  final String uid;

  RestaurantOrder({
    required this.orderId,
    required this.address,
    required this.itemCount,
    required this.itemPrice,
    required this.restaurantId,
    required this.totalPrice,
    required this.uid,
  });

  factory RestaurantOrder.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return RestaurantOrder(
      orderId: data['orderId'],
      address: data['address'],
      itemCount: Map<String, int>.from(data['itemCount']),
      itemPrice: Map<String, int>.from(data['itemPrice']),
      restaurantId: data['restaurantId'],
      totalPrice: data['totalPrice'],
      uid: data['uid'],
    );
  }
}