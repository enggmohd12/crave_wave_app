import 'dart:collection';

import 'package:crave_wave_app/components/firebase_fieldname.dart';
import 'package:crave_wave_app/typedef/user.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class UserProfileModel extends MapView<String, String?> {
  final UserId userId;
  final String displayName;
  final String email;

  UserProfileModel({
    required this.userId,
    required this.displayName,
    required this.email,
  }) : super({
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.name: displayName,
          FirebaseFieldName.emailId:email,
        });
}
