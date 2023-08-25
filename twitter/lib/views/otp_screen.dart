import 'package:flutter/material.dart';
import 'package:twitter/views/password_screen.dart';
import 'package:twitter/widgets/app_bar.dart';
import 'package:twitter/widgets/auth_button.dart';

import '../constants/gaps.dart';

class OtpScreen extends StatefulWidget {
  static const routeURL = "/otp";
  static const routeName = "otp";

  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  bool _verifying = false;
  bool _verified = false;

  @override
  void initState() {
    super.initState();
    for (var controller in _controllers) {
      controller.addListener(() {
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String getOtpText() {
    return _controllers.fold(
      "",
      (previousValue, element) => previousValue += element.text,
    );
  }

  bool isOtpFilled() {
    return getOtpText().length == 6;
  }

  void verifyOtp(BuildContext context) {
    if (isOtpFilled()) {
      setState(() {
        _verifying = true;
      });
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _verifying = false;
          _verified = true;
        });
      });
    }
  }

  void goToPasswordScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PasswordScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        leadingType: LeadingType.back,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'We sent you a code',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Gaps.v24,
              const Text(
                'Enter it below to verify\nabc@gmail.com',
              ), // TODO: take provided email
              const SizedBox(height: 16),
              _OtpCodeInput(controllers: _controllers),
              Gaps.v24,
              _verified
                  ? const Center(
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 30,
                      ),
                    )
                  : const SizedBox(),
              const Spacer(),
              const Text(
                "Didn't receive email?",
                style: TextStyle(fontSize: 14, color: Colors.blue),
              ),
              Gaps.v24,
              AuthButton(
                onTap: _verified ? goToPasswordScreen : verifyOtp,
                payload: "Next",
                isDark: true,
                active: isOtpFilled(),
                isLoading: _verifying,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OtpCodeInput extends StatefulWidget {
  final List<TextEditingController> controllers;
  const _OtpCodeInput({required this.controllers});

  @override
  _OtpCodeInputState createState() => _OtpCodeInputState();
}

class _OtpCodeInputState extends State<_OtpCodeInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        6,
        (index) => SizedBox(
          width: 40,
          child: TextField(
            controller: widget.controllers[index],
            maxLength: 1,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              counterText: '',
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < 5) {
                FocusScope.of(context).nextFocus();
              }
            },
          ),
        ),
      ),
    );
  }
}
