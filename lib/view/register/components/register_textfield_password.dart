import 'package:crave_wave_app/components/color.dart';
import 'package:flutter/material.dart';

class RegisterTextFieldPassword extends StatefulWidget {
  final TextInputType type;
  final String hintext;
  final IconData iconData;
  final TextEditingController controller;
  final bool isVisible;
  final VoidCallback ontapped;
  const RegisterTextFieldPassword({
    super.key,
    required this.hintext,
    required this.iconData,
    required this.controller,
    required this.type,
    required this.isVisible,
    required this.ontapped,
  });

  @override
  State<RegisterTextFieldPassword> createState() =>
      _RegisterTextFieldPasswordState();
}

class _RegisterTextFieldPasswordState extends State<RegisterTextFieldPassword> {
  @override
  Widget build(BuildContext context) {
    //bool value = widget.isVisible;
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        //top: 12.0,
      ),
      child: TextField(
        cursorColor: backgroundColor,
        obscureText: !widget.isVisible,
        controller: widget.controller,
        keyboardType: widget.type,
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
            widget.iconData,
            color: Colors.grey,
          ),
          suffixIcon: IconButton(
            onPressed: widget.ontapped,
            icon: widget.isVisible
                ? const Icon(
                    Icons.visibility_off,
                    color: Colors.grey,
                  )
                : const Icon(
                    Icons.visibility,
                    color: Colors.grey,
                  ),
          ),
          hintText: widget.hintext,
          hintStyle: const TextStyle(color: Colors.grey),
          fillColor: Colors.grey.shade200,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
        ),
      ),
    );
  }
}
