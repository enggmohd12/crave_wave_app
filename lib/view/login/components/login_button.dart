import 'package:crave_wave_app/components/color.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.width,
  });
  final VoidCallback onPressed;
  final String text;
  final double width;
  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 55,
      width: widget.width,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton(
        onPressed: widget.onPressed,
        child:  Text(
          widget.text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18
          ),
        ),
      ),
    );
  }
}
