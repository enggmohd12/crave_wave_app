import 'package:crave_wave_app/bloc/auth/auth_bloc.dart';
import 'package:crave_wave_app/bloc/auth/auth_event.dart';
import 'package:crave_wave_app/bloc/auth/auth_state.dart';
import 'package:crave_wave_app/components/dialogs/logout_dialog.dart';
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
              if (state is AuthStateLoggedIn) {
                userId = state.userid;
                isAdmin = state.isAdmin;
              }
              return Row(
                children: [
                  IconButton(
                      onPressed: () {
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
      body: const Center(
        child: Text('Admin Login'),
      ),
    );
  }
}
