import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myapp/screens/widgets/detail_list_card.dart';
import 'package:myapp/screens/widgets/my_app_bar.dart';
import 'package:myapp/screens/widgets/player_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../audio_controller/audio_initalizer_controller.dart';
import '../../service/query_items.dart';
import '../params_screen/param_controller.dart';

class DetailScreen extends StatefulWidget {
  // final String chaptertitle;
//  final chapterIndex;

  const DetailScreen({
    super.key,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with WidgetsBindingObserver {
  final controller = Get.put(AudioSetUpController());
  final queryController = Get.put(QueryItemsController());
  final audicontroller = Get.put(AudioSetUpController());
  final font = Get.put(ParamController());
  var ischeck = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    if (mounted) {
      controller.initAudio(0);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const bism = "بِسْمِ ٱللّٰهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ";

    return SafeArea(
      child: Scaffold(
          appBar:ischeck? PreferredSize(
              preferredSize: const Size.fromHeight(65),
              child: Obx(() => MyAppBar(
                  onPress: () {
                    audicontroller.player.value.stop();
                    Get.back();
                  },
                  chaptertitle: controller
                      .quran.value[controller.chapterIndex.value].translation,
                  chapterIndex:
                      controller.quran.value[controller.chapterIndex.value].id))):null,
          bottomNavigationBar:ischeck? Container(
              width: double.infinity,
              color: const Color.fromARGB(255, 199, 7, 216),
              height: 65,
              child: const PlayerWidget()):null,
          body: Obx(
            () => Column(children: [
                 Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          ischeck=!ischeck;
                        });
                      },
                      child: Icon(Icons.open_in_full,size: 20.0,))),
              const SizedBox(height: 10),
              controller.quran.value[controller.chapterIndex.value].translation ==
                      "Le repentir"
                  ? const SizedBox()
                  : Container(
                      // alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 1.3,
                      height: 30,
      
                      padding: const EdgeInsets.only(top: 2, bottom: 2),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/sun.png'), // Use AssetImage
                        fit: BoxFit
                            .cover, // Adjust the image to cover the container
                      )),
                      child: Text(bism,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
              const SizedBox(height: 10),
              Obx(() {
                return Flexible(
                  flex: 1,
                  child: ScrollablePositionedList.builder(
                      scrollOffsetController:
                          queryController.scrollOffsetController,
                      //itemPositionsListener: querycontroller.itemPositionsListener,
                      scrollOffsetListener: queryController.scrollOffsetListener,
                      shrinkWrap: true,
                      itemScrollController: queryController.itemScrollController,
                      itemCount: controller.quran
                          .value[controller.chapterIndex.value].verses.length,
                      itemBuilder: (context, index) {
                        // controller.currentAyahIndex.value = index;
                        final data = controller.quran
                            .value[controller.chapterIndex.value].verses[index];
      
                        return InkWell(
                            onTap: () => controller.initAudio(index),
                            child: Obx(() => Card(
                                  color:
                                      controller.currentAyahIndex.value == index
                                          ? !Get.isDarkMode
                                              ? Colors.greenAccent
                                              : Colors.teal
                                          : Theme.of(context).cardColor,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                            onPressed: () async {
                                              await Clipboard.setData(ClipboardData(
                                                  text:
                                                      "[${data.id}] ${data.text}\n\n${data.translation}\n\n${data.english}"));
      
                                              Get.rawSnackbar(
                                                  title: "succés",
                                                  messageText: Text(
                                                      "Text copied to clipboard"));
                                            },
                                            icon: const Icon(Icons.copy)),
                                      ),
                                      DetailListCard(
                                          index: index,
                                          id: data.id,
                                          text: data.text,
                                          translation: data.translation,
                                          english: data.english),
                                    ],
                                  ),
                                )));
                      }),
                );
              }),
            ]),
          )),
    );
  }
}
