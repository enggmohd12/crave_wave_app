import 'package:crave_wave_app/bloc/auth/auth_bloc.dart';
import 'package:crave_wave_app/bloc/auth/auth_event.dart';
import 'package:crave_wave_app/bloc/auth/auth_state.dart';
import 'package:crave_wave_app/components/color.dart';
import 'package:crave_wave_app/typedef/user.dart';
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
        title: const Text('Admi USer'),
        backgroundColor: primaryColor,
        actions: [
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              UserId userId = '';
              bool isAdmin = false;
              if (state is AuthStateLoggedIn) {
                userId = state.userid;
                isAdmin = state.isAdmin;
              }
              return IconButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          AuthLogOutEvent(
                            userId: userId,
                            isAdmin: isAdmin,
                          ),
                        );
                  },
                  icon: const Icon(Icons.logout));
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
