import 'dart:io';
import 'package:crave_wave_app/components/color.dart';
import 'package:crave_wave_app/typedef/user.dart';
import 'package:crave_wave_app/view/admin_section/menu_view/add_menu.dart';
import 'package:flutter/material.dart';

class MenuView extends StatefulWidget {
  final UserId userId;
  const MenuView({
    super.key,
    required this.userId,
  });

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        backgroundColor: backgroundColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // if (Platform.isIOS)
          SizedBox(
            height: Platform.isIOS ? height * 0.78 : height * 0.82,
            child: const Center(
              child: Text('No data'),
            ),
          ),
          Expanded(
              child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: const BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddMenuView(
                            userId: widget.userId,
                          ),
                        ));
                  },
                  child: const Text(
                    'Add Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
