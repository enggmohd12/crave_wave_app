import 'package:crave_wave_app/components/color.dart';
import 'package:crave_wave_app/view/user/component/tab_button.dart';
import 'package:crave_wave_app/view/user/home/user_view.dart';
import 'package:flutter/material.dart';

class UserMainTabView extends StatefulWidget {
  const UserMainTabView({super.key});

  @override
  State<UserMainTabView> createState() => _UserMainTabViewState();
}

class _UserMainTabViewState extends State<UserMainTabView> {
  int selectedtab = 2;
  PageStorageBucket storageBucket = PageStorageBucket();
  Widget selectPageView = const UserView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: storageBucket,
        child: selectPageView,
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          onPressed: () {
            if (selectedtab != 2) {
              selectedtab = 2;
              selectPageView = const UserView();
            }

            if (mounted) {
              setState(() {});
            }
          },
          backgroundColor:
              selectedtab == 2 ? backgroundColor : Colors.grey.shade300,
          child: const Icon(
            Icons.home,
            size: 40,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: Colors.white,
        // color: Colors.pink,
        height: 60,
        shadowColor: Colors.black,
        shape: const CircularNotchedRectangle(),
        elevation: 1,
        notchMargin: 13,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          //height: 50,
          //color: Colors.white,
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TabButton(
                  onTap: () {
                    if (selectedtab != 0) {
                      selectedtab = 0;
                      selectPageView = Container();
                    }
            
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  isSelected: selectedtab == 0,
                  title: 'Menu',
                  icon: Icons.fastfood,
                ),
                TabButton(
                  onTap: () {
                    if (selectedtab != 1) {
                      selectedtab = 1;
                      selectPageView = Container();
                    }
            
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  isSelected: selectedtab == 1,
                  title: 'Orders',
                  icon: Icons.restaurant_menu_outlined,
                ),
                const SizedBox(width: 60,),
                TabButton(
                  onTap: () {
                    if (selectedtab != 3) {
                      selectedtab = 3;
                      selectPageView = Container();
                    }
            
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  isSelected: selectedtab == 3,
                  title: 'Profile',
                  icon: Icons.person_4,
                ),
                TabButton(
                  onTap: () {
                    if (selectedtab != 4) {
                      selectedtab = 4;
                      selectPageView = Container();
                    }
            
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  isSelected: selectedtab == 4,
                  title: 'About',
                  icon: Icons.info,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
