import 'package:crave_wave_app/bloc/cart_menu_count/cart_menu_count_bloc.dart';
import 'package:crave_wave_app/bloc/cart_menu_count/cart_menu_count_state.dart';
import 'package:crave_wave_app/components/color.dart';
import 'package:crave_wave_app/typedef/user.dart';
import 'package:crave_wave_app/view/user/restaurant_item/components/restaurant_item_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantItemView extends StatefulWidget {
  final String restaurantUID;
  final UserId userId;
  const RestaurantItemView({
    super.key,
    required this.restaurantUID,
    required this.userId,
  });

  @override
  State<RestaurantItemView> createState() => _RestaurantViewState();
}

class _RestaurantViewState extends State<RestaurantItemView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: const Text(
          'Restaurant Item List',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<CartMenuBloc, CartMenuCountState>(
        builder: (context, state) {
          if (state is CartRestaurantMenuData) {
            return ListView.builder(
              padding: const EdgeInsets.only(
                bottom: 12,
              ),
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                final data = state.data.elementAt(index);

                return RestaurantMenuList(
                  menuItem: data,
                  userId: widget.userId,
                  restaurantUID: widget.restaurantUID,
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                'No data found',
              ),
            );
          }
        },
      ),
    );
  }
}
