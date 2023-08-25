import 'package:flutter/material.dart';
import 'package:twitter/widgets/app_bar.dart';

import '../constants/gaps.dart';
import '../widgets/auth_button.dart';
import 'interest_screen.dart';

class PasswordScreen extends StatefulWidget {
  static const routeURL = "/password";
  static const routeName = "password";

  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _password = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void goToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const InterestScreen(),
      ),
    );
  }

  String? _validator(String? password) {
    if (password == null || password.isEmpty) {
      return "Password is required";
    }
    if (password.length < 8) {
      return "Password must be at least 8 characters";
    }
    return null;
  }

  bool _isFormValid() => _formKey.currentState?.validate() ?? false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(leadingType: LeadingType.none),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "You'll need a Password",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
              ),
              Gaps.v24,
              const Text(
                "Make sure it's 8 characters or more.",
                style: TextStyle(fontSize: 16),
              ),
              Gaps.v36,
              Form(
                key: _formKey,
                child: TextFormField(
                  validator: _validator,
                  onChanged: (value) => setState(() => _password = value),
                  decoration: InputDecoration(
                    labelText: "Password",
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.visibility_off, color: Colors.grey),
                        Gaps.h4,
                        _isFormValid()
                            ? const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              const Spacer(),
              AuthButton(
                payload: "Next",
                onTap: (context) => {
                  if (_isFormValid()) {goToNextScreen()}
                },
                isDark: true,
                active: _isFormValid(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
