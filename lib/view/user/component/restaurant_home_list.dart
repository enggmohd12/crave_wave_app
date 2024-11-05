import 'package:crave_wave_app/bloc/cart_menu_count/cart_menu_count_bloc.dart';
import 'package:crave_wave_app/bloc/cart_menu_count/cart_menu_count_event.dart';
import 'package:crave_wave_app/bloc/restaurant/restaurant_bloc.dart';
import 'package:crave_wave_app/bloc/restaurant/restaurant_state.dart';
import 'package:crave_wave_app/typedef/user.dart';
import 'package:crave_wave_app/view/user/restaurant_item/restaurant_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class RestaurantListHome extends StatelessWidget {
  final UserId userId;
  const RestaurantListHome({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      builder: (context, state) {
        if (state is RestaurantData) {
          final restaurantData = state.userRestaurant;
          return MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: restaurantData.length,
              itemBuilder: (context, index) {
                final data = restaurantData.elementAt(index);
                return InkWell(
                  onTap: () {
                    context
                        .read<CartMenuBloc>()
                        .add(LoadRestaurantBasedCartData(
                          userId: userId,
                          restaurantUID: data.userId,
                        ));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantItemView(
                            restaurantUID: data.userId, userId: userId),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          height: 200,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.asset(
                              'asset/image/food_background.jpg',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 35,
                          top: 130,
                          child: Text(
                            data.restaurantName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 21,
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 35,
                          top: 160,
                          child: Text(
                            'Click here to see all the items',
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is RestaurantNoData) {
          return Center(
            child: Lottie.asset(
              'asset/animation/data_not_found.json',
              height: 200,
            ),
          );
        }
        return const Center(
          child: Text(
            'Fetching data!!',
          ),
        );
      },
    );
  }
}
