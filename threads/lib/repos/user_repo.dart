// import 'dart:convert';
// import 'dart:io';

// void main() {
//   final file = File('users.json');
//   final jsonString = file.readAsStringSync();
//   final jsonData = json.decode(jsonString);

//   // Access the data in the JSON object
//   for (final user in jsonData['users']) {
//     print('Name: ${user['name']}');
//     print('Email: ${user['email']}');
//     print('Age: ${user['age']}');
//     print('---');
//   }
// }

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';

class UserRepository {
  Future<List<UserModel>> searchUsers(String keyword) async {
    final String jsonString = await rootBundle.loadString('assets/users.json');
    final List<dynamic> jsonData = json.decode(jsonString);

    final data = jsonData.map((json) => UserModel.fromJson(json));

    if (keyword.isEmpty) return data.toList();

    return data.where(
      (user) {
        final nameLower = user.userId.toLowerCase();
        final keywordLower = keyword.toLowerCase();

        return nameLower.contains(keywordLower);
      },
    ).toList();
  }
}

final userRepository = Provider(
  (ref) => UserRepository(),
);
