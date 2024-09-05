import 'package:crave_wave_app/components/auth_error.dart';
import 'package:crave_wave_app/typedef/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthState {
  final bool isLoading;
  final AuthError? authError;

  const AuthState({
    required this.isLoading,
    this.authError,
  });
}

@immutable
class AuthStateLoggedIn extends AuthState with EquatableMixin {
  final UserId userid;
  final bool isAdmin;
  const AuthStateLoggedIn({
    required super.isLoading,
    required this.userid,
    required this.isAdmin,
    super.authError,
  });

  @override
  List<Object?> get props => [authError, isLoading, userid, isAdmin];
}

@immutable
class AuthStateLogOut extends AuthState with EquatableMixin {
  const AuthStateLogOut({required super.isLoading});
  @override
  List<Object?> get props => [authError, isLoading];
}

@immutable
class AuthStateRegistring extends AuthState with EquatableMixin {
  const AuthStateRegistring({required super.isLoading,super.authError});
  @override
  List<Object?> get props => [authError, isLoading];
}

@immutable
class AuthStateBack extends AuthState with EquatableMixin {
  const AuthStateBack({required super.isLoading});
  @override
  List<Object?> get props => [authError, isLoading];
}

@immutable
class AuthStateDoneOnboardingScreen extends AuthState with EquatableMixin {
  final bool isDone;
  const AuthStateDoneOnboardingScreen({
    required super.isLoading,
    required this.isDone,
  });

  @override
  List<Object?> get props => [authError, isLoading, isDone];
}
