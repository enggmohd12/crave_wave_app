import 'package:crave_wave_app/components/dialogs/generic_dialogs.dart';
import 'package:flutter/material.dart' show BuildContext;

Future<bool> showRegistrationDialog(
  BuildContext context,
  String title,
  String message,
) {
  return showGenericDialog<bool>(
    context: context,
    title: title,
    content: message,
    optionsBuilder: () => {
      'OK': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
