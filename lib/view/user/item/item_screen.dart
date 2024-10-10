import 'package:crave_wave_app/model/menu/menu_item.dart';
import 'package:flutter/material.dart';

class ItemScreen extends StatefulWidget {
  final MenuItem menuDetails;

  const ItemScreen({
    super.key,
    required this.menuDetails,
  });

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Item'),
        backgroundColor: const Color.fromARGB(255, 255, 111, 0),
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
