import 'package:crave_wave_app/model/menu/menu_item.dart';
import 'package:crave_wave_app/typedef/user.dart';
import 'package:equatable/equatable.dart';

abstract class MenuState {
  final bool isLoading;
  final String? menuError;
  final UserId? userId;

  const MenuState({
    required this.isLoading,
    this.menuError,
    this.userId,
  });
}

class MenuInitialState extends MenuState with EquatableMixin {
  const MenuInitialState({required super.isLoading});

  @override
  List<Object?> get props => [
        isLoading,
      ];
}

class MenuItemsState extends MenuState with EquatableMixin {
  final Iterable<MenuItem> menuItem;

  const MenuItemsState({
    required this.menuItem,
    required super.isLoading,
  });

  @override
  List<Object?> get props => [
        menuItem,
        isLoading,
      ];
}

class MenuItemLoadingState extends MenuState with EquatableMixin {
  const MenuItemLoadingState(
      {required super.isLoading, super.menuError, super.userId});

  @override
  List<Object?> get props => [
        isLoading,
        menuError,
        userId,
      ];
}

class MenuItemPop extends MenuState with EquatableMixin {
  const MenuItemPop({
    required super.isLoading,
    super.menuError,
  });

  @override
  List<Object?> get props => [
        isLoading,
        menuError,
      ];
}
