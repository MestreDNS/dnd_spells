import 'package:dnd_spells/objects/dnd_spell_object.dart';
import 'package:dnd_spells/providers/dnd_selected_spell_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:styled_text/styled_text.dart';

class SpellPage extends StatefulWidget {
  const SpellPage({Key? key}) : super(key: key);

  @override
  State<SpellPage> createState() => _SpellPageState();
}

class _SpellPageState extends State<SpellPage> {
  late DndSpellObj? dndSpellObj;
  late String spellCasters;
  late String components;
  late String componentsDescEn;

  @override
  Widget build(BuildContext context) {
    dndSpellObj = Provider.of<DndSelectedSpellProvider>(context, listen: false)
        .dndSpellObj;

    spellCasters = '';
    if (dndSpellObj != null) {
      List<String?> finalSpellCasters = [];
      for (var spellCasterdata in dndSpellObj!.spellCasters) {
        Map<String, String> mapSpellCasterData =
            Map<String, String>.from(spellCasterdata);
        if (mapSpellCasterData.containsKey('name')) {
          spellCasters += mapSpellCasterData['name'] ?? '';
          spellCasters += ' ';
        }
      }
      spellCasters = spellCasters.trim();
    }

    components = '';
    if (dndSpellObj != null) {
      int count = 0;
      for (String component in dndSpellObj!.components) {
        count++;
        components += component;
        if (count != dndSpellObj!.components.length) {
          components += ', ';
        }
      }
      components = components.trim();
    }

    componentsDescEn = '';
    if (dndSpellObj != null) {
      if (dndSpellObj!.componentsDescEn != "") {
        componentsDescEn += '(';
        componentsDescEn += dndSpellObj!.componentsDescEn;
        componentsDescEn += ')';
      }
      componentsDescEn = componentsDescEn.trim();
    }

    return dndSpellObj != null
        ? spellPageBodyTest()
        : const Center(
            child: Text("Not Load"),
          );
  }

  Widget spellPageBodyTest() {
    return DefaultTextStyle(
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black87,
        height: 1.3,
      ),
      child: Container(
        color: const Color.fromRGBO(234, 212, 176, 1),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    dndSpellObj!.nameEn,
                    style: const TextStyle(
                      letterSpacing: 3,
                      fontFamily: 'AngelWish',
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                    ),
                  ),
                ),
                mySpacer(size: 15),
                Text('Level ${dndSpellObj!.level} ${dndSpellObj!.school}'),
                mySpacer(),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'SpellCasters: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: spellCasters),
                    ],
                  ),
                ),
                mySpacer(),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Casting Time: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: '${dndSpellObj!.castingTime}'),
                    ],
                  ),
                ),
                mySpacer(),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Range: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: '${dndSpellObj!.range}'),
                    ],
                  ),
                ),
                mySpacer(),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Components: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: components),
                    ],
                  ),
                ),
                Text(
                  componentsDescEn,
                  style: const TextStyle(fontSize: 14),
                ),
                mySpacer(size: 8),
                textRefiner('Description', dndSpellObj!.descEn),
                mySpacer(),
                dndSpellObj!.atHigherLevelsEn.isNotEmpty
                    ? textRefiner(
                        'At Higher Levels', dndSpellObj!.atHigherLevelsEn)
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget mySpacer({double size = 4}) {
    return SizedBox(
      height: size,
    );
  }

  Widget textRefiner(String textType, List<dynamic> rawText) {
    String refinedText = '';
    int count = 0;
    for (var x in rawText) {
      count++;
      refinedText += x.toString();
      if (count != rawText.length) {
        refinedText += '\n';
      }
    }

    int boldCount = ('***'.allMatches(refinedText).length / 2).floor();

    for (var i = 0; i < boldCount; i++) {
      refinedText = refinedText.replaceFirst('***', '<bold>');
      refinedText = refinedText.replaceFirst('***', '</bold>');
    }

    return StyledText(
      textAlign: TextAlign.justify,
      text: '        <bold>$textType:</bold> $refinedText',
      tags: {
        'bold': StyledTextTag(
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      },
    );
  }
}
