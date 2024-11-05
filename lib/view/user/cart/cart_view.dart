import 'dart:io';

import 'package:crave_wave_app/bloc/cart_menu_count/cart_menu_count_bloc.dart';
import 'package:crave_wave_app/bloc/cart_menu_count/cart_menu_count_state.dart';
import 'package:crave_wave_app/components/color.dart';
import 'package:crave_wave_app/typedef/user.dart';
import 'package:crave_wave_app/view/user/cart/components/cart_list_view.dart';
import 'package:crave_wave_app/view/user/cart/components/location_ui_bloc_implementation.dart';
import 'package:crave_wave_app/view/user/cart/components/place_order_button.dart';
import 'package:crave_wave_app/view/user/cart/components/total_price.dart';
import 'package:crave_wave_app/view/user/cart/components/username_view.dart';
import 'package:crave_wave_app/view/user/component/dash_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class CartView extends StatefulWidget {
  final UserId userId;
  const CartView({
    super.key,
    required this.userId,
  });

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text(
          'Cart',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: Colors.grey.shade200,
        width: width,
        height: height,
        child: Column(
          children: [
            SizedBox(
              height: Platform.isIOS ? height * 0.75 : height * 0.8,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Container(
                      width: width * 0.93,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: BlocBuilder<CartMenuBloc, CartMenuCountState>(
                        builder: (context, state) {
                          if (state is CartData) {
                            final data = state.data;
                            if (data.isNotEmpty) {
                              return ListView.builder(
                                shrinkWrap:
                                    true, // Allows ListView to take only the space it needs
                                physics:
                                    const NeverScrollableScrollPhysics(), // Disable scroll within ListView if not needed
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  final listdata = data.elementAt(index);
                                  final itemName = listdata['name'];
                                  final itemPrice = listdata['price'];
                                  final itemCounInCart = listdata['count'];
                                  final itemType = listdata['itemtype'];
                                  final priceAfterMultiplication =
                                      itemPrice * itemCounInCart;
                                  final itemId = listdata['itemId'];
                                  return CartListView(
                                    priceAfterMultiplicationOfCount:
                                        priceAfterMultiplication,
                                    itemName: itemName,
                                    itemPrice: itemPrice,
                                    itemType: itemType,
                                    count: itemCounInCart,
                                    itemId: itemId,
                                    userId: widget.userId,
                                  );
                                },
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Lottie.asset(
                                  'asset/animation/data_not_found.json',
                                  height: 250,
                                ),
                              );
                            }
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Container(
                        width: width * 0.93,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            const LocationUIBlocImplementation(),
                            SizedBox(
                              height: height * 0.0001,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: DashSeparator(),
                            ),
                            SizedBox(
                              height: height * 0.001,
                            ),
                            const UserNameDelivery(),
                            SizedBox(
                              height: height * 0.0001,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: DashSeparator(),
                            ),
                            SizedBox(
                              height: height * 0.001,
                            ),
                            const TotalPriceView(),
                          ],
                        )),
                  ],
                ),
              ),
            ),
            Expanded(child: Column(
              children: [
                 PlaceOrderButton(
                  userId: widget.userId,
                ),
                if(Platform.isIOS)
                SizedBox(
                  height: height*0.009,
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
