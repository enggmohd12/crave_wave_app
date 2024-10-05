import 'package:crave_wave_app/bloc/location/location_event/location_event.dart';
import 'package:crave_wave_app/bloc/location/location_state/location_state.dart';
import 'package:crave_wave_app/components/get_location_from_coordinates/get_location_coordinates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(const LocationInitialize(isLoading: false)) {
    on<LocationInitializeEvent>(
      (event, emit) async {
        Location location = Location();
        bool serviceEnabled;
        PermissionStatus permissionGranted;

        serviceEnabled = await location.serviceEnabled();
        if (!serviceEnabled) {
          serviceEnabled = await location.requestService();
          if (!serviceEnabled) {
            emit(
              const LocationNotOnState(
                isLoading: false,
              ),
            );
          } else {
            permissionGranted = await location.hasPermission();
            if (permissionGranted == PermissionStatus.denied) {
              permissionGranted = await location.requestPermission();
              if (permissionGranted != PermissionStatus.granted) {
                emit(
                  const LocationNoPermission(
                    isLoading: false,
                  ),
                );
              }
            } else {
              emit(
                const LocationLoadingState(
                  isLoading: true,
                ),
              );
              final geo = await Geolocator.getCurrentPosition();

              final result = await getLocationName(
                latitude: geo.latitude,
                longitude: geo.longitude,
              );

              emit(
                LocationDataState(
                  isLoading: false,
                  city: result.city,
                  country: result.country,
                  pincode: result.pincode,
                  streetName: result.streetName,
                ),
              );
            }
          }
        }
      },
    );
  }
}
