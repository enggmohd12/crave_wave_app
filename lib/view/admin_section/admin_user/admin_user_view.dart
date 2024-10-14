import 'package:crave_wave_app/bloc/auth/auth_bloc.dart';
import 'package:crave_wave_app/bloc/auth/auth_event.dart';
import 'package:crave_wave_app/bloc/auth/auth_state.dart';
import 'package:crave_wave_app/bloc/menu/menu_bloc.dart';
import 'package:crave_wave_app/bloc/menu/menu_event.dart';
import 'package:crave_wave_app/bloc/menu/menu_state.dart';
import 'package:crave_wave_app/components/dialogs/logout_dialog.dart';
import 'package:crave_wave_app/components/dialogs/show_menu_error.dart';
import 'package:crave_wave_app/components/loading/loading_screen.dart';
import 'package:crave_wave_app/typedef/user.dart';
import 'package:crave_wave_app/view/admin_section/menu_view/menu_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminUserView extends StatefulWidget {
  const AdminUserView({super.key});

  @override
  State<AdminUserView> createState() => _AdminUserViewState();
}

class _AdminUserViewState extends State<AdminUserView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Your Order's"),
        backgroundColor: const Color.fromARGB(255, 255, 111, 0),
        actions: [
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              UserId userId = '';
              bool isAdmin = false;
              String userName = '';
              if (state is AuthStateLoggedIn) {
                userId = state.userid;
                isAdmin = state.isAdmin;
                userName = state.userName;
              }
              return Row(
                children: [
                  IconButton(
                      onPressed: () {
                        context
                            .read<MenuBloc>()
                            .add(GetMenuItemForUserEvent(userId: userId));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MenuView(
                              userId: userId,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.restaurant_menu_rounded)),
                  IconButton(
                      onPressed: () async {
                        final value = await showLogOutDialog(context);
                        if (value) {
                          if (context.mounted) {
                            context.read<AuthBloc>().add(
                                  AuthLogOutEvent(
                                    userId: userId,
                                    isAdmin: isAdmin,
                                    userName: userName
                                  ),
                                );
                          }
                        }
                      },
                      icon: const Icon(Icons.logout)),
                ],
              );
            },
          )
        ],
      ),
      body: BlocListener<MenuBloc, MenuState>(
        listener: (context, state) {
          if (state.isLoading) {
            LoadingScreen.instance().show(
              context: context,
              text: 'Loading...',
            );
          } else {
            LoadingScreen.instance().hide();
          }
          final menuError = state.menuError;
          if (menuError != null) {
            showMenuError(
              authError: menuError,
              context: context,
            );

            try{
              if (state.userId != null){
                context.read<MenuBloc>().add(GetMenuItemForUserEvent(userId: state.userId!));
              }              
            }catch(_){

            }
          }
        },
        child: const Center(
          child: Text('Admin Login'),
        ),
      ),
    );
  }
}
