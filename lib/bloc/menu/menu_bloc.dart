import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crave_wave_app/bloc/menu/menu_event.dart';
import 'package:crave_wave_app/bloc/menu/menu_state.dart';
import 'package:crave_wave_app/components/firebase_collection_name.dart';
import 'package:crave_wave_app/components/firebase_fieldname.dart';
import 'package:crave_wave_app/model/menu/menu_item.dart';
import 'package:crave_wave_app/model/menu/menu_item_key.dart';
import 'package:crave_wave_app/model/menu/menu_item_payload.dart';
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
          } else {
            emit(
              const MenuItemsState(
                menuItem: [],
                isLoading: false,
              ),
            );
          }
        } catch (e) {
          emit(MenuItemLoadingState(
            isLoading: false,
            userId: event.userId,
            menuError: 'Error occured when adding data to the system',
          ));
        }
      },
    );

    on<UpdateMenuItemEvent>(
      (event, emit) async {
        emit(const MenuItemLoadingState(isLoading: true));
        final menu_item = await FirebaseFirestore.instance
            .collection(
              FirebaseCollectionName.menuItem,
            )
            .where(
              FieldPath.documentId,
              isEqualTo: event.itemId,
            )
            .limit(1)
            .get();

        if (menu_item.docs.isNotEmpty) {
          final userId = event.userId;
          final fileName = const Uuid().v4();
          final file = event.file;
          final itemName = event.itemName;
          final itemDescription = event.itemDescription;
          final itemType = event.itemType.name;
          final itemPrice = event.itemPrice;
          final itemCategory = event.itemCategory;
          try {
            await FirebaseStorage.instance
                .ref()
                .child(
                  event.userId,
                )
                .child(
                  'image',
                )
                .child(
                  event.originalfileId,
                )
                .delete();

            final originalFileRef = FirebaseStorage.instance
                .ref()
                .child(userId)
                .child('image')
                .child(fileName);

            final originalUploadTask = await originalFileRef.putFile(file);
            final originalFileStorageId = originalUploadTask.ref.name;

            final fileUrl = await originalFileRef.getDownloadURL();
            await menu_item.docs.first.reference.update(
              {
                MenuItemkey.itemType: itemType,
                MenuItemkey.fileName: fileName,
                MenuItemkey.fileUrl: fileUrl,
                MenuItemkey.itemName: itemName,
                MenuItemkey.itemDescription: itemDescription,
                MenuItemkey.itemCategory: itemCategory,
                MenuItemkey.itemPrice: itemPrice,
                MenuItemkey.originalFileStorageId: originalFileStorageId,
              },
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
            } else {
              emit(
                const MenuItemsState(
                  isLoading: false,
                  menuItem: [],
                ),
              );
            }
          } catch (_) {
            emit(MenuItemLoadingState(
              isLoading: false,
              userId: event.userId,
              menuError: 'Error when updating the menu item',
            ));
          }
        }

        //emit(const MenuItemLoadingState(isLoading: false));
      },
    );

    on<DeleteMenuItemEvent>(
      (event, emit) async {
        emit(
          const MenuItemLoadingState(isLoading: true),
        );
        final itemId = event.menuItemId;
        final userId = event.userId;
        final fileStorageId = event.fileStorageId;

        try {
          await FirebaseStorage.instance
              .ref()
              .child(
                userId,
              )
              .child(
                'image',
              )
              .child(
                fileStorageId,
              )
              .delete();

          final menuItem = await FirebaseFirestore.instance
              .collection(FirebaseCollectionName.menuItem)
              .where(FieldPath.documentId, isEqualTo: itemId)
              .limit(1)
              .get();
          for (final item in menuItem.docs) {
            await item.reference.delete();
          }

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
          } else {
            emit(
              const MenuItemsState(
                menuItem: [],
                isLoading: false,
              ),
            );
          }
        } catch (_) {
          emit(
            MenuItemLoadingState(
              isLoading: false,
              menuError: 'Error when deleting the menu item',
              userId: event.userId,
            ),
          );
        }
      },
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
          } else {
            emit(
              const MenuItemsState(
                menuItem: [],
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
