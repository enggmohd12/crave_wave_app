import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final String message;
  const CustomDivider({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Divider(
              color: Colors.grey.shade500,
              //thickness: 2,
            ),
          ),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              message,
              style:
                  const TextStyle(fontWeight: FontWeight.w600, color: Colors.black38),
            ),
          ),
          Expanded(
            child: Divider(
              color: Colors.grey.shade500,
              //thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
