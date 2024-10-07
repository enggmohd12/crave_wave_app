import 'package:crave_wave_app/components/dialogs/generic_dialogs.dart';
import 'package:flutter/material.dart' show BuildContext;

Future<bool> showLocationPermissionDeniedDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Message',
    content: 'For delivery of food we need to access your loction but your location is off.Do you want to enabled it?',
    optionsBuilder: () => {
      'Cancel': false,
      'OK': true,
    },
  ).then(
    (value) => value ?? false,
  );
}