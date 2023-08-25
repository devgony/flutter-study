import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/views/customize_experience_screen.dart';
import 'package:twitter/views/otp_screen.dart';

import '../constants/gaps.dart';
import '../constants/sizes.dart';
import '../view_models/signup_view_model.dart';
import '../widgets/app_bar.dart';

class CreateAccountScreen extends ConsumerStatefulWidget {
  static const routeURL = "/createAccount";
  static const routeName = "createAccount";

  const CreateAccountScreen({super.key});

  @override
  ConsumerState<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneOrEmailController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  String _name = "";
  String _email = "";
  late DateTime _initialDate;
  bool _pickingDate = false;
  bool _writingEmail = false; // TODO: should use better logic
  bool _agreed = false;

  @override
  void initState() {
    super.initState();
    DateTime currentDate = DateTime.now();
    final minDate =
        DateTime(currentDate.year - 10, currentDate.month, currentDate.day);
    // _setTextFieldDate(_initialDate);

    final signUpFormState = ref.read(signUpForm.notifier).state;
    _nameController.text = signUpFormState['name'] ?? '';
    final String? globalDate = signUpFormState['birthday'];
    if (globalDate == null) {
      _initialDate = minDate;
    } else {
      _initialDate = DateTime.parse(globalDate);
      _setTextFieldDate(_initialDate);
    }
    _phoneOrEmailController.text = signUpFormState['email'] ?? '';
    _agreed = signUpFormState['agreed'] ?? false;

    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });
    _phoneOrEmailController.addListener(() {
      setState(() {
        _email = _phoneOrEmailController.text;
      });
    });
    setState(() {});
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    _birthdayController.value = TextEditingValue(text: textDate);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneOrEmailController.dispose();
    super.dispose();
  }

  String? _isNameValid() {
    if (_name.isEmpty) return null;
    if (_name.length < 6) {
      return "Name must be at least 6 characters";
    }
    return null;
  }

  String? _isEmailValid() {
    if (_email.isEmpty) return null;
    final regExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (!regExp.hasMatch(_email)) {
      return "Email not valid";
    }
    return null;
  }

  bool _isFormValid() {
    return _name.isNotEmpty &&
        _isNameValid() == null &&
        _email.isNotEmpty &&
        _isEmailValid() == null &&
        _birthdayController.text.isNotEmpty;
  }

  void _showDatePicker(BuildContext context) {
    setState(() {
      _pickingDate = true;
      _writingEmail = false;
    });
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
      // FocusScope.of(context).unfocus();
      // SystemChannels.textInput.invokeMethod('TextInput.hide');
      setState(() {
        //   // _pickingDate = false;
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
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Name",
                errorText: _isNameValid(),
                suffixIcon:
                    _agreed || (_name.isNotEmpty && _isNameValid() == null)
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : null,
              ),
            ),
            Gaps.v24,
            TextField(
              onTap: () {
                setState(() {
                  _writingEmail = true;
                });
              },
              controller: _phoneOrEmailController,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              decoration: InputDecoration(
                labelText:
                    _writingEmail ? "Email" : "Phone number or email address",
                suffixIcon:
                    _agreed || (_email.isNotEmpty && _isEmailValid() == null)
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : null,
                errorText: _isEmailValid(),
              ),
            ),
            Gaps.v24,
            TextField(
              onTap: () {
                _showDatePicker(context);
              },
              enabled: true,
              // readOnly: true,
              controller: _birthdayController,
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
                            builder: (context) => const OtpScreen(),
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
                    onTap: () {
                      if (_isFormValid()) {
                        ref.read(signUpForm.notifier).state = {
                          "name": _name,
                          "email": _email,
                          "birthday": _birthdayController.text,
                        };
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const CustomizeExperienceScreen(),
                          ),
                        );
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
