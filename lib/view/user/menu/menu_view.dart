import 'dart:io';

import 'package:crave_wave_app/bloc/cart_menu_count/cart_menu_count_bloc.dart';
import 'package:crave_wave_app/bloc/cart_menu_count/cart_menu_count_event.dart';
import 'package:crave_wave_app/bloc/cart_menu_count/cart_menu_count_state.dart';
import 'package:crave_wave_app/bloc/category/category_bloc.dart';
import 'package:crave_wave_app/bloc/category/category_event.dart';
import 'package:crave_wave_app/bloc/location/location_bloc/location_bloc.dart';
import 'package:crave_wave_app/bloc/location/location_state/location_state.dart';
import 'package:crave_wave_app/components/color.dart';
import 'package:crave_wave_app/components/loading/loading_screen.dart';
import 'package:crave_wave_app/typedef/user.dart';
import 'package:crave_wave_app/view/user/cart/cart_view.dart';
import 'package:crave_wave_app/view/user/category/category.dart';
import 'package:crave_wave_app/view/user/component/search_item_category_textfield.dart';
import 'package:crave_wave_app/view/user/contant/explore_list.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuViewUser extends StatefulWidget {
  final UserId userId;
  const MenuViewUser({
    super.key,
    required this.userId,
  });

  @override
  State<MenuViewUser> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuViewUser> {
  TextEditingController controller = TextEditingController();
  FocusNode focus = FocusNode();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<LocationBloc, LocationState>(
            listener: (context, state) {
              if (state.isLoading) {
                LoadingScreen.instance().show(
                  context: context,
                  text: 'Fetching your location',
                );
              } else {
                LoadingScreen.instance().hide();
              }
            },
          ),
        ],
        child: Stack(
          //alignment: Alignment.centerLeft,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 125),
              height: height * 0.75,
              width: width * 0.1,
              decoration: const BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12))),
            ),
            Positioned(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Platform.isIOS ? height * 0.05 : height * 0.03,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Expanded(
                              child: Text(
                                'Menu',
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            BlocBuilder<CartMenuBloc, CartMenuCountState>(
                              builder: (context, state) {
                                if (state is CartMenuData) {
                                  return InkWell(
                                    onTap: () {
                                      context.read<CartMenuBloc>().add(
                                            LoadCartData(userId: widget.userId),
                                          );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CartView(
                                            userId: widget.userId,
                                          ),
                                        ),
                                      );
                                    },
                                    child: badges.Badge(
                                      position: badges.BadgePosition.topEnd(
                                          top: -10, end: -10),
                                      badgeContent: Text(
                                        state.totalCount.toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      badgeAnimation:
                                          const badges.BadgeAnimation.slide(
                                        animationDuration: Duration(seconds: 1),
                                        colorChangeAnimationDuration:
                                            Duration(seconds: 1),
                                        loopAnimation: false,
                                        curve: Curves.fastOutSlowIn,
                                        colorChangeAnimationCurve:
                                            Curves.easeInCubic,
                                      ),
                                      badgeStyle: badges.BadgeStyle(
                                        //shape: badges.BadgeShape.,
                                        badgeColor: backgroundColor,
                                        padding: const EdgeInsets.all(6),
                                        borderRadius: BorderRadius.circular(4),
                                        elevation: 5,
                                      ),
                                      child: const Icon(
                                        Icons.shopping_cart_rounded,
                                        size: 28,
                                      ),
                                    ),
                                  );
                                } else if (state is CartData) {
                                  return InkWell(
                                    onTap: () {
                                      context.read<CartMenuBloc>().add(
                                            LoadCartData(userId: widget.userId),
                                          );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CartView(
                                            userId: widget.userId,
                                          ),
                                        ),
                                      );
                                    },
                                    child: badges.Badge(
                                      position: badges.BadgePosition.topEnd(
                                          top: -10, end: -10),
                                      badgeContent: Text(
                                        state.totalCount.toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      badgeAnimation:
                                          const badges.BadgeAnimation.slide(
                                        animationDuration: Duration(seconds: 1),
                                        colorChangeAnimationDuration:
                                            Duration(seconds: 1),
                                        loopAnimation: false,
                                        curve: Curves.fastOutSlowIn,
                                        colorChangeAnimationCurve:
                                            Curves.easeInCubic,
                                      ),
                                      badgeStyle: badges.BadgeStyle(
                                        //shape: badges.BadgeShape.,
                                        badgeColor: backgroundColor,
                                        padding: const EdgeInsets.all(6),
                                        borderRadius: BorderRadius.circular(4),
                                        elevation: 5,
                                      ),
                                      child: const Icon(
                                        Icons.shopping_cart_rounded,
                                        size: 28,
                                      ),
                                    ),
                                  );
                                } else {
                                  return badges.Badge(
                                    position: badges.BadgePosition.topEnd(
                                        top: -10, end: -10),
                                    badgeContent: const Text(
                                      '0',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    badgeAnimation:
                                        const badges.BadgeAnimation.slide(
                                      animationDuration: Duration(seconds: 1),
                                      colorChangeAnimationDuration:
                                          Duration(seconds: 1),
                                      loopAnimation: false,
                                      curve: Curves.fastOutSlowIn,
                                      colorChangeAnimationCurve:
                                          Curves.easeInCubic,
                                    ),
                                    badgeStyle: badges.BadgeStyle(
                                      //shape: badges.BadgeShape.,
                                      badgeColor: backgroundColor,
                                      padding: const EdgeInsets.all(6),
                                      borderRadius: BorderRadius.circular(4),
                                      elevation: 5,
                                    ),
                                    child: const Icon(
                                      Icons.shopping_cart_rounded,
                                      size: 28,
                                    ),
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SearchTextField(
                          searchFoodController: controller,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      SizedBox(
                        height: height * 0.68,
                        child: MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: exploreList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final data = exploreList.elementAt(index);
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 12),
                                child: InkWell(
                                  onTap: () {
                                    context.read<CategoryBloc>().add(
                                          CategoryWiseItemEvent(
                                              searchWord: data['name']!),
                                        );
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => CategoryView(
                                            userId: widget.userId,
                                            itemcategory: data['name']!),
                                      ),
                                    );
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: width - 58,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 7,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              Image.asset(
                                                data['image']!,
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.contain,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      data['name']!
                                                          .toUpperCase(),
                                                      style: const TextStyle(
                                                        color: backgroundColor,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 35,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: backgroundColor),
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          17.5),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      blurRadius: 4,
                                                      offset: Offset(0, 2),
                                                    ),
                                                  ],
                                                ),
                                                alignment: Alignment.center,
                                                child: const RotatedBox(
                                                    quarterTurns: 210,
                                                    child: Icon(
                                                      Icons.arrow_back_ios_new,
                                                      color: backgroundColor,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
