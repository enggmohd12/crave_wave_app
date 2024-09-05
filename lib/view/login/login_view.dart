import 'package:crave_wave_app/bloc/auth/auth_bloc.dart';
import 'package:crave_wave_app/bloc/auth/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  'Hello, Foodie',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'asset/vector/human_food_vector.png',
                    height: 280,
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                margin: const EdgeInsets.only(left: 17),
                width: MediaQuery.of(context).size.width * 0.9,
                height: 55,
                decoration: BoxDecoration(
                  color: const Color(0xffd14545).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(const AuthGotoLoginView(),);
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginUserView(),),);
                  },
                  child: const Text(
                    'Login as User',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 17),
                width: MediaQuery.of(context).size.width * 0.9,
                height: 55,
                decoration: BoxDecoration(
                  color: const Color(0xffd14545).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(const AuthGotoRegisteringView());
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
          )),
    );
  }
}

// background-color: #ffcb43;
// background-image: linear-gradient(319deg, #ffcb43 0%, #ff6425 37%, #ff0016 100%);

// background-color: #d14545;
// background-image: linear-gradient(316deg, #d14545 0%, #ff9933 74%);
