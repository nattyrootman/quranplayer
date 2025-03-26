import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/themes/theme_controller.dart';

import '../../audio_controller/audio_initalizer_controller.dart';
import '../../audio_controller/singleerplayer.dart';
import '../../stylles/my_styles.dart';
import '../params_screen/param_controller.dart';

class DetailListCard extends StatelessWidget {
  final index;
  final int id;
  final String text;
  final String translation;
  final String english;

  const DetailListCard({
    super.key,
    required this.index,
    required this.id,
    required this.text,
    required this.translation,
    required this.english,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AudioSetUpController>();
    final isDark = Get.find<ThemeController>();
    final font = Get.find<ParamController>();
      final drop = Get.find<SinglePlayerController>();

    var bism = "بِسْمِ ٱللّٰهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ";
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Container(
              padding: const EdgeInsets.all(4.0),
              // color: !Get.isDarkMode? Color.fromARGB(255, 240, 180, 156):Theme.of(context).canvasColor,
              child: Row(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 40, height: 40,
                      //margin: EdgeInsets.all(5),
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        alignment: Alignment.center,
                        image: AssetImage('assets/sun.png'), // Use AssetImage
                        fit: BoxFit
                            .cover, // Adjust the image to cover the container
                      )),
                      child: Text("$id",
                          style: GoogleFonts.roboto(
                              fontSize: 20, color: Colors.black)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
     
                          margin: const EdgeInsets.all(6),
                          padding: const EdgeInsets.all(2.0),
                          child: Obx(() =>  Text(text,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                               
                                fontFamily:font.menuIemText.value,fontSize: font.size.value,height: 2.0)
                                  
                      ))),
                    )
                  ])
                  ),
          const SizedBox(
            height: 10,
          ),
          Column(children: [
               
            
            Container(
                padding: const EdgeInsets.all(8.0),
                 color: !Get.isDarkMode
                    ?const Color.fromARGB(255, 232, 227, 225)
                    : Theme.of(context).cardColor,
    
                    
                child: Text(
                  style: MyStyles.robotoSmal,
                  textAlign: TextAlign.left,
                  translation,
                )),
            const SizedBox(
              height: 10,
            ),

           
            
            
            Container(
              // color: font.color.value,
                padding: const EdgeInsets.all(8.0),
                  color: !Get.isDarkMode
                    ? const Color.fromARGB(255, 245, 217, 217)
                    : Theme.of(context).focusColor,
                child: Text(
                    style: MyStyles.robotoSmal,
                    textAlign: TextAlign.left,
                    english)),
          ])
        ]));
    
  }
}
