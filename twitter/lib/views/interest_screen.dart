import 'package:flutter/material.dart';
import 'package:twitter/views/interest_detail_screen.dart';
import 'package:twitter/widgets/app_bar.dart';

import '../constants/gaps.dart';
import '../constants/sizes.dart';

const _categories = [
  "Fashion & beauty",
  "Outdoors",
  "Arts & culture",
  "Animation & comics",
  "Business & finance",
  "Food",
  "Travel",
  "Entertainment",
  "Music",
  "Gaming",
  "Ex1",
  "Ex2",
];

class InterestScreen extends StatefulWidget {
  static const routeURL = "/interest";
  static const routeName = "interest";

  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  final _selectedCategories = <String>[];

  bool _isValid() {
    return _selectedCategories.length >= 3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(leadingType: LeadingType.none),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v12,
            const Text(
              "What do you want to see on Twitter?",
              style: TextStyle(
                fontSize: Sizes.size24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gaps.v12,
            Text(
              "Select at least 3 interests to personalize your Twitter experience. They will be visible on your profile.",
              style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w300,
              ),
            ),
            Gaps.v12,
            const Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
            Gaps.v24,
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 2.1,
                mainAxisSpacing: 6.0,
                crossAxisSpacing: 16.0,
                children: _categories.map((category) {
                  final isSelected = _selectedCategories.contains(category);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedCategories.remove(category);
                        } else {
                          _selectedCategories.add(category);
                        }
                      });
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color:
                                isSelected ? Colors.blue : Colors.transparent,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: isSelected ? Colors.blue : Colors.grey,
                              width: 0.5,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                bottom: 8,
                                right: 30,
                              ),
                              child: Text(
                                category,
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        isSelected
                            ? const Positioned(
                                top: 5,
                                right: 5,
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _selectedCategories.length < 3
                  ? Text(
                      "${_selectedCategories.length} of 3 selected",
                    )
                  : const Text(
                      "Great work 👍",
                    ),
              GestureDetector(
                onTap: () {
                  if (!_isValid()) return;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InterestDetailScreen(),
                    ),
                  );
                },
                child: Container(
                  width: Sizes.size96,
                  height: 47,
                  decoration: BoxDecoration(
                    color: _isValid() ? Colors.black : Colors.grey,
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
      ),
    );
  }
}
