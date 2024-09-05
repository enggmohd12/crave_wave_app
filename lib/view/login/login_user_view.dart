import 'dart:io';

import 'package:crave_wave_app/bloc/auth/auth_bloc.dart';
import 'package:crave_wave_app/bloc/auth/auth_event.dart';
import 'package:crave_wave_app/view/login/components/forgot_password.dart';
import 'package:crave_wave_app/view/login/components/login_button.dart';
import 'package:crave_wave_app/view/login/components/login_divider.dart';
import 'package:crave_wave_app/view/login/components/login_textfield.dart';
import 'package:crave_wave_app/view/login/components/signup_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginUserView extends StatefulWidget {
  const LoginUserView({super.key});

  @override
  State<LoginUserView> createState() => _LoginUserViewState();
}

class _LoginUserViewState extends State<LoginUserView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        //constraints: BoxConstraints(minHeight: height),
        height: height,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: height * 0.05,
            ),
            SizedBox(
              height: height * 0.1,
              child: Stack(
                children: [
                  // Left aligned icon button
                  Positioned(
                    left: 8.0,
                    top: 0,
                    bottom: 0,
                    child: IconButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(const AuthGotoHelloFoodie());
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (Platform.isIOS)
              SizedBox(
                height: height * 0.05,
              ),
            if (Platform.isAndroid)
              SizedBox(
                height: height * 0.16,
              ),
            const Text(
              'Login Here',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: height * 0.1,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70),
                    topRight: Radius.circular(70),
                  ),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.08,
                      ),
                      LoginTextField(
                        hintext: 'Email ID',
                        iconData: Icons.email,
                        controller: emailController,
                        type: TextInputType.emailAddress,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          top: 12.0,
                        ),
                        child: TextField(
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.grey.shade400)),
                            enabled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(
                                  width: 1, color: Colors.grey.shade200),
                            ),
                            prefixIcon: const Icon(
                              Icons.shield,
                              color: Colors.grey,
                            ),
                            hintText: 'Password',
                            hintStyle: const TextStyle(color: Colors.grey),
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 20.0),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                            ),
                          ),
                          obscureText: isVisible,
                        ),
                      ),
                      ForgotLinkButton(
                        text: 'Forgot Password?',
                        onPressed: () {},
                      ),
                      LoginButton(
                        onPressed: () {},
                        text: 'Login',
                        width: width * 0.9,
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      const LoginDivider(),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      const SignUpLink()
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
