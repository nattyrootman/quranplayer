// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/audio_controller/audio_initalizer_controller.dart';
import 'package:myapp/screens/nav_bars/main_nav.dart';
import 'package:myapp/screens/widgets/dropdown_menu.dart';
import 'package:myapp/screens/widgets/list_builder.dart';
import 'package:myapp/service/quran_translation_repo.dart';
import 'package:myapp/share_widegts.dart/text_ffield.dart';
import 'package:myapp/themes/theme_controller.dart';
import '../../audio_controller/player_contrroler.dart';
import '../../audio_controller/singleerplayer.dart';

// Suggested code may be subject to a license. Learn more: ~LicenseLog:1625629476.

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AudioSetUpController>();
    final drop = Get.find<SinglePlayerController>();
    final themeController = Get.find<ThemeController>();
    final quranListController = Get.find<QuranTranslationController>();
    final listcontroller = Get.find<AudioPlayerController>();
    return SafeArea(
        child: Scaffold(
            drawer: MainNav(),
            //resizeToAvoidBottomInset: false,
            appBar: AppBar(
              titleSpacing: 0,
              actions: [
                MySearchField(),
               
                SizedBox(
                  width: 4,
                )
              ],
              //backgroundColor: Theme.of(context).primaryColorDark,
              title: const Text("QuranPlayer"),
            ),
            body: Column(children: [
              SizedBox(height: 15),
               MyDropDownButton(),
              SizedBox(height: 10),
                 MyListBuilder()
            ]),
          ));
  }
}

class MyExpandableList extends StatelessWidget {
  const MyExpandableList({super.key});

  @override
  Widget build(BuildContext context) {
    final listcontroller = Get.put(AudioPlayerController());
    return ExpansionTile(
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        title: Text("Reciters"),
        children: [
      
          ListTile(title: Text(" audio by aya"),
          subtitle: MyDropDownButton(),
          
          )
      
        ],
      
      
        
        
        
      
      
      
      
    );
  }
}






/*class MyFloatingButton extends StatelessWidget {
  const MyFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return DetailScreen();
            });
      },
      child: Icon(Icons.circle),
    );
  }
}
*/