import 'package:crave_wave_app/bloc/cart_menu_count/cart_menu_count_bloc.dart';
import 'package:crave_wave_app/bloc/cart_menu_count/cart_menu_count_event.dart';
import 'package:crave_wave_app/components/color.dart';
import 'package:crave_wave_app/typedef/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantMenuList extends StatefulWidget {
  final Map<String, dynamic> menuItem;
  final UserId userId;
  final String restaurantUID;
  const RestaurantMenuList({
    super.key,
    required this.menuItem,
    required this.userId,
    required this.restaurantUID,
  });

  @override
  State<RestaurantMenuList> createState() => _RestaurantMenuListState();
}

class _RestaurantMenuListState extends State<RestaurantMenuList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8.0,
        top: 4,
      ),
      child: Center(
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
                        widget.menuItem['fileUrl'],
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
                                widget.menuItem['name'],
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
                                  color: widget.menuItem['itemtype'] == 'nonveg'
                                      ? Colors.red
                                      : Colors.green,
                                  size: 36,
                                ),
                                Icon(
                                  Icons.circle,
                                  color: widget.menuItem['itemtype'] == 'nonveg'
                                      ? Colors.red
                                      : Colors.green,
                                  size: 14,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Flexible(
                          child: Text(
                            widget.menuItem['description'],
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\u{20B9}${widget.menuItem['price'].toString()}',
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
                                        int prevcount =
                                            widget.menuItem['count'];
                                        int newCount = prevcount + 1;
                                        context.read<CartMenuBloc>().add(
                                              UpdateRestaurantBasedItemCount(
                                                itemId:
                                                    widget.menuItem['itemId'],
                                                newCount: newCount,
                                                userId: widget.userId,
                                                restaurantUID:
                                                    widget.restaurantUID,
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
                                      widget.menuItem['count'].toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        int prevcount =
                                            widget.menuItem['count'];
                                        if (prevcount > 0) {
                                          int newCount = prevcount - 1;
                                          context.read<CartMenuBloc>().add(
                                                UpdateRestaurantBasedItemCount(
                                                  itemId:
                                                      widget.menuItem['itemId'],
                                                  newCount: newCount,
                                                  userId: widget.userId,
                                                  restaurantUID:
                                                      widget.restaurantUID,
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
      ),
    );
  }
}
