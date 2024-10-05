import 'package:flutter/foundation.dart' show immutable;

@immutable
class LocationInfo{
  final String? country;
  final String? city;
  final String? pincode;
  final String? streetName;
  const LocationInfo({
    required this.city,
    required this.country,
    required this.pincode,
    required this.streetName,
  });
}
