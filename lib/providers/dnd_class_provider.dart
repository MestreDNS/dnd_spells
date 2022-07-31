import 'package:flutter/material.dart';

class DndClassProvider extends ChangeNotifier {
  List<String> _dndClasses = [];

  List<String> get dndClasses => _dndClasses;

  dndClassesRemoveAll() {
    _dndClasses = [];
  }

  dndClassesAdd(dndClass) {
    _dndClasses.add(dndClass);
  }

  refresh() {
    notifyListeners();
  }

  String? ifDndClassesContainAnySpellClasses(spellClasses) {
    for (Map<String, dynamic> spellClass in spellClasses) {
      if (dndClasses.contains(spellClass['name']) == false) {
        return spellClass['name'];
      }
    }
    return null;
  }
}
