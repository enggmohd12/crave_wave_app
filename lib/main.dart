import 'package:crave_wave_app/bloc/auth/auth_bloc.dart';
import 'package:crave_wave_app/bloc/auth/auth_event.dart';
import 'package:crave_wave_app/bloc/auth/auth_state.dart';
import 'package:crave_wave_app/bloc/menu/menu_bloc.dart';
import 'package:crave_wave_app/components/dialogs/registring_dialog.dart';
import 'package:crave_wave_app/components/dialogs/show_auth_error.dart';
import 'package:crave_wave_app/components/loading/loading_screen.dart';
import 'package:crave_wave_app/view/admin_section/admin_user/admin_user_view.dart';
import 'package:crave_wave_app/view/login/login_user_view.dart';
import 'package:crave_wave_app/view/login/login_view.dart';
import 'package:crave_wave_app/view/onboarding/onboarding_view.dart';
import 'package:crave_wave_app/view/register/register_view.dart';
import 'package:crave_wave_app/view/user/user_main_tab/user_main_tab_view.dart';
import 'package:crave_wave_app/view/user/user_view.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()
            ..add(
              const AuthAppInitializeEvent(),
            ),
        ),
        BlocProvider<MenuBloc>(
          create: (context) => MenuBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: false),
        home: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.isLoading) {
              LoadingScreen.instance().show(
                context: context,
                text: 'Loading...',
              );
            } else {
              LoadingScreen.instance().hide();
            }

            final authError = state.authError;
            if (authError != null) {
              showAuthError(
                authError: authError,
                context: context,
              );
            }

            if (state is AuthStateLogOut) {
              final doneMessage = state.doneRegistrationMessage;
              final doneTitle = state.doneRegistrationTitle;
              if (doneMessage != null && doneTitle != null) {
                showRegistrationDialog(
                  context,
                  doneTitle,
                  doneMessage,
                );
              }
            }
          },
          builder: (context, state) {
            if (state is AuthStateDoneOnboardingScreen) {
              if (state.isDone) {
                return const LoginView();
              } else {
                return const OnBoardingView();
              }
            } else if (state is AuthStateLoggedIn) {
              if (state.isAdmin) {
                return const UserMainTabView(); // Need to change back to AdminUserView() after creating the UI for User
              } else {
                return const UserView();
              }
            } else if (state is AuthStateLogOut) {
              return const LoginUserView();
            } else if (state is AuthStateRegistring) {
              return const RegisterView();
            } else if (state is AuthStateBack) {
              return const LoginView();
            } else if (state is AuthStateInitialize) {
              return Scaffold(
                body: Center(
                  child: Lottie.asset(
                    'asset/animation/loading_taco.json',
                    height: 160,
                  ),
                ),
              );
            } else {
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
