import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../components/dnd_spell_list_view.dart';
import '../components/dropdown_dnd_class_menu.dart';
import '../objects/dnd_spell_object.dart';
import '../providers/dnd_class_provider.dart';
import '../providers/dnd_spell_list_view_provider.dart';
import '../providers/dropdown_class_menu_provider.dart';

class SpellListPage extends StatefulWidget {
  const SpellListPage({
    Key? key,
    // required this.storage,
  }) : super(key: key);

  // final SpellStorage storage;

  @override
  State<SpellListPage> createState() => _SpellListPageState();
}

class _SpellListPageState extends State<SpellListPage>
    with AutomaticKeepAliveClientMixin<SpellListPage> {
  late List<String> dndClasses;
  late String? atualDropdownValue;
  late List<DndSpellObj> dndSpells;
  late List<DndSpellObj> dndSpellsVisible;
  bool loaded = false;
  bool updating = true;
  late Future<bool> spellsListJson;
  // List<String> updateCodes = [
  //   'initializing',
  //   'downloading',
  //   'creating spells',
  //   'done',
  // ];
  // int updateAtualCode = 0;

  @override
  void initState() {
    super.initState();
    spellsListJson = getSpellsList();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    dndClasses =
        Provider.of<DndClassProvider>(context, listen: true).dndClasses;
    atualDropdownValue =
        Provider.of<DropdownClassMenuProvider>(context, listen: true)
            .atualDropdownValue;
    dndSpells =
        Provider.of<DndSpellListViewProvider>(context, listen: true).dndSpells;
    dndSpellsVisible =
        Provider.of<DndSpellListViewProvider>(context, listen: true)
            .dndSpellsVisible;

    updateVisibleSpells();

    return FutureBuilder<bool>(
      future: spellsListJson,
      builder: (BuildContext cxt, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError == false) {
            return _body(loaded: true);
          }
        } else if (snapshot.hasError) {
          return const Center(
            child: Icon(Icons.error),
          );
        }
        return _body();
      },
    );
  }

  Widget _body({bool loaded = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: loaded,
          child: Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Text(
                          'Class:',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: DropdownDndClassMenu()),
                  ],
                ),
                DndSpellListView(),
              ],
            ),
          ),
        ),
        Visibility(
          visible: !loaded,
          child: const Expanded(
            child: Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(58, 44, 28, 1),
                ),
              ),
            ),
          ),
        ),
        updating
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(child: Container()),
                      Expanded(
                        child: Container(
                            height: 2,
                            color: const Color.fromRGBO(58, 44, 28, 1)),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Downloading in Progress...',
                  ),
                  const SizedBox(height: 2),
                  const LinearProgressIndicator(
                    minHeight: 10,
                    backgroundColor: Color.fromRGBO(234, 212, 176, 1),
                    color: Color.fromRGBO(58, 44, 28, 1),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }

  Future<bool> getSpellsList() async {
    const String urlBase = "mestredns.com";
    const String urlArg = "api/spell.list";

    // updateAtualCode = 1;

    Uri uriSpellList = Uri.https(urlBase, urlArg);
    String resSpellList = await http.read(uriSpellList);

    // updateAtualCode = 2;

    Map<String, dynamic> jsonList = jsonDecode(resSpellList);
    for (Map<String, dynamic> spell in jsonList['spells']) {
      DndSpellObj spellObj = DndSpellObj.fromJson(spell);
      context.read<DndSpellListViewProvider>().dndSpellsAdd(spellObj);
      List<dynamic> debugInfo = spell['classes'] as List<dynamic>;
      for (var classData in debugInfo) {
        Map<String, String> classMap = Map<String, String>.from(classData);
        String? className = classMap['name'];
        if (className != null) {
          if (context.read<DndClassProvider>().dndClasses.contains(className) ==
              false) {
            context.read<DndClassProvider>().dndClassesAdd(className);
          }
        }
      }
    }

    // updateAtualCode = 3;

    updating = false;
    return true;
  }

  void updateVisibleSpells() {
    context.read<DndSpellListViewProvider>().dndSpellsVisibleRemoveAll();
    if (atualDropdownValue == null) {
      context.read<DndSpellListViewProvider>().dndSpellsAllVisible();
      return;
    }
    for (DndSpellObj _spell in dndSpells) {
      for (var e in _spell.spellCasters) {
        Map<String, String> classMap = Map<String, String>.from(e);
        String className = classMap['name'] ?? '';
        if (className != '') {
          bool _valid = className.contains(atualDropdownValue!);
          if (_valid) {
            context
                .read<DndSpellListViewProvider>()
                .dndSpellsVisibleAdd(_spell);
          }
        }
      }
    }
  }
}
