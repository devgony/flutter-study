import 'package:flutter/material.dart';
import 'package:twitter/widgets/app_bar.dart';
import 'package:twitter/widgets/next_bottom_navigation_bar.dart';

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
  const InterestDetailScreen({super.key});

  @override
  State<InterestDetailScreen> createState() => _InterestDetailScreenState();
}

class _InterestDetailScreenState extends State<InterestDetailScreen> {
  final _selectedMusicInterests = <String>[];
  final _selectedEntertainmentInterests = <String>[];
  int _selectedLength() =>
      _selectedMusicInterests.length + _selectedEntertainmentInterests.length;

  void _handleInterestTap(String interest, List<String> selectedInterests) {
    setState(() {
      if (selectedInterests.contains(interest)) {
        selectedInterests.remove(interest);
      } else {
        selectedInterests.add(interest);
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
                selectedInterests: _selectedMusicInterests,
                onTap: _handleInterestTap,
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
                selectedInterests: _selectedEntertainmentInterests,
                onTap: _handleInterestTap,
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
      bottomNavigationBar: NextBottomNavigationBar(
        payload: "${_selectedLength()} of 3 selected",
        isValid: _selectedLength() >= 3,
      ),
    );
  }
}
