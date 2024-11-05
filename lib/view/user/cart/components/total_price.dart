import 'package:crave_wave_app/bloc/cart_menu_count/cart_menu_count_bloc.dart';
import 'package:crave_wave_app/bloc/cart_menu_count/cart_menu_count_state.dart';
import 'package:crave_wave_app/components/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TotalPriceView extends StatefulWidget {
  const TotalPriceView({super.key});

  @override
  State<TotalPriceView> createState() => _TotalPriceViewState();
}

class _TotalPriceViewState extends State<TotalPriceView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<CartMenuBloc, CartMenuCountState>(
      builder: (context, state) {
        if (state is CartData) {
          int totalPrice = state.totalPrice;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.monetization_on_outlined,
                      color: backgroundColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: width * 0.009,
                    ),
                    const Text(
                      'Total Bill',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '\u{20B9}$totalPrice',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
              ],
            ),
          ); // Need to change back to AdminUserView() after creating the UI for User
        } else {
          return const Text('Something went wrong');
        }
      },
    );
  }
}
