import 'dart:io';
import 'package:crave_wave_app/components/color.dart';
import 'package:crave_wave_app/view/user/component/custome_divider.dart';
import 'package:crave_wave_app/view/user/component/explore_box.dart';
import 'package:crave_wave_app/view/user/component/text_field_user_search.dart';
import 'package:crave_wave_app/view/user/contant/explore_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/widgets.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  final searchFoodController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Column(
            children: [
              SizedBox(height: Platform.isIOS ? height * 0.05 : height * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Expanded(
                      child: Text(
                        'Good Morning MOHAMMED AHMED ANSARI!',
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    badges.Badge(
                      position: badges.BadgePosition.topEnd(top: -10, end: -10),
                      badgeContent: const Text(
                        '9',
                        style: TextStyle(color: Colors.white),
                      ),
                      badgeAnimation: const badges.BadgeAnimation.slide(
                        animationDuration: Duration(seconds: 1),
                        colorChangeAnimationDuration: Duration(seconds: 1),
                        loopAnimation: false,
                        curve: Curves.fastOutSlowIn,
                        colorChangeAnimationCurve: Curves.easeInCubic,
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
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delivering to',
                      style: TextStyle(fontSize: 11),
                    ),
                    Row(
                      children: [
                        Text(
                          'Current Location',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        RotatedBox(
                          quarterTurns: 315,
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: backgroundColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: UserSearchFoodTextField(
                  controller: searchFoodController,
                  hintText: 'Search Food',
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              const CustomDivider(message: "WHAT'S ON YOUR MIND"),
              SizedBox(
                height: 85,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  //shrinkWrap: true,
                  itemCount: exploreList.length,
                  itemBuilder: (context, index) {
                    final data = exploreList.elementAt(index);
                    return ExploreBox(
                      image: data['image']!,
                      name: data['name']!,
                    );
                  },
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              const CustomDivider(message: "ALL RESTAURANTS"),

              MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            height: 200,
                            width: 400,
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
                              'Persian Darbar indes ${index}',
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
                    );
                  },
                ),
              ),
              // Stack(
              //   children: [
              //     Container(
              //       margin: const EdgeInsets.symmetric(horizontal: 20),
              //       height: 200,
              //       width: 400,
              //       decoration: BoxDecoration(
              //           color: Colors.black,
              //           borderRadius: BorderRadius.circular(12)),
              //       child: ClipRRect(
              //         borderRadius: BorderRadius.circular(12.0),
              //         child: Image.asset(
              //           'asset/image/food_background.jpg',
              //           fit: BoxFit.fill,
              //         ),
              //       ),
              //     ),
              //     const Positioned(
              //       left: 35,
              //       top: 130,
              //       child: Text(
              //         'Persian Darbar',
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 21,
              //         ),
              //       ),
              //     ),
              //     const Positioned(
              //       left: 35,
              //       top: 160,
              //       child: Text(
              //         'Click here to see all the items',
              //       ),
              //     )
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
