import 'package:flutter/material.dart';

class DropdownClassMenuProvider extends ChangeNotifier {
  String? _atualDropdownValue;
  final List<DropdownMenuItem<String>> _classesDropdownItems = [];

  String? get atualDropdownValue => _atualDropdownValue;
  List<DropdownMenuItem<String>> get classesDropdownItems =>
      _classesDropdownItems;

  updateAtualDropdownValue(String? newValue) {
    _atualDropdownValue = newValue;
    notifyListeners();
  }
}
