import 'package:crave_wave_app/components/color.dart';
import 'package:flutter/material.dart';

class VegNonVegOption extends StatefulWidget {
  final bool isVeg;
  final VoidCallback onVegPressed;
  final VoidCallback onNonVegPressed;
  const VegNonVegOption({
    super.key,
    required this.isVeg,
    required this.onNonVegPressed,
    required this.onVegPressed,
  });

  @override
  State<VegNonVegOption> createState() => _VegNonVegOptionState();
}

class _VegNonVegOptionState extends State<VegNonVegOption> {
  //bool isVeg = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 100,
      width: 190.5,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 100),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: widget.onVegPressed,
            // onTap: () {
            //   setState(() {
            //     widget.isVeg = !isVeg;
            //   });
            // },
            child: Container(
              height: 50,
              width: 95,
              decoration: BoxDecoration(
                  border: const Border(
                    right: BorderSide(color: Colors.black),
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  color: widget.isVeg ? backgroundColor : Colors.white),
              child: Center(
                child: Text(
                  'Veg',
                  style: TextStyle(
                    color: widget.isVeg ? Colors.white : backgroundColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: widget.onNonVegPressed,
            // onTap: () {
            //   setState(() {
            //     isVeg = !isVeg;
            //   });
            // },
            child: Container(
              height: 50,
              width: 93.5,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  color: !widget.isVeg ? backgroundColor : Colors.white),
              child: Center(
                child: Text(
                  'Non-Veg',
                  style: TextStyle(
                    color: !widget.isVeg ? Colors.white : backgroundColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
