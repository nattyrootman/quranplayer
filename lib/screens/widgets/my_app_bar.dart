// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/screens/widgets/myfull_dialog.dart';
import 'package:myapp/service/query_items.dart';
import 'package:myapp/share_widegts.dart/vers_drop_menu.dart';
import '../../audio_controller/audio_initalizer_controller.dart';
import '../../audio_controller/singleerplayer.dart';
import '../../service/quran_translation_repo.dart';
import '../params_screen/param_controller.dart';

class MyAppBar extends StatelessWidget {
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1700285095.
  final String chaptertitle;
  final chapterIndex;
  final VoidCallback onPress;
  const MyAppBar({super.key, required this.chaptertitle, 
  this.chapterIndex,
   required this.onPress
  
  });

  @override
  Widget build(BuildContext context) {
    final audicontroller = Get.find<AudioSetUpController>();
    final paramController = Get.find<ParamController>();
    final queryItemsController = Get.find<QueryItemsController>();
    final trslationController = Get.find<QuranTranslationController>();
    final singleAudioControler = Get.find<SinglePlayerController>();

    return AppBar(
      
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        title: Row(children: [
          IconButton(
            onPressed: onPress,
              
              icon: Icon(Icons.arrow_back)),
          Expanded(
              child: Text(
            '$chaptertitle $chapterIndex',
            style: TextStyle(fontSize: 14),
          )),
        ]),
        actions: [
          VerseDropDowMenu1(),
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return MyFullDialog();
                  });
            },
            icon: Icon(Icons.more_vert),
          )
        ]);
  }
}




