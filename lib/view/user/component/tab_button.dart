import 'package:crave_wave_app/components/color.dart';
import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final bool isSelected;
  final IconData icon;
  const TabButton({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? backgroundColor : Colors.grey,
          ),
          Text(
            title,
            style: TextStyle(
              color: isSelected ? backgroundColor : Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w200,
            ),
          )
        ],
      ),
    );
  }
}
