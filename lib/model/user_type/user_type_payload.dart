import 'dart:collection';
import 'package:crave_wave_app/components/firebase_fieldname.dart';
import 'package:crave_wave_app/typedef/user.dart';
import 'package:flutter/foundation.dart' show immutable;


@immutable
class UserTypePayload extends MapView<String, dynamic> {
  UserTypePayload({
    required UserId userId,
    required bool isAdmin,
  }) : super({
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.userOrAdmin: isAdmin
        });
}
