import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class PlaceOrderState {
  final bool isLoading;
  final String? error;

  const PlaceOrderState({
    required this.isLoading,
    this.error,
  });
}

class PlaceOrderInitializeState extends PlaceOrderState with EquatableMixin {
  const PlaceOrderInitializeState({required super.isLoading});

  @override
  List<Object?> get props => [
        isLoading,
      ];
}

class PlaceOrderSuccessState extends PlaceOrderState with EquatableMixin {
  final List<Map<String, dynamic>> items;
  const PlaceOrderSuccessState({
    required super.isLoading,
    required this.items,
  });

  @override
  List<Object?> get props => [
        isLoading,
        items,
      ];
}

class PlaceOrderFailureState extends PlaceOrderState with EquatableMixin {
  const PlaceOrderFailureState({
    required super.isLoading,
    required super.error,
  });

  @override
  List<Object?> get props => [
        isLoading,
        error,
      ];
}
