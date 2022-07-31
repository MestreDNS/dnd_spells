import 'package:dnd_spells/providers/dnd_spell_list_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';
import 'package:provider/provider.dart';

import '../objects/dnd_spell_object.dart';
import '../providers/dnd_selected_spell_provider.dart';

class DndSpellListView extends StatelessWidget {
  DndSpellListView({Key? key}) : super(key: key);

  late List<DndSpellObj> dndSpellsVisible;
  late ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    dndSpellsVisible =
        Provider.of<DndSpellListViewProvider>(context, listen: true)
            .dndSpellsVisible;

    scrollController =
        Provider.of<DndSpellListViewProvider>(context, listen: true)
            .listViewScrollController;

    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        itemCount: dndSpellsVisible.length,
        itemBuilder: (BuildContext ctx, int index) {
          return GestureDetector(
            onTap: () {
              context
                  .read<DndSelectedSpellProvider>()
                  .updateDndSpellObj(dndSpellsVisible[index]);
            },
            child: Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              child: SizedBox(
                height: 40,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          dndSpellsVisible[index].nameEn,
                          style: const TextStyle(fontSize: 16),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              dndSpellsVisible[index].school,
                              style: const TextStyle(fontSize: 11),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            HexagonWidget.flat(
                              width: 20,
                              color: const Color.fromRGBO(58, 44, 28, 1),
                              child: Center(
                                child: Text(
                                  dndSpellsVisible[index].level.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
