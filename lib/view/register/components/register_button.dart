import 'package:crave_wave_app/components/color.dart';
import 'package:flutter/material.dart';

class RegisterButton extends StatefulWidget {
  final double width;
  final VoidCallback onPressed;
  final String text;
  const RegisterButton({
    super.key,
    required this.onPressed,
    required this.width,
    required this.text,
  });

  @override
  State<RegisterButton> createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<RegisterButton> {
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
        child: Text(
          widget.text,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}
