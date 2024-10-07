import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class LocationState {
  final bool isLoading;
  const LocationState({
    required this.isLoading,
  });
}

class LocationLoadingState extends LocationState with EquatableMixin {
  const LocationLoadingState({required super.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class LocationInitialize extends LocationState with EquatableMixin {
  const LocationInitialize({required super.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class LocationNoPermission extends LocationState with EquatableMixin {
  const LocationNoPermission({required super.isLoading});
  @override
  List<Object?> get props => [isLoading];
}

class LocationNotOnState extends LocationState with EquatableMixin {
  const LocationNotOnState({required super.isLoading});
  @override
  List<Object?> get props => [isLoading];
}

class LocationDataState extends LocationState with EquatableMixin {
  final String? city;
  final String? country;
  final String? streetName;
  final String? pincode;
  final String? area;
  const LocationDataState({
    required super.isLoading,
    required this.city,
    required this.country,
    required this.pincode,
    required this.streetName,
    required this.area,
  });
  @override
  List<Object?> get props => [
        isLoading,
        city,
        country,
        streetName,
        pincode,
        area,
      ];
}
