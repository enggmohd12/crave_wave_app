import 'package:crave_wave_app/constants/keys.dart';
import 'package:crave_wave_app/view/login/login_view.dart';
import 'package:crave_wave_app/view/onboarding/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  final isOnboarding = prefs.getBool(isOnboardingDone) ?? false;
  runApp(MyApp(
    isOnboarding: isOnboarding,
  ));
}

class MyApp extends StatelessWidget {
  final bool isOnboarding;
  const MyApp({
    super.key,
    required this.isOnboarding,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      home: !isOnboarding ?  const OnBoardingView() : const LoginView(),
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




