import 'package:crave_wave_app/components/firebase_fieldname.dart';
import 'package:crave_wave_app/typedef/user.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class UserRestaurant {
  final UserId userId;
  final String restaurantName;
  

  UserRestaurant({
    required Map<String, dynamic> json,
  })  : userId = json[FirebaseFieldName.userId],
        restaurantName = json[FirebaseFieldName.restaurantName];
}
