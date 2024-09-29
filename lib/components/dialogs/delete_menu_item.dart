import 'package:crave_wave_app/components/dialogs/generic_dialogs.dart';
import 'package:flutter/material.dart' show BuildContext;

Future<bool> showDeleteMenuDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Delete Menu Item',
    content: 'Are you sure you want to delete menu item?',
    optionsBuilder: () => {
      'Cancel': false,
      'Yes': true,
    },
  ).then(
    (value) => value ?? false,
  );
}