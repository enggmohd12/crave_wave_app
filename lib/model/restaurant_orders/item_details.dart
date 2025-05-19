import 'package:flutter/foundation.dart' show immutable;

@immutable
class ItemDetails {
  final String itemId;
  final int itemPrice;
  final String itemCount;
  final String itemName;

  const ItemDetails({
    required this.itemId,
    required this.itemPrice,
    required this.itemCount,
    required this.itemName,
  });
}
