import 'dart:io';

import 'package:crave_wave_app/model/menu/item_type.dart';
import 'package:crave_wave_app/typedef/user.dart';

abstract class MenuEvent {
  const MenuEvent();
}

class AddMenuItemEvent extends MenuEvent {
  final File file;
  final UserId userId;
  final ItemType itemType;
  final String itemDescription;
  final int itemPrice;
  final String itemName;
  final String itemCategory;
  const AddMenuItemEvent({
    required this.file,
    required this.userId,
    required this.itemType,
    required this.itemDescription,
    required this.itemPrice,
    required this.itemName,
    required this.itemCategory,
  });
}

class DeleteMenuItemEvent extends MenuEvent {
  final UserId userId;
  final String menuItemId;
  final String fileStorageId;
  const DeleteMenuItemEvent({
    required this.userId,
    required this.fileStorageId,
    required this.menuItemId,
  });
}

class GetMenuItemForUserEvent extends MenuEvent {
  final UserId userId;
  const GetMenuItemForUserEvent({
    required this.userId,
  });
}

class GetAllMenuItemEvent extends MenuEvent {
  const GetAllMenuItemEvent();
}
