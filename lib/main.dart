import 'package:dnd_spells/objects/dnd_spell_object.dart';
import 'package:dnd_spells/pages/spell_page.dart';
import 'package:dnd_spells/providers/dnd_selected_spell_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/spell_list_page.dart';
import 'providers/dnd_class_provider.dart';
import 'providers/dnd_spell_list_view_provider.dart';
import 'providers/dropdown_class_menu_provider.dart';
import 'providers/lang_provider.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<DndClassProvider>(
              create: (_) => DndClassProvider()),
          ChangeNotifierProvider<DndSpellListViewProvider>(
              create: (_) => DndSpellListViewProvider()),
          ChangeNotifierProvider<DropdownClassMenuProvider>(
              create: (_) => DropdownClassMenuProvider()),
          ChangeNotifierProvider<LangProvider>(create: (_) => LangProvider()),
          ChangeNotifierProvider<DndSelectedSpellProvider>(
            create: (_) => DndSelectedSpellProvider(),
          )
        ],
        child: MainPageView(),
        // child: SpellsPage(
        //     storage: SpellStorage(),
        //     ),
      ),
    ),
  );
}

class MainPageView extends StatefulWidget {
  MainPageView({Key? key}) : super(key: key);

  DndSpellObj? spellObj;

  @override
  State<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  bool loaded = false;
  PageController pageViewController = PageController();
  double actualPage = 0;

  @override
  Widget build(BuildContext context) {
    if (context.watch<DndSelectedSpellProvider>().dndSpellObj != null) {
      if (actualPage == 0) {
        updatePage(1);
      }
    }
    return WillPopScope(
      onWillPop: (() => Future.sync(() {
            if (actualPage == 0) {
              return true;
            } else {
              context.read<DndSelectedSpellProvider>().updateDndSpellObj(null);

              updatePage(0);
              return false;
            }
          })),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(234, 212, 176, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(58, 44, 28, 1),
          title: const Text('Spells'),
          leading: actualPage != 0
              ? IconButton(
                  onPressed: () {
                    context
                        .read<DndSelectedSpellProvider>()
                        .updateDndSpellObj(null);

                    updatePage(0);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                )
              : null,
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageViewController,
          children: const [
            SpellListPage(),
            SpellPage(),
          ],
        ),
      ),
    );
  }

  updatePage(int index) async {
    actualPage = index.toDouble();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        pageViewController.animateToPage(
          index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      });
    });
  }
}
