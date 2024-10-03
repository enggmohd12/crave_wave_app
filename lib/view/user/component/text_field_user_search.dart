import 'package:crave_wave_app/components/color.dart';
import 'package:flutter/material.dart';

class UserSearchFoodTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const UserSearchFoodTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: backgroundColor,
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: Colors.grey.shade400)),
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 1, color: Colors.grey.shade200),
        ),
        prefixIcon: const Icon(Icons.search,color: backgroundColor,),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
      ),
    );
  }
}
