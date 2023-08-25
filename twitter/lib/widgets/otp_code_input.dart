import 'package:flutter/material.dart';

class OtpCodeInput extends StatefulWidget {
  final List<TextEditingController> controllers;

  const OtpCodeInput({
    super.key,
    required this.controllers,
  });

  @override
  State<OtpCodeInput> createState() => _OtpCodeInputState();
}

class _OtpCodeInputState extends State<OtpCodeInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        6,
        (index) => SizedBox(
          width: 40,
          child: TextFormField(
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
