import 'package:crave_wave_app/bloc/place_order/place_order_bloc.dart';
import 'package:crave_wave_app/bloc/place_order/place_order_state.dart';
import 'package:crave_wave_app/components/color.dart';
import 'package:crave_wave_app/model/place_order/order_detail_for_user_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('Orders'),
      ),
      body: Container(
        color: Colors.grey.shade200,
        width: width,
        height: height,
        child: BlocBuilder<PlaceOrderBloc, PlaceOrderState>(
          builder: (context, state) {
            if (state is PlaceOrderSuccessState) {
              final listOfOrders = state.items;
              if (listOfOrders.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: listOfOrders.length,
                    itemBuilder: (context, index) {
                      final order = listOfOrders[index];
                      final orderId = order['orderId'];
                      //final userId = order['userId'];
                      final pendingItems =
                          order['pendingItems'] as List<Map<String, dynamic>>;
                      final address = order['address'];
                      return Container(
                        //width: width*0.8,
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                        text: 'OrderID: ',
                                        children: [
                                          TextSpan(
                                              text: orderId,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ))
                                        ],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                        text: 'Delivering to : ',
                                        children: [
                                          TextSpan(
                                              text: address,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ))
                                        ],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(
                                color: backgroundColor,
                                thickness: 1.5,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: pendingItems.length,
                                itemBuilder: (context, index) {
                                  final items = pendingItems.elementAt(index);
                                  final itemName =
                                      items[OrderDetailForUserKey.itemName];
                                  final itemCount =
                                      items[OrderDetailForUserKey.count];
                                      final itemStatus =
                                      items[OrderDetailForUserKey.status];
                                  return Container(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    width: width * 0.9,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: RichText(
                                                text: TextSpan(
                                                    text: 'Item Name: ',
                                                    children: [
                                                      TextSpan(
                                                          text: itemName,
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ))
                                                    ],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black)),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                  text: 'x ',
                                                  children: [
                                                    TextSpan(
                                                        text: itemCount
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w900,
                                                        ))
                                                  ],
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              text: 'Delivery Status: ',
                                              children: [
                                                TextSpan(
                                                    text: itemStatus.toString().toUpperCase(),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ))
                                              ],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('No orders')],
                );
              }
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Somehing went wrong'),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
