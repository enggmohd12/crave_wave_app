import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crave_wave_app/bloc/auth/auth_event.dart';
import 'package:crave_wave_app/bloc/auth/auth_state.dart';
import 'package:crave_wave_app/components/auth_error.dart';
import 'package:crave_wave_app/components/firebase_collection_name.dart';
import 'package:crave_wave_app/components/firebase_fieldname.dart';
import 'package:crave_wave_app/constants/keys.dart';
import 'package:crave_wave_app/model/user_profile/user_profile_payload.dart';
import 'package:crave_wave_app/model/user_restaurant/user_restaurant_payload.dart';
import 'package:crave_wave_app/model/user_type/user_type_payload.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthStateInitialize(isLoading: false)) {
    on<AuthGotoLoginView>(
      (event, emit) {
        emit(
          const AuthStateLogOut(
            isLoading: false,
          ),
        );
      },
    );

    on<AuthGotoHelloFoodie>(
      (event, emit) {
        emit(
          const AuthStateBack(
            isLoading: false,
          ),
        );
      },
    );

    on<AuthGotoRegisteringView>(
      (event, emit) {
        emit(
          const AuthStateRegistring(
            isLoading: false,
          ),
        );
      },
    );

    on<AuthAppInitializeEvent>(
      (event, emit) async {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          final prefs = await SharedPreferences.getInstance();

          emit(AuthStateDoneOnboardingScreen(
            isLoading: false,
            isDone: prefs.getBool(isOnboardingDone) ?? false,
          ));
        } else {
          final isAdmin = await _getUserType(user.uid);
          final userName = await getUserName(user.uid);
          emit(AuthStateLoggedIn(
            isLoading: false,
            userid: user.uid,
            isAdmin: isAdmin,
            userName: userName,
          ));
        }
      },
    );

    on<AuthOnBoardingEvent>(
      (event, emit) async {
        try {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool(isOnboardingDone, true);
          emit(
            const AuthStateDoneOnboardingScreen(
              isDone: true,
              isLoading: false,
            ),
          );
        } catch (_) {}
      },
    );

    on<AuthRegistringUserEvent>(
      (event, emit) async {
        emit(const AuthStateRegistring(isLoading: true));

        try {
          final email = event.email;
          final displayName = event.userName;
          final password = event.password;
          final isAdmin = event.isAdmin;
          final restaurantName = event.restaurantName;

          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

          final currentUser = FirebaseAuth.instance.currentUser;
          if (currentUser != null) {
            await currentUser.updateDisplayName(displayName);
            await currentUser.sendEmailVerification();

            final userprofilePayload = UserProfilePayload(
              userId: currentUser.uid,
              email: email,
              displayName: displayName,
            );

            await FirebaseFirestore.instance
                .collection(
                  FirebaseCollectionName.userprofile,
                )
                .add(
                  userprofilePayload,
                );
            final userTypePayload = UserTypePayload(
              userId: currentUser.uid,
              isAdmin: isAdmin,
            );

            await FirebaseFirestore.instance
                .collection(
                  FirebaseCollectionName.usertype,
                )
                .add(
                  userTypePayload,
                );
            if (isAdmin) {
              final userRestarantPayload = UserRestaurantPayload(
                userId: currentUser.uid,
                restaurantName: restaurantName!,
              );

              await FirebaseFirestore.instance
                  .collection(FirebaseCollectionName.restaurant)
                  .add(
                    userRestarantPayload,
                  );
            }

            await FirebaseAuth.instance.signOut();

            emit(
              const AuthStateLogOut(
                isLoading: false,
                doneRegistrationMessage:
                    'We have sent you an email for verification. Kindly verify the email before login.',
                doneRegistrationTitle: 'Registration successful!',
              ),
            );
          }
        } on FirebaseAuthException catch (e) {
          emit(
            AuthStateRegistring(
              isLoading: false,
              authError: AuthError.from(e),
            ),
          );
        }
      },
    );

    on<AuthLoggedInEvent>(
      (event, emit) async {
        emit(const AuthStateLogOut(
          isLoading: true,
        ));

        final email = event.email;
        final password = event.password;
        try {
          final credentials =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );

          final user = credentials.user!;
          if (!user.emailVerified) {
            await FirebaseAuth.instance.signOut();
            emit(
              const AuthStateLogOut(
                isLoading: false,
                doneRegistrationMessage: 'Please verify your email',
                doneRegistrationTitle: 'Verfication required',
              ),
            );
          } else {
            final userId = user.uid;

            final type = await _getUserType(userId);
            final userName = await getUserName(user.uid);
            emit(
              AuthStateLoggedIn(
                isAdmin: type,
                isLoading: false,
                userid: userId,
                userName: userName,
              ),
            );
          }
        } on FirebaseAuthException catch (e) {
          emit(AuthStateLogOut(
            isLoading: false,
            authError: AuthError.from(e),
          ));
        }
      },
    );

    on<AuthLogOutEvent>(
      (event, emit) async {
        final userid = event.userId;
        final isAdmin = event.isAdmin;
        final userName = event.userName;

        emit(AuthStateLoggedIn(
          isAdmin: isAdmin,
          isLoading: true,
          userid: userid,
          userName: userName,
        ));

        await FirebaseAuth.instance.signOut();

        emit(const AuthStateDoneOnboardingScreen(
          isLoading: false,
          isDone: true,
        ));
      },
    );

    on<AuthForgotPasswordEvent>(
      (event, emit) async {
        emit(
          const AuthStateLogOut(
            isLoading: true,
          ),
        );

        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: event.emailID,
        );

        emit(
          const AuthStateLogOut(
            isLoading: false,
            doneRegistrationMessage:
                'We have send you an email to reset the password',
            doneRegistrationTitle: 'Message',
          ),
        );
      },
    );
  }

  Future<bool> _getUserType(String userId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.usertype,
          )
          .where(
            FirebaseFieldName.userId,
            isEqualTo: userId,
          )
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        var document = querySnapshot.docs.first;
        return document[FirebaseFieldName.userOrAdmin];
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }

  Future<String> getUserName(String userId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.userprofile,
          )
          .where(
            FirebaseFieldName.userId,
            isEqualTo: userId,
          )
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        var document = querySnapshot.docs.first;
        return document[FirebaseFieldName.name];
      } else {
        return '';
      }
    } catch (_) {
      return '';
    }
  }
}
