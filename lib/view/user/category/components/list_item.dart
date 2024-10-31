import 'package:crave_wave_app/bloc/cart_menu_count/cart_menu_count_bloc.dart';
import 'package:crave_wave_app/bloc/cart_menu_count/cart_menu_count_event.dart';
import 'package:crave_wave_app/bloc/cart_menu_count/cart_menu_count_state.dart';
import 'package:crave_wave_app/components/color.dart';
import 'package:crave_wave_app/model/menu/item_type.dart';
import 'package:crave_wave_app/model/menu/menu_item.dart';
import 'package:crave_wave_app/typedef/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListMenuCategory extends StatefulWidget {
  final MenuItem menuItem;
  final UserId userId;
  const ListMenuCategory({
    super.key,
    required this.menuItem,
    required this.userId,
  });

  @override
  State<ListMenuCategory> createState() => _ListMenuCategoryState();
}

class _ListMenuCategoryState extends State<ListMenuCategory> {
  @override
  void initState() {
    context.read<CartMenuBloc>().add(
          LoadCategories(userId: widget.userId),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<CartMenuBloc, CartMenuCountState>(
      builder: (context, state) {
        if (state is CartMenuData) {
          final items = state.data;
          Map<String, dynamic> matchingItem = items.firstWhere(
            (item) => item['itemId'] == widget.menuItem.itemId,
            orElse: () => {}, // Return null if no match is found
          );
          //print(matchingItem);
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
                      padding: const EdgeInsets.only(
                          top: 15.0, left: 8.0, bottom: 15),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
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
                                    overflow: TextOverflow
                                        .ellipsis, // Truncate if too long
                                  ),
                                ),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(
                                      Icons.crop_square_sharp,
                                      color: widget.menuItem.itemType ==
                                              ItemType.veg
                                          ? Colors.green
                                          : Colors.red,
                                      size: 36,
                                    ),
                                    Icon(
                                      Icons.circle,
                                      color: widget.menuItem.itemType ==
                                              ItemType.veg
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
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
                                            int prevcount =
                                                matchingItem['count'];
                                            int newCount = prevcount + 1;
                                            context.read<CartMenuBloc>().add(
                                                  UpdateItemCount(
                                                    itemId:
                                                        widget.menuItem.itemId,
                                                    newCount: newCount,
                                                    userId: widget.userId,
                                                  ),
                                                );
                                          },
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: backgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: const Icon(
                                              Icons.add,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          matchingItem['count'].toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            int prevcount =
                                                matchingItem['count'];
                                            if (prevcount > 0) {
                                              int newCount = prevcount - 1;
                                              context.read<CartMenuBloc>().add(
                                                    UpdateItemCount(
                                                      itemId: widget
                                                          .menuItem.itemId,
                                                      newCount: newCount,
                                                      userId: widget.userId,
                                                    ),
                                                  );
                                            }
                                          },
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: backgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: const Icon(
                                              Icons.remove,
                                              size: 20,
                                              color: Colors.white,
                                            ),
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
        } else {
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
                      padding: const EdgeInsets.only(
                          top: 15.0, left: 8.0, bottom: 15),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
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
                                    overflow: TextOverflow
                                        .ellipsis, // Truncate if too long
                                  ),
                                ),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(
                                      Icons.crop_square_sharp,
                                      color: widget.menuItem.itemType ==
                                              ItemType.veg
                                          ? Colors.green
                                          : Colors.red,
                                      size: 36,
                                    ),
                                    Icon(
                                      Icons.circle,
                                      color: widget.menuItem.itemType ==
                                              ItemType.veg
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
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
                                          },
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: backgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: const Icon(
                                              Icons.add,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          'XX',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            //context.read<CartMenuBloc>().add(UpdateItemCount(itemId: widget.menuItem.itemId, newCount: newCount, userId: ))
                                          },
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: backgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: const Icon(
                                              Icons.remove,
                                              size: 20,
                                              color: Colors.white,
                                            ),
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
      },
    );
  }
}
