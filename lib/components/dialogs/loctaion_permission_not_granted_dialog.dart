import 'package:crave_wave_app/components/dialogs/generic_dialogs.dart';
import 'package:flutter/material.dart' show BuildContext;

Future<bool> showLocationNotOnDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Message',
    content: 'For delivery of food we need to permission to access your loction .You can enable the location in App setting?',
    optionsBuilder: () => {
      'Cancel': false,
      'App Setting': true,
    },
  ).then(
    (value) => value ?? false,
  );
}