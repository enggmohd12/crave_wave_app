import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crave_wave_app/components/firebase_collection_name.dart';
import 'package:crave_wave_app/model/menu/menu_item.dart';

Future<Iterable<MenuItem>> getMenuItemCateforyWise({
  required String searchTerm,
}) async {
  final sub = await FirebaseFirestore.instance
      .collection(
        FirebaseCollectionName.menuItem,
      )
      .get();

  if (sub.docs.isNotEmpty) {
    final menuitem = sub.docs
        .map(
          (docs) => MenuItem(itemId: docs.id, json: docs.data()),
        )
        .where(
          (menuitem) => menuitem.itemCategory.toLowerCase().contains(
                searchTerm.toLowerCase(),
              ),
        );

    return menuitem;
  } else{
    return const Iterable.empty();
  }
}
