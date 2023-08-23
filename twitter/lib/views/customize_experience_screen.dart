import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/view_models/signup_view_model.dart';
import 'package:twitter/views/create_account_screen.dart';
import 'package:twitter/widgets/app_bar.dart';

import '../constants/gaps.dart';

class CustomizeExperienceScreen extends ConsumerStatefulWidget {
  static const routeURL = "/customizeExperience";
  static const routeName = "customizeExperience";

  const CustomizeExperienceScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CustomizeExperienceScreen> createState() =>
      _CustomizeExperienceScreenState();
}

class _CustomizeExperienceScreenState
    extends ConsumerState<CustomizeExperienceScreen> {
  bool _agreed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        leadingType: LeadingType.back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Customize your\nexperience",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
            Gaps.v24,
            const Text(
              "Track where you see Twitter\ncontent across the web",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            Gaps.v12,
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              value: _agreed,
              onChanged: (value) {
                setState(() {
                  _agreed = value;
                });
              },
              title: const Text(
                "Twitter uses this data to\npersonalize your experience. This\nweb browsing history will never be\nstored with your name, email, or\nphone number.",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            Gaps.v24,
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.grey.shade800,
                ),
                children: [
                  const TextSpan(
                    text: "By sigining up, you agree to our ",
                  ),
                  TextSpan(
                    text: "Terms, Privacy\nPolicy",
                    style: TextStyle(
                      color: Colors.blue.shade700,
                    ),
                  ),
                  const TextSpan(
                    text: ", and ",
                  ),
                  TextSpan(
                    text: "Cookie Use",
                    style: TextStyle(
                      color: Colors.blue.shade700,
                    ),
                  ),
                  const TextSpan(
                    text:
                        ". Twitter may use your\ncontact information, including your email address\nand phone number for purposes outlined in our\nPrivacy Policy. ",
                  ),
                  TextSpan(
                    text: "Learn more\n",
                    style: TextStyle(
                      color: Colors.blue.shade700,
                    ),
                  ),
                ],
              ),
            ),
            // Next button
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    if (_agreed) {
                      final state = ref.read(signUpForm.notifier).state;
                      ref.read(signUpForm.notifier).state = {
                        ...state,
                        "agreed": _agreed,
                      };

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CreateAccountScreen(),
                        ),
                      );
                      // context.go(CreateAccountScreen.routeURL);
                      // context.push(
                      //   CreateAccountScreen.routeURL,
                      //   extra: CreateAccountScreenArgs(agreed: _agreed),
                      // );
                      // context.pop();
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: _agreed ? Colors.black : Colors.grey,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
