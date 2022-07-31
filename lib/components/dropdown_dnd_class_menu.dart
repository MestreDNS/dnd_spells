import 'package:dnd_spells/providers/dnd_class_provider.dart';
import 'package:dnd_spells/providers/dnd_spell_list_view_provider.dart';
import 'package:dnd_spells/providers/dropdown_class_menu_provider.dart';
import 'package:dnd_spells/providers/lang_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropdownDndClassMenu extends StatelessWidget {
  DropdownDndClassMenu({Key? key}) : super(key: key);

  late bool isEnglish;
  late String? atualDropdownValue;
  late List<DropdownMenuItem<String>> classesDropdownItems;
  late List<String> dndClasses;

  @override
  Widget build(BuildContext context) {
    isEnglish = Provider.of<LangProvider>(context, listen: true).isEnglish;
    atualDropdownValue =
        Provider.of<DropdownClassMenuProvider>(context, listen: true)
            .atualDropdownValue;
    classesDropdownItems =
        Provider.of<DropdownClassMenuProvider>(context, listen: true)
            .classesDropdownItems;
    dndClasses =
        Provider.of<DndClassProvider>(context, listen: true).dndClasses;

    _generateClassesDropdownItems();

    return DropdownButtonHideUnderline(
      child: DropdownButton<String?>(
        iconSize: 36,
        iconEnabledColor: const Color.fromRGBO(58, 44, 28, 1),
        dropdownColor: const Color.fromRGBO(234, 212, 176, 1),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        isExpanded: true,
        value: atualDropdownValue,
        items: classesDropdownItems,
        onChanged: (selectedItem) {
          context
              .read<DropdownClassMenuProvider>()
              .updateAtualDropdownValue(selectedItem);
          context.read<DndSpellListViewProvider>().refresh();
          context
              .read<DndSpellListViewProvider>()
              .listViewScrollController
              .animateTo(
                0,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeIn,
              );
        },
      ),
    );
  }

  void _generateClassesDropdownItems() {
    classesDropdownItems = [];
    classesDropdownItems.add(
      DropdownMenuItem(
        child: Text(isEnglish ? "All" : "Todas"),
      ),
    );
    for (String dndClass in dndClasses) {
      classesDropdownItems.add(
        DropdownMenuItem(
          value: dndClass,
          child: Text(dndClass),
        ),
      );
    }
  }
}
