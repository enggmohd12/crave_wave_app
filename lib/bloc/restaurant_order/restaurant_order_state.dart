import 'package:crave_wave_app/model/restaurant_orders/orders.dart';
import 'package:equatable/equatable.dart';

abstract class RestaurantOrderState {
  final bool isLoading;
  final String? error;
  const RestaurantOrderState({
    required this.isLoading,
    this.error,
  });
}

class RestaurantOrderInitializeState extends RestaurantOrderState
    with EquatableMixin {
  const RestaurantOrderInitializeState({
    required super.isLoading,
  });

  @override
  List<Object?> get props => [
        isLoading,
      ];
}

class RestaurantOrderLoaded extends RestaurantOrderState with EquatableMixin {
  final List<RestaurantOrder> pendingOrders;
  final List<RestaurantOrder> completedOrders;

  RestaurantOrderLoaded({
    required this.pendingOrders,
    required this.completedOrders,
    required super.isLoading,
  });

  @override
  List<Object?> get props => [
        isLoading,
        pendingOrders,
        completedOrders,
      ];
}

class RestaurantOrderFailureState extends RestaurantOrderState
    with EquatableMixin {
  const RestaurantOrderFailureState({
    required super.isLoading,
    required super.error,
  });

  @override
  List<Object?> get props => [
        isLoading,
        error,
      ];
}
