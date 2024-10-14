import 'dart:io';

import 'package:crave_wave_app/model/location/location_data.dart';
import 'package:geocoding/geocoding.dart';

Future<LocationInfo> getLocationName({
  required double latitude,
  required double longitude,
}) async {
  List<Placemark> placemarks = await placemarkFromCoordinates(
    latitude,
    longitude,
  );

  final address = placemarks[0];
  // print(address.country);
  // print(address.subAdministrativeArea);
  // print(address.locality);
  // print(address.postalCode);
  // print(address.subLocality);
  // print(address.street);

  if (Platform.isAndroid){
    return LocationInfo(
    city: address.locality,
    country: address.country,
    pincode: address.postalCode,
    streetName: address.street,
    area: address.subLocality
  );
  } else{
    return LocationInfo(
    city: address.subAdministrativeArea,
    country: address.country,
    pincode: address.postalCode,
    streetName: address.street,
    area: address.subLocality
  );
  }

  
}
