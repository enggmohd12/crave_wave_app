import 'package:crave_wave_app/components/color.dart';
import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final TextInputType type;
  final String hintext;
  final IconData iconData;
  final TextEditingController controller;
  const LoginTextField({
    super.key,
    required this.hintext,
    required this.iconData,
    required this.controller,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 22.0,
        right: 22.0,
        top: 15.0,
      ),
      child: TextField(
        cursorColor: backgroundColor,
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(width: 1, color: Colors.grey.shade400)),
          enabled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(width: 1, color: Colors.grey.shade200),
          ),
          prefixIcon: Icon(
            iconData,
            color: Colors.grey,
          ),
          hintText: hintext,
          hintStyle: const TextStyle(color: Colors.grey),
          fillColor: Colors.grey.shade200,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
        ),
      ),
    );
  }
}