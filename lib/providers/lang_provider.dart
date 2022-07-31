import 'package:flutter/material.dart';

class LangProvider extends ChangeNotifier {
  bool _isEnglish = true;

  bool get isEnglish => _isEnglish;

  updateLang() {
    _isEnglish = !_isEnglish;
    notifyListeners();
  }

  refresh() {
    notifyListeners();
  }
}
