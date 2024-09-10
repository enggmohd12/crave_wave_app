import 'package:flutter/material.dart';

class TextFieldAddMenu extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final String hintext;
  const TextFieldAddMenu({
    super.key,
    required this.controller,
    required this.hintext,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        //top: 12.0,
      ),
      child: TextField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(width: 1, color: Colors.grey.shade400)),
          enabled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(width: 1, color: Colors.grey.shade200),
          ),
          hintText: hintext,
          hintStyle: const TextStyle(color: Colors.grey),
          fillColor: Colors.grey.shade200,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10),
        ),
      ),
    );
  }
}
