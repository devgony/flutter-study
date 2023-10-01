import 'package:final_project/utils.dart';
import 'package:final_project/widgets/fire.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../constants/gaps.dart';
import '../view_models/sign_up_view_model.dart';
import '../widgets/form_button.dart';
import 'login_screen.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static const routeName = 'sign-up';
  static const routeURL = '/sign-up';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> formData = {};

  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        ref.read(signUpProvider.notifier).signUp(
              email: formData["email"]!,
              password: formData["password"]!,
              context: context,
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Be a NoMood coder",
          // style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              const Expanded(
                flex: 1,
                child: Fire(size: 100),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              // Icon(Icons.person)),
              Expanded(
                flex: 5,
                child: Form(
                  key: _formKey,
                  child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return "Plase write your email";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          if (newValue != null) {
                            formData['email'] = newValue;
                          }
                        },
                      ),
                      Gaps.v8,
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return "Plase write your password";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          if (newValue != null) {
                            formData['password'] = newValue;
                          }
                        },
                      ),
                      Gaps.v8,
                      GestureDetector(
                        onTap: _onSubmitTap,
                        child: const FormButton(
                          payload: "Sign up",
                          disabled: false,
                        ),
                      ),
                      Gaps.v8,
                      const Text(
                        "Forgot password?",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        side: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: () => context.goNamed(LoginScreen.routeName),
                      child: const Text(
                        'Already have an account? Log in.',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
