import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class CartMenuCountState {
  final bool isLoading;
  final String? error;
  const CartMenuCountState({
    required this.isLoading,
    this.error,
  });
}

class CartMenuInitialize extends CartMenuCountState with EquatableMixin {
  const CartMenuInitialize({
    required super.isLoading,
    super.error,
  });

  @override
  List<Object?> get props => [
        isLoading,
      ];
}

class CartMenuData extends CartMenuCountState with EquatableMixin {
  final List<Map<String, dynamic>> data;
  final int totalCount;
  const CartMenuData({
    required this.data,
    required this.totalCount,
    required super.isLoading,
  });

  @override
  List<Object?> get props => [
        isLoading,
        data,
      ];
}

class CartRestaurantMenuData extends CartMenuCountState with EquatableMixin {
  final List<Map<String, dynamic>> data;
  final int totalCount;
  const CartRestaurantMenuData({
    required this.data,
    required this.totalCount,
    required super.isLoading,
  });

  @override
  List<Object?> get props => [
        isLoading,
        data,
      ];
}

class CartData extends CartMenuCountState with EquatableMixin {
  final List<Map<String, dynamic>> data;
  final int totalCount;
  final int totalPrice;
  const CartData({
    required this.data,
    required this.totalCount,
    required super.isLoading,
    required this.totalPrice,
  });

  @override
  List<Object?> get props => [
        isLoading,
        data,
      ];
}
