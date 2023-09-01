import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/user_model.dart';

class UserRepository {
  static Future<List<UserModel>> searchUsers(String keyword) async {
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
