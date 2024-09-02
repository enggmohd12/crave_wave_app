import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xffd14545),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color(0xffd14545),
              Color(0xffff9933),
            ],
            stops: [0, 0.74],
          ),
        ),
      ),
    );
  }
}