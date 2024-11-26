import 'package:crave_wave_app/bloc/cart_menu_count/cart_menu_count_bloc.dart';
import 'package:crave_wave_app/bloc/cart_menu_count/cart_menu_count_state.dart';
import 'package:crave_wave_app/bloc/location/location_bloc/location_bloc.dart';
import 'package:crave_wave_app/bloc/location/location_state/location_state.dart';
import 'package:crave_wave_app/bloc/place_order/place_order_bloc.dart';
import 'package:crave_wave_app/bloc/place_order/place_order_event.dart';
import 'package:crave_wave_app/components/color.dart';
import 'package:crave_wave_app/typedef/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceOrderButton extends StatelessWidget {
  final UserId userId;
  const PlaceOrderButton({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<CartMenuBloc, CartMenuCountState>(
      builder: (context, state) {
        if (state is CartData) {
          int totalprice = state.totalPrice;
          return BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state) {
              if (state is LocationDataState) {
                final address = '${state.area},${state.city},${state.country}';
                return SizedBox(
                  width: width * 0.9,
                  //height: height * 0.05,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(backgroundColor),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              8,
                            ),
                          ),
                        ),
                      ),
                    ),
                    onPressed: totalprice == 0
                        ? null
                        : () async {
                            context.read<PlaceOrderBloc>().add(
                                  PlaceOrderOfUserEvent(
                                    userId: userId,
                                    address: address,
                                  ),
                                );
                          },
                    child: Row(
                      children: [
                        SizedBox(
                          width: width * 0.3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              children: [
                                Text(
                                  '\u{20B9}$totalprice',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'TOTAL',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.5,
                          child: const Column(
                            children: [
                              Text(
                                'Place order',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return SizedBox(
                  width: width * 0.9,
                  //height: height * 0.05,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(backgroundColor),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              8,
                            ),
                          ),
                        ),
                      ),
                    ),
                    onPressed: null,
                    child: Row(
                      children: [
                        SizedBox(
                          width: width * 0.3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              children: [
                                Text(
                                  '\u{20B9}$totalprice',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'TOTAL',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.5,
                          child: const Column(
                            children: [
                              Text(
                                'Place order',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            },
          );
        } else {}
        return SizedBox(
          width: width * 0.9,
          height: height * 0.05,
          child: ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(backgroundColor),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      8,
                    ),
                  ),
                ),
              ),
            ),
            onPressed: () {},
            child: const Text(
              'No item in the cart',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
