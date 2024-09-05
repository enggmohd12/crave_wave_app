import 'package:crave_wave_app/bloc/auth/auth_bloc.dart';
import 'package:crave_wave_app/bloc/auth/auth_event.dart';
import 'package:crave_wave_app/bloc/auth/auth_state.dart';
import 'package:crave_wave_app/components/loading/loading_screen.dart';
import 'package:crave_wave_app/view/login/login_user_view.dart';
import 'package:crave_wave_app/view/login/login_view.dart';
import 'package:crave_wave_app/view/onboarding/onboarding_view.dart';
import 'package:crave_wave_app/view/register/register_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //final prefs = await SharedPreferences.getInstance();
  //final isOnboarding = prefs.getBool(isOnboardingDone) ?? false;
  runApp(const MyApp(
    //isOnboarding: isOnboarding,
  ));
}

class MyApp extends StatelessWidget {
  //final bool isOnboarding;
  const MyApp({
    super.key,
    //required this.isOnboarding,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc()
        ..add(
          const AuthAppInitializeEvent(),
        ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: false),
        home: BlocConsumer<AuthBloc,AuthState>(
          listener: (context, state) {
            if (state.isLoading) {
              LoadingScreen.instance().show(
                context: context,
                text: 'Loading...',
              );
            } else {
              LoadingScreen.instance().hide();
            }
          },
          builder: (context, state) {
            if (state is AuthStateDoneOnboardingScreen){
              if (state.isDone){
                return const LoginView();
              } else{
                return const OnBoardingView();
              }
            } else if (state is AuthStateLoggedIn){
              return Container();
            } else if (state is AuthStateLogOut){
              return const LoginUserView();
            } else if (state is AuthStateRegistring){
              return const RegisterView();
            } else if (state is AuthStateBack){
              return const LoginView();
            } else{
              return Container();
            }
          },
        ),
        //home: !isOnboarding ? const OnBoardingView() : const LoginView(),
      ),
    );
  }
}

class CheckingAnimation extends StatefulWidget {
  const CheckingAnimation({super.key});

  @override
  State<CheckingAnimation> createState() => _CheckingAnimationState();
}

class _CheckingAnimationState extends State<CheckingAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('asset/animation/loading_taco.json'),
      ),
    );
  }
}
