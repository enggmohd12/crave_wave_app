import 'package:crave_wave_app/components/color.dart';
import 'package:crave_wave_app/typedef/user.dart';
import 'package:crave_wave_app/view/user/component/tab_button.dart';
import 'package:crave_wave_app/view/user/home/user_view.dart';
import 'package:crave_wave_app/view/user/menu/menu_view.dart';
import 'package:flutter/material.dart';

class UserMainTabView extends StatefulWidget {
  final UserId userId;
  final String userName;
  const UserMainTabView({
    super.key,
    required this.userId,
    required this.userName,
  });

  @override
  State<UserMainTabView> createState() => _UserMainTabViewState();
}

class _UserMainTabViewState extends State<UserMainTabView> {
  int selectedtab = 2;
  PageStorageBucket storageBucket = PageStorageBucket();
  late Widget selectPageView;

  @override
  void initState() {
    selectPageView = UserView(
      userId: widget.userId,
      userName: widget.userName,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: storageBucket,
        child: selectPageView,
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: SizedBox(
          height: 60,
          width: 60,
          child: FloatingActionButton(
            onPressed: () {
              if (selectedtab != 2) {
                selectedtab = 2;
                selectPageView = UserView(
                  userId: widget.userId,
                  userName: widget.userName,
                );
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
                      selectPageView = MenuViewUser(userId: widget.userId,);
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
                const SizedBox(
                  width: 60,
                ),
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
