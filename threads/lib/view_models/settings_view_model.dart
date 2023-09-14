import 'package:flutter/widgets.dart';
import 'package:threads/repos/settings_repo.dart';

import '../models/settings_model.dart';

class SettingsViewModel extends ChangeNotifier {
  final SettingsRepository _repository;
  late final SettingsModel _model =
      SettingsModel(darkMode: _repository.isDarkMode());

  SettingsViewModel(this._repository);

  bool get darkMode => _model.darkMode;

  void setDarkMode(bool value) {
    _repository.setDarkMode(value);
    _model.darkMode = value;
    notifyListeners();
  }
}
