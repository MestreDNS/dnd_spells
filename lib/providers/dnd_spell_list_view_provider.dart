import 'package:dnd_spells/objects/dnd_spell_object.dart';
import 'package:flutter/material.dart';

class DndSpellListViewProvider extends ChangeNotifier {
  List<DndSpellObj> _dndSpells = [];
  List<DndSpellObj> _dndSpellsVisible = [];

  List<DndSpellObj> get dndSpells => _dndSpells;
  List<DndSpellObj> get dndSpellsVisible => _dndSpellsVisible;

  final ScrollController _listViewScrollController = ScrollController();
  ScrollController get listViewScrollController => _listViewScrollController;

  dndSpellsRemoveAll() {
    _dndSpells = [];
  }

  dndSpellsVisibleRemoveAll() {
    _dndSpellsVisible = [];
  }

  dndSpellsAdd(DndSpellObj newSpell) {
    _dndSpells.add(newSpell);
  }

  dndSpellsVisibleAdd(DndSpellObj newSpellVisible) {
    _dndSpellsVisible.add(newSpellVisible);
  }

  dndSpellsAllVisible() {
    _dndSpellsVisible = _dndSpells;
  }

  refresh() {
    notifyListeners();
  }
}
