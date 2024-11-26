import 'package:crave_wave_app/bloc/location/location_bloc/location_bloc.dart';
import 'package:crave_wave_app/bloc/location/location_event/location_event.dart';
import 'package:crave_wave_app/bloc/location/location_state/location_state.dart';
import 'package:crave_wave_app/components/color.dart';
import 'package:crave_wave_app/components/dialogs/location_not_enabled_dialog.dart';
import 'package:crave_wave_app/components/dialogs/loctaion_permission_not_granted_dialog.dart';
import 'package:crave_wave_app/components/get_location_from_coordinates/get_location_coordinates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as p;

class LocationUIBlocImplementation extends StatefulWidget {
  const LocationUIBlocImplementation({super.key});

  @override
  State<LocationUIBlocImplementation> createState() =>
      _LocationUIBlocImplementationState();
}

class _LocationUIBlocImplementationState
    extends State<LocationUIBlocImplementation> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        if (state is LocationDataState) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.home_outlined,
                      color: backgroundColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: width * 0.009,
                    ),
                    const Text(
                      'Delivering at',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
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
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                
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
                      serviceEnabled = await location.serviceEnabled();
                      if (!serviceEnabled) {
                        serviceEnabled = await location.requestService();
                        if (!serviceEnabled) {
                          return;
                        }
                        permissionGranted = await location.hasPermission();
                        if (permissionGranted == PermissionStatus.denied) {
                          permissionGranted =
                              await location.requestPermission();
                          if (permissionGranted != PermissionStatus.granted) {
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
                  permissionGranted = await location.hasPermission();
                  if (permissionGranted == PermissionStatus.denied) {
                    permissionGranted = await location.requestPermission();
                    if (permissionGranted != PermissionStatus.granted) {
                      return;
                    }
                  }

                  if (context.mounted) {
                    context.read<LocationBloc>().add(const GetLocationEvent());
                  }
                }
              } else {
                permissionGranted = await location.hasPermission();
                if (permissionGranted == PermissionStatus.denied) {
                  permissionGranted = await location.requestPermission();
                  if (permissionGranted != PermissionStatus.granted) {
                    return;
                  }
                }

                if (context.mounted) {
                  context.read<LocationBloc>().add(const GetLocationEvent());
                }
              }
            },
            child:  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                  children: [
                    const Icon(
                      Icons.home_outlined,
                      color: backgroundColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: width * 0.009,
                    ),
                    const Text(
                      'Delivering to',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                  const Row(
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
                permissionGranted = await location.requestPermission();
                if (permissionGranted != PermissionStatus.granted) {
                  if (context.mounted) {
                    final result =
                        await showLocationPermissionDeniedDialog(context);
                    if (result) {
                      await p.openAppSettings();
                    }
                    return;
                  }
                } else {
                  if (context.mounted) {
                    context.read<LocationBloc>().add(const GetLocationEvent());
                  }
                }
              } else {
                if (context.mounted) {
                  context.read<LocationBloc>().add(const GetLocationEvent());
                }
              }
            },
            child:  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                  children: [
                    const Icon(
                      Icons.home_outlined,
                      color: backgroundColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: width * 0.009,
                    ),
                    const Text(
                      'Delivering to',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                   Row(
                    children: [
                      SizedBox(
                        width: width*0.8,
                        child:const Text(
                          'No permission granted for location.Tap Here',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
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
              permissionGranted = await location.requestPermission();
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
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
