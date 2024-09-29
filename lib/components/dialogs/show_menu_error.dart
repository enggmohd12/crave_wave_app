import 'package:crave_wave_app/components/dialogs/generic_dialogs.dart';
import 'package:flutter/material.dart' show BuildContext;

Future<void> showMenuError({
  required String authError,
  required BuildContext context,
}) {
  return showGenericDialog<void>(
    context: context,
    title: 'Error occured',
    content: authError,
    optionsBuilder: () => {
      'OK': true,
    },
  );
}