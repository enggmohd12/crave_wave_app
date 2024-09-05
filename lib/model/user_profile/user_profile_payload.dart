import 'dart:collection';
import 'package:crave_wave_app/components/firebase_fieldname.dart';
import 'package:crave_wave_app/typedef/user.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class UserProfilePayload extends MapView<String, String> {
  UserProfilePayload({
    required UserId userId,
    required String email,
    required String displayName,
  }) : super({
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.name: displayName,
          FirebaseFieldName.emailId: email,
        });
}
