import 'dart:io';

import 'package:crave_wave_app/bloc/auth/auth_bloc.dart';
import 'package:crave_wave_app/bloc/auth/auth_event.dart';
import 'package:crave_wave_app/components/color.dart';
import 'package:crave_wave_app/components/dialogs/registring_dialog.dart';
import 'package:crave_wave_app/components/validators/email_validator.dart';
import 'package:crave_wave_app/components/validators/password_validators.dart';
import 'package:crave_wave_app/view/login/components/login_divider.dart';
import 'package:crave_wave_app/view/register/components/login_link_buton.dart';
import 'package:crave_wave_app/view/register/components/register_button.dart';
import 'package:crave_wave_app/view/register/components/register_textfield.dart';
import 'package:crave_wave_app/view/register/components/register_textfield_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final restaurantController = TextEditingController();
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

            SizedBox(
              height: height * 0.03,
              child: Stack(
                children: [
                  // Left aligned icon button
                  Positioned(
                    left: 8.0,
                    top: 0,
                    bottom: 0,
                    child: IconButton(
                      onPressed: () {
                        context
                            .read<AuthBloc>()
                            .add(const AuthGotoHelloFoodie());
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
            // if (Platform.isIOS)
            //   SizedBox(
            //     height: height * 0.01,
            //   ),
            if (Platform.isAndroid)
              SizedBox(
                height: height * 0.03,
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
              height: height * 0.02,
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
                        height: height * 0.02,
                      ),
                      Visibility(
                        visible: value,
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          child: RegisterTextField(
                            hintext: 'Restaurant Name',
                            iconData: Icons.restaurant,
                            controller: restaurantController,
                            type: TextInputType.text,
                          ),
                        ),
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
                        onPressed: () {
                          final returnvalue = _validation();
                          final isValid = returnvalue.$1;
                          final mapData = returnvalue.$2;
                          if (isValid) {
                            context
                                .read<AuthBloc>()
                                .add(AuthRegistringUserEvent(
                                  email: emailController.text,
                                  password: passworController.text,
                                  userName: usernameController.text,
                                  isAdmin: value,
                                  restaurantName:
                                      value ? restaurantController.text : null,
                                ));
                          } else {
                            final title = mapData['title'];
                            final message = mapData['message'];
                            showRegistrationDialog(
                              context,
                              title,
                              message,
                            );
                          }
                        },
                        width: MediaQuery.of(context).size.width * 0.9,
                        text: 'Register',
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: LoginDivider(),
                      ),
                      SizedBox(
                        height: height * 0.02,
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

  (bool, Map<String, dynamic>) _validation() {
    (bool, Map<String, dynamic>) returnvalue = (true, {});

    if (usernameController.text == '') {
      return returnvalue =
          (false, {'title': 'Validation Error', 'message': 'User name required'});
    }

    if (emailController.text == '') {
      return returnvalue =
          (false, {'title': 'Validation Error', 'message': 'Email required'});
    } else {
      final value = validateEmail(emailController.text);
      if (!value) {
        return returnvalue = (
          false,
          {'title': 'Validation Error', 'message': 'Email is invalid'}
        );
      }
    }

    if (passworController.text == '') {
      return returnvalue = (
        false,
        {
          'title': 'Validation Error',
          'message': 'Password required',
        }
      );
    } else {
      final value = passwordValidator(passworController.text);
      if (!value) {
        return returnvalue = (
          false,
          {
            'title': 'Validation Error',
            'message':
                'Passwords should contain at least one capital letter, a small letter, a special character, and a number.',
          }
        );
      }
    }

    if (confirmController.text == '') {
      return returnvalue = (
        false,
        {
          'title': 'Validation Error',
          'message': 'Confirm Password required',
        }
      );
    } else {
      final value = passwordValidator(confirmController.text);
      if (!value) {
        return returnvalue = (
          false,
          {
            'title': 'Validation Error',
            'message':
                'Passwords should contain at least one capital letter, a small letter, a special character, and a number.',
          }
        );
      }

      if (passworController.text != confirmController.text) {
        return returnvalue = (
          false,
          {
            'title': 'Validation Error',
            'message': 'Password and Confirm Password is not same.',
          }
        );
      }
    }

    if (value) {
      if (restaurantController.text == '') {
        return returnvalue = (
          false,
          {'title': 'Validation Error', 'message': 'Restaurant name required'}
        );
      }
    }

    return returnvalue;
  }
}
