import 'package:crave_wave_app/components/color.dart';
import 'package:crave_wave_app/view/login/login_user_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginLink extends StatelessWidget {
  const LoginLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
            text: TextSpan(children: [
          const TextSpan(
            text: 'Already registered? ',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'Login Here',
            style: const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginUserView(),
                  ),
                );
              },
          ),
        ]))
      ],
    );
  }
}
