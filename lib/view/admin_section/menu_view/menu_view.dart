import 'dart:io';
import 'package:crave_wave_app/bloc/menu/menu_bloc.dart';
import 'package:crave_wave_app/bloc/menu/menu_state.dart';
import 'package:crave_wave_app/components/color.dart';
import 'package:crave_wave_app/typedef/user.dart';
import 'package:crave_wave_app/view/admin_section/menu_view/add_menu.dart';
import 'package:crave_wave_app/view/admin_section/menu_view/components/list_menu_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            child: BlocBuilder<MenuBloc, MenuState>(
              builder: (context, state) {
                if (state is MenuItemsState) {
                  final data = state.menuItem;
                  return ListView.builder(
                    itemCount: data.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      //final indexvalue = data.elementAt(index);
                      //indexvalue.
                      return ListUserMenu();
                    },
                  );
                } else {
                  return Text('Fetching data');
                }
              },
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
