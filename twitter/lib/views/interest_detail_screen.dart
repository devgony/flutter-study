import 'package:flutter/material.dart';
import 'package:twitter/widgets/app_bar.dart';

import '../constants/gaps.dart';
import '../constants/sizes.dart';
import '../widgets/interest_row.dart';

const List<String> _musicDetails = [
  "Rap",
  "R&B & soul",
  "Grammy Awards",
  "Pop",
  "K-pop",
  "Music industry",
  "EDM",
  "Music news",
  "Hip hop",
  "Reggae",
  "Rock",
];

const List<String> _entertainmentDetails = [
  "Anime",
  "Movies & TV",
  "Harry Potter",
  "Marvel Universe",
  "Movie news",
  "Naruto",
  "Movies",
  "Grammy Awards",
  "Entertainment"
];

class InterestDetailScreen extends StatefulWidget {
  static const routeURL = "/interest-detail";
  static const routeName = "interest-detail";

  const InterestDetailScreen({super.key});

  @override
  State<InterestDetailScreen> createState() => _InterestDetailScreenState();
}

class _InterestDetailScreenState extends State<InterestDetailScreen> {
  final _selectedCategories =
      <String>[]; // TODO: should separater music and entertainment state

  bool _isValid() {
    return _selectedCategories.length >= 3;
  }

  void _handleCategoryTap(String category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else {
        _selectedCategories.add(category);
      }
    });
  }

  List<List<String>> partitionByThree(List<String> list) {
    return List.generate(
      3,
      (index) {
        final start = index * 3;
        final end = (index + 1) * 3;
        return end > list.length
            ? list.sublist(start)
            : list.sublist(start, end);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final musicPartitions = partitionByThree(_musicDetails);
    final entertainmentPartitions = partitionByThree(_entertainmentDetails);

    return Scaffold(
      appBar: const AppBarWidget(
        leadingType: LeadingType.back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What do you want to see on Twitter?",
              style: TextStyle(
                fontSize: Sizes.size24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gaps.v12,
            Text(
              "Interests are used to personalize your experience and will be visible on your profile.",
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
            Gaps.v12,
            const Text(
              "Music",
              style: TextStyle(
                fontSize: Sizes.size20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gaps.v12,
            for (final partition in musicPartitions)
              InterestRow(
                selectedCategories: _selectedCategories,
                onTap: _handleCategoryTap,
                interests: partition,
              ),
            Gaps.v12,
            const Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
            Gaps.v12,
            const Text(
              "Entertainment",
              style: TextStyle(
                fontSize: Sizes.size20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gaps.v12,
            for (final partition in entertainmentPartitions)
              InterestRow(
                selectedCategories: _selectedCategories,
                onTap: _handleCategoryTap,
                interests: partition,
              ),
            Gaps.v12,
            const Divider(
              color: Colors.grey,
              thickness: 0.5,
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
              Text(
                "${_selectedCategories.length} of 3 selected",
              ),
              GestureDetector(
                onTap: () {
                  // if (!_isValid()) return;

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const InterestDetailScreen(),
                  //   ),
                  // );
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
