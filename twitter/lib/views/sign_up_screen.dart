import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/views/create_account_screen.dart';

import '../constants/gaps.dart';
import '../widgets/app_bar.dart';
import '../widgets/auth_button.dart';
import '../widgets/google_logo.dart';

class SignUpScreen extends StatelessWidget {
  static const routeURL = "/";
  static const routeName = "signUp";

  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        leadingType: LeadingType.none,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "See what's happening",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Text(
              "in the world right now.",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
            Gaps.v96,
            Gaps.v24,
            AuthButton(
              customPaint: CustomPaint(
                painter: GoogleLogoPainter(),
                size: const Size.square(Sizes.size16),
              ),
              payload: "Continue with Google",
            ),
            Gaps.v12,
            const AuthButton(
              icon: FaIcon(FontAwesomeIcons.apple),
              payload: "Continue with Apple",
            ),
            Gaps.v12,
            Row(
              children: const [
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text("or"),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                ),
              ],
            ),
            Gaps.v12,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthButton(
                  isDark: true,
                  onTap: (context) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CreateAccountScreen(),
                      ),
                    );
                    // context.go(SignUpScreen.routeName);
                  },
                  payload: "Create account",
                ),
                Gaps.v24,
                RichText(
                  text: TextSpan(
                    text: "By Signing up, you agree to our ",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.grey.shade900,
                      fontSize: Sizes.size16,
                    ),
                    children: const [
                      TextSpan(
                        text: "Terms",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      TextSpan(
                        text: ",\n",
                      ),
                      TextSpan(
                        text: "Privacy Policy",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      TextSpan(
                        text: ", and ",
                      ),
                      TextSpan(
                        text: "Cookie Use",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      TextSpan(
                        text: ".",
                      ),
                    ],
                  ),
                ),
                Gaps.v48,
                RichText(
                  text: TextSpan(
                    text: "Have an account already? ",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.grey.shade900,
                      fontSize: Sizes.size16,
                    ),
                    children: const [
                      TextSpan(
                        text: "Log in",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
