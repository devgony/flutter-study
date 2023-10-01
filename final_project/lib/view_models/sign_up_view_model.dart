import 'dart:async';

import 'package:final_project/view_models/user_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../repositories/authentication_repository.dart';
import '../utils.dart';
import '../views/home_screen.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepository);
  }

  Future<void> signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = const AsyncValue.loading();
    // final form = ref.read(signUpForm);
    state = await AsyncValue.guard(() async {
      final UserCredential userCredential = await _authRepo.emailSignUp(
        email,
        password,
      );
      await ref.read(usersProvider.notifier).createUser(userCredential);
    });
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.go(HomeScreen.routeURL);
    }
  }
}

final signUpForm = StateProvider((ref) => {});

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
