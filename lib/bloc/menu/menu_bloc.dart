import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crave_wave_app/bloc/menu/menu_event.dart';
import 'package:crave_wave_app/bloc/menu/menu_state.dart';
import 'package:crave_wave_app/components/firebase_collection_name.dart';
import 'package:crave_wave_app/components/firebase_fieldname.dart';
import 'package:crave_wave_app/model/menu/menu_item.dart';
import 'package:crave_wave_app/model/menu/menu_item_payload.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc()
      : super(const MenuInitialState(
          isLoading: false,
        )) {
    on<AddMenuItemEvent>(
      (event, emit) async {
        emit(
          const MenuItemLoadingState(isLoading: true),
        );
        final userId = event.userId;
        final fileName = const Uuid().v4();
        final file = event.file;
        final itemName = event.itemName;
        final itemDescription = event.itemDescription;
        final itemType = event.itemType;
        final itemPrice = event.itemPrice;
        final itemCategory = event.itemCategory;
        try {
          final originalFileRef = FirebaseStorage.instance
              .ref()
              .child(userId)
              .child('image')
              .child(fileName);

          final originalUploadTask = await originalFileRef.putFile(file);
          final originalFileStorageId = originalUploadTask.ref.name;

          final menuItemPayload = MenuItemPayload(
            userId: userId,
            itemName: itemName,
            fileUrl: await originalFileRef.getDownloadURL(),
            itemType: itemType,
            fileName: fileName,
            originalFileStorageId: originalFileStorageId,
            itemDescription: itemDescription,
            itemPrice: itemPrice,
            itemCategory: itemCategory,
          );

          await FirebaseFirestore.instance
              .collection(FirebaseCollectionName.menuItem)
              .add(
                menuItemPayload,
              );

          final menuitem = await FirebaseFirestore.instance
              .collection(FirebaseCollectionName.menuItem)
              .where(
                FirebaseFieldName.userId,
                isEqualTo: userId,
              )
              .get();
          if (menuitem.docs.isNotEmpty) {
            final docs = menuitem.docs;
            final menuitems = docs.map(
              (doc) => MenuItem(
                itemId: doc.id,
                json: doc.data(),
              ),
            );
            emit(
              MenuItemsState(
                menuItem: menuitems,
                isLoading: false,
              ),
            );
          }
        } catch (e) {
          emit(MenuItemLoadingState(
            isLoading: false,
            menuError: e.toString(),
          ));
        }
      },
    );

    on<DeleteMenuItemEvent>(
      (event, emit) {},
    );

    on<GetMenuItemForUserEvent>(
      (event, emit) async {
        emit(
          const MenuItemLoadingState(isLoading: true),
        );

        try {
          final userId = event.userId;
          //final userId = FirebaseAuth.instance.currentUser.;

          final menuitem = await FirebaseFirestore.instance
              .collection(FirebaseCollectionName.menuItem)
              .where(
                FirebaseFieldName.userId,
                isEqualTo: userId,
              )
              .get();
          if (menuitem.docs.isNotEmpty) {
            final docs = menuitem.docs;
            final menuitems = docs.map(
              (doc) => MenuItem(
                itemId: doc.id,
                json: doc.data(),
              ),
            );
            emit(
              MenuItemsState(
                menuItem: menuitems,
                isLoading: false,
              ),
            );
          }
        } catch (_) {
          emit(
            const MenuItemLoadingState(
              isLoading: false,
            ),
          );
        }
      },
    );

    on<GetAllMenuItemEvent>(
      (event, emit) {},
    );
  }
}
