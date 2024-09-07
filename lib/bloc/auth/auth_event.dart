import 'package:crave_wave_app/typedef/user.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

@immutable
class AuthRegistringUserEvent extends AuthEvent {
  final String email;
  final String password;
  final String userName;
  final bool isAdmin;
  final String? restaurantName;

  const AuthRegistringUserEvent({
    required this.email,
    required this.password,
    required this.userName,
    required this.isAdmin,
    this.restaurantName,
  });
}

@immutable
class AuthLoggedInEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthLoggedInEvent({
    required this.email,
    required this.password,
  });
}

@immutable
class AuthLogOutEvent extends AuthEvent {
  final UserId userId;
  final bool isAdmin;
  const AuthLogOutEvent({
    required this.userId,
    required this.isAdmin,
  });
}

@immutable
class AuthAppInitializeEvent extends AuthEvent {
  const AuthAppInitializeEvent();
}

@immutable
class AuthOnBoardingEvent extends AuthEvent {
  const AuthOnBoardingEvent();
}

@immutable
class AuthGotoRegisteringView extends AuthEvent {
  const AuthGotoRegisteringView();
}

@immutable
class AuthGotoLoginView extends AuthEvent {
  const AuthGotoLoginView();
}

@immutable
class AuthGotoHelloFoodie extends AuthEvent {
  const AuthGotoHelloFoodie();
}

@immutable
class AuthForgotPasswordEvent extends AuthEvent {
  final String emailID;
  const AuthForgotPasswordEvent({
    required this.emailID,
  });
}
