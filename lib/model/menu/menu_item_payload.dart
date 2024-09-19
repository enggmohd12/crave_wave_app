import 'dart:collection' show MapView;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crave_wave_app/model/menu/item_type.dart';
import 'package:crave_wave_app/model/menu/menu_item_key.dart';
import 'package:crave_wave_app/typedef/user.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class MenuItemPayload extends MapView<String, dynamic> {
  MenuItemPayload({
    required UserId userId,
    required String itemName,
    required String fileUrl,
    required ItemType itemType,
    required String fileName,
    required String originalFileStorageId,
    required String itemDescription,
    required int itemPrice,
    required String itemCategory,
  }) : super({
          MenuItemkey.userId: userId,
          MenuItemkey.itemName: itemName,
          MenuItemkey.createdAt: FieldValue.serverTimestamp(),
          MenuItemkey.fileUrl: fileUrl,
          MenuItemkey.itemType: itemType.name,
          MenuItemkey.fileName: fileName,
          MenuItemkey.originalFileStorageId: originalFileStorageId,
          MenuItemkey.itemDescription: itemDescription,
          MenuItemkey.itemPrice: itemPrice,
          MenuItemkey.itemCategory: itemCategory,
        });
}
