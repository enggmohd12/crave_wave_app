import 'package:crave_wave_app/bloc/auth/auth_bloc.dart';
import 'package:crave_wave_app/bloc/auth/auth_event.dart';
import 'package:crave_wave_app/components/dialogs/registring_dialog.dart';
import 'package:crave_wave_app/components/validators/email_validator.dart';
import 'package:crave_wave_app/view/register/components/register_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
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
                        Navigator.pop(context);
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
            SizedBox(
              height: height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child:
                  Text('Please enter your Email below to recover your password',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                          )),
            ),
            SizedBox(
              height: height * 0.020,
            ),
            RegisterTextField(
              hintext: 'Email Address',
              iconData: Icons.email,
              controller: emailController,
              type: TextInputType.emailAddress,
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Container(
              //margin: const EdgeInsets.only(left: 1),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 55,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 246, 52, 52).withOpacity(0.5),
                borderRadius: BorderRadius.circular(
                  8,
                ),
              ),
              child: TextButton(
                onPressed: () async{
                  if (emailController.text != '') {
                    if (validateEmail(emailController.text)) {
                      context.read<AuthBloc>().add(
                            AuthForgotPasswordEvent(
                                emailID: emailController.text),
                          );
                      emailController.clear();    
                    } else {
                      showRegistrationDialog(
                          context, 'Validation Error', 'Email ID is invalid');
                    }
                  } else {
                    showRegistrationDialog(
                        context, 'Validation Error', 'Email required');
                  }

                  //Navigator.push(context,MaterialPageRoute(builder: (context) => const RegisterView(),),);
                },
                child: const Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
