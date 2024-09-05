import 'dart:collection';
import 'package:crave_wave_app/components/firebase_fieldname.dart';
import 'package:crave_wave_app/typedef/user.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class UserRestaurantPayload extends MapView<String, String> {
  UserRestaurantPayload({
    required UserId userId,
    required String restaurantName,
  }) : super({
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.restaurantName: restaurantName,
        });
}
