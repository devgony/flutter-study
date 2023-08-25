import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter/views/customize_experience_screen.dart';
import 'package:twitter/views/otp_screen.dart';

import '../constants/gaps.dart';
import '../constants/sizes.dart';
import '../widgets/app_bar.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  final TextEditingController _birthdayController = TextEditingController();
  late DateTime _initialDate;
  bool _pickingDate = false;
  bool _writingEmail = false;
  bool _agreed = false;

  @override
  void initState() {
    super.initState();
    _birthdayController.addListener(() {
      setState(() {
        _formData['birthday'] = _birthdayController.text;
      });
    });
    DateTime currentDate = DateTime.now();
    final minDate =
        DateTime(currentDate.year - 10, currentDate.month, currentDate.day);
    _initialDate = minDate;

    setState(() {});
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    setState(() {
      _birthdayController.value = TextEditingValue(text: textDate);
      _formData['birthday'] = textDate;
    });
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose();
  }

  String? _isNameValid(String? value) {
    if (value == null) return null;
    if (value.length < 6) {
      return "Name must be at least 6 characters";
    }
    return null;
  }

  String? _isEmailValid(String? value) {
    if (value == null) return null;
    final regExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (!regExp.hasMatch(value)) {
      return "Email not valid";
    }
    return null;
  }

  bool _isFormValid() => _formKey.currentState?.validate() ?? false;

  void _showDatePicker(BuildContext context) {
    if (_birthdayController.text.isEmpty) {
      _birthdayController.text = _initialDate.toString().split(" ").first;
    }
    _pickingDate = true;
    _writingEmail = false;
    setState(() {});
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 300.0,
          child: CupertinoDatePicker(
            maximumDate: _initialDate,
            initialDateTime: _initialDate,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: _setTextFieldDate,
            backgroundColor: Colors.white,
          ),
        );
      },
    ).then((_) {
      FocusManager.instance.primaryFocus?.unfocus();
      setState(() {
        _pickingDate = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        leadingType: _agreed ? LeadingType.back : LeadingType.cancel,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v24,
              const Text(
                "Create your account",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Gaps.v24,
              TextFormField(
                onChanged: (value) {
                  _formKey.currentState?.validate();
                  setState(() {
                    _formData['name'] = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Name",
                  suffixIcon: _agreed ||
                          (_formData['name'] != null &&
                              _isNameValid(_formData['name']) == null)
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : null,
                ),
                validator: _isNameValid,
              ),
              Gaps.v24,
              TextFormField(
                onChanged: (value) {
                  _isFormValid();
                  setState(() => _formData['email'] = value);
                },
                validator: _isEmailValid,
                onTap: () {
                  setState(() {
                    _writingEmail = true;
                  });
                },
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText:
                      _writingEmail ? "Email" : "Phone number or email address",
                  suffixIcon: _agreed ||
                          (_formData['email'] != null &&
                              _isEmailValid(_formData["email"]) == null)
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : null,
                ),
              ),
              Gaps.v24,
              TextFormField(
                controller: _birthdayController,
                onTap: () {
                  _showDatePicker(context);
                },
                enabled: true,
                decoration: InputDecoration(
                  labelText: "Date of birth",
                  suffixIcon: _agreed || (_birthdayController.text.isNotEmpty)
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : null,
                ),
              ),
              Gaps.v12,
              _pickingDate
                  ? Text(
                      "This will not be shown publicly. Confirm your\nown age, even if this account is for a\nbusiness, a pet, or something else.",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 15,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: _agreed
            ? Column(
                children: [
                  const Spacer(),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.grey.shade800,
                      ),
                      children: [
                        const TextSpan(
                          text: "By signing up, you agree to the ",
                        ),
                        TextSpan(
                          text: "Terms of Service",
                          style: TextStyle(
                            color: Colors.blue.shade700,
                          ),
                        ),
                        const TextSpan(
                          text: " and ",
                        ),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(
                            color: Colors.blue.shade700,
                          ),
                        ),
                        const TextSpan(
                          text: ", including ",
                        ),
                        TextSpan(
                          text: "Cookie Use",
                          style: TextStyle(
                            color: Colors.blue.shade700,
                          ),
                        ),
                        const TextSpan(
                          text:
                              ". Twitter\nmay use your contact information, including your\nemail address and phone number for purposes\noutlined in our Privacy Policy, like keeping your\naccount secure and personalizing our services,\nincluding ads. ",
                        ),
                        TextSpan(
                          text: "Learn more",
                          style: TextStyle(
                            color: Colors.blue.shade700,
                          ),
                        ),
                        const TextSpan(
                          text:
                              ". Others will be able to\nfind you by email or phone number, when provided,\nunless you choose otherwise. ",
                        ),
                        TextSpan(
                          text: "here",
                          style: TextStyle(
                            color: Colors.blue.shade700,
                          ),
                        ),
                        const TextSpan(text: "."),
                      ],
                    ),
                  ),
                  Gaps.v24,
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtpScreen(
                              email: _formData["email"],
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _writingEmail
                      ? const Text(
                          "Use phone instead",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )
                      : const Text(""),
                  GestureDetector(
                    onTap: () async {
                      if (_isFormValid()) {
                        final bool agreed = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const CustomizeExperienceScreen(),
                          ),
                        );

                        setState(() {
                          _agreed = agreed;
                        });
                      }
                    },
                    child: Container(
                      width: Sizes.size96,
                      height: 47,
                      decoration: BoxDecoration(
                        color: _isFormValid() ? Colors.black : Colors.grey,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          "Next",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
