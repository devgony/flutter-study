import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileRow extends StatelessWidget {
  final String name1;
  final String value1;
  final String? name2;
  final String? value2;

  const ProfileRow({
    super.key,
    required this.name1,
    required this.value1,
    this.name2,
    this.value2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 36, bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name1,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue.shade300,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  value1,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: (name2 != null && value2 != null)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name2!,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue.shade300,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      name2 == "Gender"
                          ? RichText(
                              text: TextSpan(
                                children: [
                                  const WidgetSpan(
                                    child: FaIcon(
                                      FontAwesomeIcons.mars,
                                      color: Colors.blue,
                                      size: 16,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: " / ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: FaIcon(
                                      FontAwesomeIcons.venus,
                                      color: Colors.pink.shade300,
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Text(
                              value2!,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            )
                    ],
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}
