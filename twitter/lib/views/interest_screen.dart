import 'package:flutter/material.dart';
import 'package:twitter/views/interest_detail_screen.dart';
import 'package:twitter/widgets/app_bar.dart';
import 'package:twitter/widgets/interest_box.dart';

import '../constants/gaps.dart';
import '../constants/sizes.dart';
import '../widgets/next_bottom_navigation_bar.dart';

const _interests = [
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
  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  final _selectedInterests = <String>[];
  bool _showTitle = false;
  final ScrollController _scrollController = ScrollController();

  bool _threeOrMoreSelected() {
    return _selectedInterests.length >= 3;
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 50) {
        setState(() {
          _showTitle = true;
        });
      } else {
        setState(() {
          _showTitle = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        leadingType: LeadingType.back,
        showTitle: _showTitle,
        title: const Text(
          "Select interests",
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: SingleChildScrollView(
          controller: _scrollController,
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
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 2.1,
                mainAxisSpacing: 6.0,
                crossAxisSpacing: 16.0,
                children: _interests.map((interest) {
                  final isSelected = _selectedInterests.contains(interest);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedInterests.remove(interest);
                        } else {
                          _selectedInterests.add(interest);
                        }
                      });
                    },
                    child: InterestBox(
                      interest: interest,
                      isSelected: isSelected,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NextBottomNavigationBar(
        payload: _threeOrMoreSelected()
            ? "Great work 👍"
            : "${_selectedInterests.length} of 3 selected",
        isValid: _threeOrMoreSelected(),
        nextScreen: const InterestDetailScreen(),
      ),
    );
  }
}
