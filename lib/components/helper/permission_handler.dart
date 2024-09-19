import 'dart:io';

import 'package:crave_wave_app/components/dialogs/media_permission_dialog.dart';
import 'package:crave_wave_app/components/dialogs/registring_dialog.dart';
import 'package:crave_wave_app/components/helper/image_picker_helper.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:instanews_app/state/image_uploads/helper/image_picker_handler.dart';

Future<File?> getPermission(BuildContext context) async {
  await Permission.photos.request();
  await Permission.storage.request();
  if (Platform.isIOS) {
    var status1 = await Permission.photos.status;
    if (status1.isGranted) {
      final file = await ImagePickerHandler.pickImageFromGallery();
      if (file == null) {
        return null;
      }
      return file;
    } else if (status1.isPermanentlyDenied || status1.isDenied) {
      if (context.mounted) {
        final shouldOpenSetting = await showMediaPermissionDialog(context);
        if (shouldOpenSetting) {
          openAppSettings();
        } else {
          if (context.mounted) {
            await showRegistrationDialog(
                context, 'Permission', 'No permission given');
          }
        }
      }
    }
  } else {
    var status2 = await Permission.storage.status;
    var status1 = await Permission.photos.status;
    if (status1.isGranted || status2.isGranted) {
      final file = await ImagePickerHandler.pickImageFromGallery();
      if (file == null) {
        return null;
      }
      return file;
    } else if (status1.isPermanentlyDenied ||
        status1.isDenied ||
        status2.isPermanentlyDenied ||
        status2.isDenied) {
      if (context.mounted) {
        final shouldOpenSetting = await showMediaPermissionDialog(context);
        if (shouldOpenSetting) {
          openAppSettings();
        } else {
          if (context.mounted) {
            await showRegistrationDialog(
                context, 'Permission', 'No permission given');
          }
        }
      }
      return null;
    }
  }

  return null;
  //
  //return true;
}
