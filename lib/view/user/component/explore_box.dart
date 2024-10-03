import 'package:flutter/material.dart';

class ExploreBox extends StatelessWidget {
  final String image;
  final String name;
  const ExploreBox({
    super.key,
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        
      },
      child: Container(
        height: 70,
        width: 70,
        margin: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade200,
            boxShadow: const [
              BoxShadow(
                blurRadius: 3,
                color: Colors.black38,
                spreadRadius: 0.5,
              )
            ]),
        child: Center(
            child: Image.asset(
          image,
          width: 35,
          height: 35,
        )),
      ),
    );
  }
}
