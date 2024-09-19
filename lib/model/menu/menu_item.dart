import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crave_wave_app/model/menu/item_type.dart';
import 'package:crave_wave_app/model/menu/menu_item_key.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class MenuItem {
  final String itemId;
  final String userId;
  final String itemName;
  final DateTime createdAt;
  final String fileUrl;
  final String fileName;
  final String originalFileStorageId;
  final ItemType itemType;
  final String itemDescription;
  final String itemPrice;
  final String itemCategory;

  MenuItem({
    required this.itemId,
    required Map<String, dynamic> json,
  })  : userId = json[MenuItemkey.userId],
        itemName = json[MenuItemkey.itemName],
        createdAt = (json[MenuItemkey.createdAt] as Timestamp).toDate(),
        fileUrl = json[MenuItemkey.fileUrl],
        itemType = ItemType.values.firstWhere(
            (itemType) => itemType.name == json[MenuItemkey.itemType],
            orElse: () => ItemType.veg),
        fileName = json[MenuItemkey.fileName],
        itemDescription = json[MenuItemkey.itemDescription],
        itemPrice = json[MenuItemkey.itemPrice],
        itemCategory = json[MenuItemkey.itemCategory],
        originalFileStorageId = json[MenuItemkey.originalFileStorageId];
}
