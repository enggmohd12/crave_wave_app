import 'package:crave_wave_app/bloc/cart_menu_count/cart_menu_count_bloc.dart';
import 'package:crave_wave_app/bloc/cart_menu_count/cart_menu_count_event.dart';
import 'package:crave_wave_app/typedef/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartListView extends StatefulWidget {
  final String itemId;
  final String itemName;
  final int itemPrice;
  final int priceAfterMultiplicationOfCount;
  final String itemType;
  final int count;
  final UserId userId;
  const CartListView({
    super.key,
    required this.itemId,
    required this.priceAfterMultiplicationOfCount,
    required this.itemName,
    required this.itemPrice,
    required this.itemType,
    required this.count,
    required this.userId,
  });

  @override
  State<CartListView> createState() => _CartListViewState();
}

class _CartListViewState extends State<CartListView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: width * 0.6,
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.crop_square_sharp,
                          color: widget.itemType == 'nonveg'
                              ? Colors.red
                              : Colors.green,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Icon(
                          Icons.circle,
                          color: widget.itemType == 'nonveg'
                              ? Colors.red
                              : Colors.green,
                          size: 7,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Text(
                        widget.itemName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '  \u{20B9}${widget.itemPrice}',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey.shade700),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: width * 0.18,
                height: height * 0.03,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  border: Border.all(
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        int prevcount = widget.count;
                        int newCount = prevcount + 1;
                        context.read<CartMenuBloc>().add(
                              UpdateItemCountFromCart(
                                itemId: widget.itemId,
                                newCount: newCount,
                                userId: widget.userId,
                              ),
                            );
                      },
                      child: const Icon(
                        Icons.add,
                        size: 18,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      '${widget.count}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        int prevcount = widget.count;
                        if (prevcount > 0) {
                          int newCount = prevcount - 1;
                          context.read<CartMenuBloc>().add(
                                UpdateItemCountFromCart(
                                  itemId: widget.itemId,
                                  newCount: newCount,
                                  userId: widget.userId,
                                ),
                              );
                        }
                      },
                      child: const Icon(
                        Icons.remove,
                        size: 18,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '  \u{20B9}${widget.priceAfterMultiplicationOfCount}',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey.shade700),
              )
            ],
          ),
        ],
      ),
    );
  }
}
