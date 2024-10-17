import 'package:crave_wave_app/components/color.dart';
import 'package:flutter/material.dart';

class CategoryView extends StatefulWidget {
  final String itemcategory;
  const CategoryView({
    super.key,
    required this.itemcategory,
  });

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: const Text(
          'Category Item List',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
