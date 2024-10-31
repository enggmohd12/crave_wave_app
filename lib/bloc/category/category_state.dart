import 'package:crave_wave_app/model/menu/menu_item.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class CategoryState {
  final bool isLoading;
  final String? error;
  const CategoryState({
    required this.isLoading,
    this.error,
  });
}

class CategoryInitialize extends CategoryState with EquatableMixin {
  const CategoryInitialize({
    required super.isLoading,
  });
  @override
  List<Object?> get props => [isLoading];
}

class CategoryData extends CategoryState with EquatableMixin {
  final List<MenuItem> menuItem;
  const CategoryData({
    required this.menuItem,
    required super.isLoading,
  });
  @override
  List<Object?> get props => [
        isLoading,
        menuItem,
      ];
}

class CategoryNoData extends CategoryState with EquatableMixin {
  const CategoryNoData({
    required super.isLoading,
  });
  @override
  List<Object?> get props => [isLoading];
}


class CategoryError extends CategoryState with EquatableMixin {
  const CategoryError({
    required super.isLoading,
    required super.error,
  });
  @override
  List<Object?> get props => [
        isLoading,
        error,
      ];
}
