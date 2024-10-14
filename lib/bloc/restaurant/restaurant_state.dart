import 'package:crave_wave_app/model/user_restaurant/user_restaurant.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class RestaurantState {
  final bool isLoading;
  final String? error;
  const RestaurantState({
    required this.isLoading,
    this.error,
  });
}

class RestaurantInitialize extends RestaurantState with EquatableMixin {
  const RestaurantInitialize({
    required super.isLoading,
    super.error,
  });
  @override
  List<Object?> get props => [
        isLoading,
        error,
      ];
}

class RestaurantData extends RestaurantState with EquatableMixin {
  final Iterable<UserRestaurant> userRestaurant;
  const RestaurantData({
    required this.userRestaurant,
    required super.isLoading,
    super.error,
  });

  @override
  List<Object?> get props => [
        isLoading,
        userRestaurant,
        error,
      ];
}

class RestaurantNoData extends RestaurantState with EquatableMixin {
  const RestaurantNoData({
    required super.isLoading,
    super.error,
  });

  @override
  List<Object?> get props => [
        isLoading,
        error,
      ];
}
