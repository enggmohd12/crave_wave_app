import 'dart:io';

import 'package:crave_wave_app/components/color.dart';
import 'package:crave_wave_app/view/login/components/login_divider.dart';
import 'package:crave_wave_app/view/register/components/login_link_buton.dart';
import 'package:crave_wave_app/view/register/components/register_button.dart';
import 'package:crave_wave_app/view/register/components/register_textfield.dart';
import 'package:crave_wave_app/view/register/components/register_textfield_password.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passworController = TextEditingController();
  final confirmController = TextEditingController();
  bool isVisibleConfirm = false;
  bool isVisible = false;
  bool value = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: height,
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
            if (Platform.isIOS)
              SizedBox(
                height: height * 0.07,
                child: Stack(
                  children: [
                    // Left aligned icon button
                    Positioned(
                      left: 8.0,
                      top: 0,
                      bottom: 0,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
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
                height: height * 0.01,
              ),
            if (Platform.isAndroid)
              SizedBox(
                height: height * 0.09,
              ),
            const Text(
              'Register Here',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      70,
                    ),
                    topRight: Radius.circular(
                      70,
                    ),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.1,
                      ),
                      RegisterTextField(
                        hintext: 'Username',
                        iconData: Icons.person,
                        controller: usernameController,
                        type: TextInputType.name,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      RegisterTextField(
                        hintext: 'Email ID',
                        iconData: Icons.email,
                        controller: emailController,
                        type: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      RegisterTextFieldPassword(
                        hintext: 'Password',
                        iconData: Icons.shield,
                        controller: passworController,
                        type: TextInputType.text,
                        isVisible: isVisible,
                        ontapped: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      RegisterTextFieldPassword(
                        hintext: 'Confirm Password',
                        iconData: Icons.shield,
                        controller: confirmController,
                        type: TextInputType.text,
                        isVisible: isVisibleConfirm,
                        ontapped: () {
                          setState(() {
                            isVisibleConfirm = !isVisibleConfirm;
                          });
                        },
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Checkbox(
                              activeColor: primaryColor,
                              value: value,
                              onChanged: (value) {
                                setState(() {
                                  this.value = !this.value;
                                });
                              },
                            ),
                            const Text('Are you a restaurant owner?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      RegisterButton(
                        onPressed: () {},
                        width: MediaQuery.of(context).size.width * 0.9,
                        text: 'Register',
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: LoginDivider(),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      const LoginLink()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
