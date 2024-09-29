import 'dart:io';

import 'package:crave_wave_app/bloc/menu/menu_bloc.dart';
import 'package:crave_wave_app/bloc/menu/menu_event.dart';
import 'package:crave_wave_app/components/color.dart';
import 'package:crave_wave_app/components/dialogs/delete_menu_item.dart';
import 'package:crave_wave_app/model/menu/item_type.dart';
import 'package:crave_wave_app/model/menu/menu_item.dart';
import 'package:crave_wave_app/view/admin_section/menu_view/menu_edit_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ListUserMenu extends StatefulWidget {
  final MenuItem menuItem;
  const ListUserMenu({
    super.key,
    required this.menuItem,
  });

  @override
  State<ListUserMenu> createState() => _ListUserMenuState();
}

class _ListUserMenuState extends State<ListUserMenu> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Center(
      child: Align(
        alignment: Alignment
            .topCenter, // Keeps the container aligned centrally without taking up the full width
        child: Container(
          width: width * 0.92, // Limits the container width
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: backgroundColor.withOpacity(0.7),
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.start, // Aligns items at the top
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 15.0, left: 8.0, bottom: 15),
                child: Container(
                  height: 100,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.menuItem.fileUrl,
                      width: width * 0.3,
                      fit: BoxFit.cover,
                      //height: null, // Dynamically matches the tallest content
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              widget.menuItem.itemName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow:
                                  TextOverflow.ellipsis, // Truncate if too long
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(
                                Icons.crop_square_sharp,
                                color: widget.menuItem.itemType == ItemType.veg
                                    ? Colors.green
                                    : Colors.red,
                                size: 36,
                              ),
                              Icon(
                                Icons.circle,
                                color: widget.menuItem.itemType == ItemType.veg
                                    ? Colors.green
                                    : Colors.red,
                                size: 14,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Flexible(
                        child: Text(
                          widget.menuItem.itemDescription,
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\u{20B9}${widget.menuItem.itemPrice.toString()}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      //File? file;
                                      // Get the document directory for saving the image file
                                      final directory =
                                          await getApplicationDocumentsDirectory();

                                      // File path for the downloaded image (overwriting the existing file)
                                      final timestamp =
                                          DateTime.now().millisecondsSinceEpoch;
                                      final filePath =
                                          '${directory.path}/image_$timestamp.png';

                                      // Send an HTTP request to download the image
                                      final response = await http.get(
                                          Uri.parse(widget.menuItem.fileUrl));

                                      if (response.statusCode == 200) {
                                        // Overwrite the image file with new data
                                        final file = File(filePath);
                                        await file.writeAsBytes(
                                            response.bodyBytes,
                                            flush: true);

                                        if (context.mounted) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditMenuView(
                                                file: file,
                                                menuItem: widget.menuItem,
                                              ),
                                            ),
                                          );
                                        } // flush ensures immediate write
                                        // print(
                                        //  'Image overwritten and saved to $filePath');
                                      } else {
                                        // print('Failed to download image');
                                      }
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      size: 20,
                                      color: backgroundColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      final status =
                                          await showDeleteMenuDialog(context);
                                      if (status) {
                                        if (context.mounted) {
                                          context.read<MenuBloc>().add(
                                                DeleteMenuItemEvent(
                                                  userId:
                                                      widget.menuItem.userId,
                                                  fileStorageId: widget.menuItem
                                                      .originalFileStorageId,
                                                  menuItemId:
                                                      widget.menuItem.itemId,
                                                ),
                                              );
                                        }
                                      }
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: backgroundColor,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
