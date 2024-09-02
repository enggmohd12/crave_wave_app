import 'package:crave_wave_app/components/color.dart';
import 'package:crave_wave_app/view/register/register_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpLink extends StatelessWidget {
  const SignUpLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
            text: TextSpan(children: [
          const TextSpan(
            text: 'Not registered? ',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'Sign Up',
            style: const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterView(),
                  ),
                );
              },
          ),
        ]))
      ],
    );
  }
}
