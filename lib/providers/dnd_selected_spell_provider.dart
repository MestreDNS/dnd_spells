import 'package:dnd_spells/objects/dnd_spell_object.dart';
import 'package:flutter/material.dart';

class DndSelectedSpellProvider extends ChangeNotifier {
  DndSpellObj? _dndSpellObj;

  DndSpellObj? get dndSpellObj => _dndSpellObj;

  updateDndSpellObj(newDndSpellObj) {
    _dndSpellObj = newDndSpellObj;
    notifyListeners();
  }
}
