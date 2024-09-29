import 'dart:async';
import 'package:crave_wave_app/components/loading/loading_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen {
  LoadingScreen._sharedInstance();
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  factory LoadingScreen.instance() => _shared;

  LoadingScreenController? controller;

  void show({
    required BuildContext context,
    required String text,
  }) {
    if (controller?.update(text) ?? false) {
      return;
    } else {
      controller = showOverlay(
        context: context,
        text: text,
      );
    }
  }

  void hide() {
    controller?.close();
    controller = null;
  }

  LoadingScreenController showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final text1 = StreamController<String>();
    text1.add(text);

    final state = Overlay.of(context);
    //final renderBox = context.findRenderObject() as RenderBox;
    //final size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Lottie.asset(
              'asset/animation/loading_taco.json',
              height: 160,
              // width: 70,
            ),
          ),
        );
      },
    );

    state.insert(overlay);

    return LoadingScreenController(
      close: () {
        text1.close();
        overlay.remove();
        return true;
      },
      update: (text) {
        text1.add(text);
        return true;
      },
    );
  }
}
