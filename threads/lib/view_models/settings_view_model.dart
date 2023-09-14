import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads/repos/settings_repo.dart';

import '../models/settings_model.dart';

class SettingsViewModel extends Notifier<SettingsModel> {
  final SettingsRepo _repo;

  SettingsViewModel(this._repo);

  void setDarkMode(bool value) {
    _repo.setDarkMode(value);
    state = SettingsModel(darkMode: value);
  }

  @override
  SettingsModel build() {
    return SettingsModel(darkMode: _repo.isDarkMode());
  }
}

final settingsProvider = NotifierProvider<SettingsViewModel, SettingsModel>(
  () => throw UnimplementedError(),
);
