import 'package:flutter/material.dart';
import 'package:twitter/views/password_screen.dart';
import 'package:twitter/widgets/app_bar.dart';
import 'package:twitter/widgets/auth_button.dart';

import '../constants/gaps.dart';
import '../widgets/otp_code_input.dart';

class OtpScreen extends StatefulWidget {
  final String? email;
  const OtpScreen({super.key, this.email = "abc@gmail.com"});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  bool _verifying = false;
  bool _showVerifiedResult = false;
  bool _valid = false;

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
    final otpText = getOtpText();
    _valid = RegExp(r"\d{6}").hasMatch(otpText);
    _verifying = true;
    setState(() => {});
    Future.delayed(const Duration(seconds: 1), () {
      _verifying = false;
      _showVerifiedResult = true;
      setState(() {});
    });
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
              Text(
                'Enter it below to verify\n${widget.email}',
              ),
              const SizedBox(height: 16),
              OtpCodeInput(
                controllers: _controllers,
              ),
              Gaps.v24,
              _showVerifiedResult
                  ? _valid
                      ? const Center(
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 30,
                          ),
                        )
                      : const Center(
                          child: Text(
                            'Invalid OTP, put numbers only',
                            style: TextStyle(color: Colors.red),
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
                onTap: _valid ? goToPasswordScreen : verifyOtp,
                payload: _valid ? "Next" : "Verify",
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
