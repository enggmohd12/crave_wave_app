import 'dart:io';
import 'package:crave_wave_app/bloc/location/location_bloc/location_bloc.dart';
import 'package:crave_wave_app/bloc/location/location_event/location_event.dart';
import 'package:crave_wave_app/bloc/location/location_state/location_state.dart';
import 'package:crave_wave_app/components/color.dart';
import 'package:crave_wave_app/components/dialogs/location_not_enabled_dialog.dart';
import 'package:crave_wave_app/components/dialogs/loctaion_permission_not_granted_dialog.dart';
import 'package:crave_wave_app/components/get_location_from_coordinates/get_location_coordinates.dart';
import 'package:crave_wave_app/components/loading/loading_screen.dart';
import 'package:crave_wave_app/view/user/component/custome_divider.dart';
import 'package:crave_wave_app/view/user/component/explore_box.dart';
import 'package:crave_wave_app/view/user/component/search_item_category_textfield.dart';
import 'package:crave_wave_app/view/user/contant/explore_list.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as p;

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Column(
              children: [
                SizedBox(
                    height: Platform.isIOS ? height * 0.05 : height * 0.03),
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
                        position:
                            badges.BadgePosition.topEnd(top: -10, end: -10),
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
                BlocBuilder<LocationBloc, LocationState>(
                  builder: (context, state) {
                    if (state is LocationDataState) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Delivering to',
                              style: TextStyle(fontSize: 11),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${state.area},${state.city},${state.country}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const RotatedBox(
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
                      );
                    } else if (state is LocationNotOnState) {
                      return InkWell(
                        onTap: () async {
                          Location location = Location();
                          bool serviceEnabled;
                          PermissionStatus permissionGranted;
                          serviceEnabled = await location.serviceEnabled();
                          if (!serviceEnabled) {
                            serviceEnabled = await location.requestService();
                            if (!serviceEnabled) {
                              if (context.mounted) {
                                final result = await showLocationNotOnDialog(
                                  context,
                                );
                                if (result) {
                                  serviceEnabled =
                                      await location.serviceEnabled();
                                  if (!serviceEnabled) {
                                    serviceEnabled =
                                        await location.requestService();
                                    if (!serviceEnabled) {
                                      return;
                                    }
                                    permissionGranted =
                                        await location.hasPermission();
                                    if (permissionGranted ==
                                        PermissionStatus.denied) {
                                      permissionGranted =
                                          await location.requestPermission();
                                      if (permissionGranted !=
                                          PermissionStatus.granted) {
                                        return;
                                      }
                                    }

                                    if (context.mounted) {
                                      context
                                          .read<LocationBloc>()
                                          .add(const GetLocationEvent());
                                    }
                                  } else {
                                    return;
                                  }
                                }
                              }
                            } else {
                              permissionGranted =
                                  await location.hasPermission();
                              if (permissionGranted ==
                                  PermissionStatus.denied) {
                                permissionGranted =
                                    await location.requestPermission();
                                if (permissionGranted !=
                                    PermissionStatus.granted) {
                                  return;
                                }
                              }

                              if (context.mounted) {
                                context
                                    .read<LocationBloc>()
                                    .add(const GetLocationEvent());
                              }
                            }
                          } else {
                            permissionGranted = await location.hasPermission();
                            if (permissionGranted == PermissionStatus.denied) {
                              permissionGranted =
                                  await location.requestPermission();
                              if (permissionGranted !=
                                  PermissionStatus.granted) {
                                return;
                              }
                            }

                            if (context.mounted) {
                              context
                                  .read<LocationBloc>()
                                  .add(const GetLocationEvent());
                            }
                          }
                        },
                        child: const Padding(
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
                                    'Location is not enabled.Tap Here',
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
                      );
                    } else if (state is LocationNoPermission) {
                      return InkWell(
                        onTap: () async {
                          Location location = Location();

                          PermissionStatus permissionGranted;

                          permissionGranted = await location.hasPermission();
                          if (permissionGranted == PermissionStatus.denied) {
                            permissionGranted =
                                await location.requestPermission();
                            if (permissionGranted != PermissionStatus.granted) {
                              if (context.mounted) {
                                final result =
                                    await showLocationPermissionDeniedDialog(
                                        context);
                                if (result) {
                                  await p.openAppSettings();
                                }
                                return;
                              }
                            } else {
                              if (context.mounted) {
                                context
                                    .read<LocationBloc>()
                                    .add(const GetLocationEvent());
                              }
                            }
                          } else {
                            if (context.mounted) {
                              context
                                  .read<LocationBloc>()
                                  .add(const GetLocationEvent());
                            }
                          }
                        },
                        child: const Padding(
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
                                    'No permission granted for location.Tap Here',
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
                      );
                    }
                    return InkWell(
                      onTap: () async {
                        Location location = Location();

                        bool serviceEnabled;
                        PermissionStatus permissionGranted;

                        serviceEnabled = await location.serviceEnabled();
                        if (!serviceEnabled) {
                          serviceEnabled = await location.requestService();
                          if (!serviceEnabled) {
                            return;
                          }
                        }

                        permissionGranted = await location.hasPermission();
                        if (permissionGranted == PermissionStatus.denied) {
                          permissionGranted =
                              await location.requestPermission();
                          if (permissionGranted != PermissionStatus.granted) {
                            return;
                          }
                        }
                        // if (Platform.isIOS) {
                        final geo = await Geolocator.getCurrentPosition();

                        await getLocationName(
                          latitude: geo.latitude,
                          longitude: geo.longitude,
                        );
                      },
                      child: const Padding(
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
                    );
                  },
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                SearchTextField(
                  searchFoodController: searchFoodController,
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 20.0,
                //   ),
                //   child: TypeAheadField(
                //     itemBuilder: (context, value) {
                //       return ListTile(
                //         leading: CircleAvatar(
                //           radius: 25,
                //           child: ClipOval(
                //             child: Image.network(
                //               value.fileUrl,
                //               width: 50,
                //               height: 50,
                //               fit: BoxFit.fill,
                //             ),
                //           ),
                //         ),
                //         title: Text(value.itemName),
                //         subtitle: Text(
                //           '\u{20B9}${value.itemPrice.toString()}',
                //         ),
                //         trailing: Stack(
                //           alignment: Alignment.center,
                //           children: [
                //             Icon(
                //               Icons.crop_square_sharp,
                //               color: value.itemType == ItemType.veg
                //                   ? Colors.green
                //                   : Colors.red,
                //               size: 30,
                //             ),
                //             Icon(
                //               Icons.circle,
                //               color: value.itemType == ItemType.veg
                //                   ? Colors.green
                //                   : Colors.red,
                //               size: 8,
                //             ),
                //           ],
                //         ),
                //       );
                //     },
                //     onSelected: (value) {},
                //     suggestionsCallback: (search) async {
                //       final menuItem =
                //           await getMenuItemCateforyWise(searchTerm: search);
                //       List<MenuItem> lst = menuItem.toList();
                //       return lst;
                //     },
                //     builder: (context, controller, focusNode) {
                //       return SlidingTextField(
                //         controller: controller,
                //         focusNode: focusNode,
                //       );
                //     },
                //     errorBuilder: (context, error) {
                //       return const Text('Error Occured');
                //     },
                //     controller: searchFoodController,
                //   ),
                //   // child: SlidingTextField(
                //   //   controller: searchFoodController,
                //   // ),
                //   // UserSearchFoodTextField(
                //   //   controller: searchFoodController,
                //   //   hintText: 'Search Food',
                //   // ),
                // ),
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                            const Positioned(
                              left: 35,
                              top: 130,
                              child: Text(
                                'Persian Darbar indes //',
                                style: TextStyle(
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
      ),
    );
  }
}
