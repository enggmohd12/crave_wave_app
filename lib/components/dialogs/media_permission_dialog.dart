import 'package:crave_wave_app/components/dialogs/generic_dialogs.dart';
import 'package:flutter/material.dart' show BuildContext;

Future<bool> showMediaPermissionDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Permission required',
    content: 'To access the media file that will be used as an item photo, permission is needed.',
    optionsBuilder: () => {
      'Cancel': false,
      'Open setting': true,
    },
  ).then(
    (value) => value ?? false,
  );
}