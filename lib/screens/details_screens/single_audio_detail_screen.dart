import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myapp/screens/widgets/detail_list_card.dart';
import 'package:myapp/screens/widgets/single_audio_player.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../audio_controller/audio_initalizer_controller.dart';
import '../../audio_controller/singleerplayer.dart';
import '../../service/query_items.dart';
import '../params_screen/param_controller.dart';
import '../widgets/my_app_bar.dart';

class SingleAudioDetailScreen extends StatefulWidget {
  // final String chaptertitle;
  // final int  chapterIndex;
  const SingleAudioDetailScreen({
    super.key,
  });

  @override
  State<SingleAudioDetailScreen> createState() =>
      _SingleAudioDetailScreenState();
}

class _SingleAudioDetailScreenState extends State<SingleAudioDetailScreen>
    with WidgetsBindingObserver {
  final drop = Get.put(SinglePlayerController());
  final controller = Get.put(AudioSetUpController());
  final paramController = Get.put(ParamController());
  final querycontroller = Get.put(QueryItemsController());

  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  bool ischeck = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    if (mounted) {
      drop.playAudio(drop.currentAyahIndex.value);
      // querycontroller.itemScroll(drop.currentAyahIndex.value);
    }

    //querycontroller.itemScroll(drop.currentAyahIndex.value);
    //drop.playAudio(drop.currentAyahIndex.value);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const bism = "بِسْمِ ٱللّٰهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ";
    return Scaffold(
        appBar: ischeck? PreferredSize(
            preferredSize: const Size.fromHeight(65),
            child: Obx(() => MyAppBar(
                onPress: () {
                  drop.player.value.stop();
                  Get.back();
                },
                chaptertitle:
                    drop.quran.value[drop.chapterIndex.value].translation,
                chapterIndex: drop.quran.value[drop.chapterIndex.value].id)
                )):null,
        bottomNavigationBar:ischeck? Container(
            width: double.infinity,
            color: const Color.fromARGB(255, 199, 7, 216),
            height: 65,
            child: const SingleAudioWidget()):null,
        body: Obx(() => Column(
              children: [
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
                drop.quran.value[controller.chapterIndex.value].translation ==
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
                        child: Text(
                          bism,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                const SizedBox(height: 10),
                Obx(() {
                  return Flexible(
                    flex: 1,
                    child: ScrollablePositionedList.builder(
                        scrollDirection: Axis.vertical,
                        itemPositionsListener:
                            querycontroller.itemPositionsListener,
                        scrollOffsetController:
                            querycontroller.scrollOffsetController,
                        //itemPositionsListener: querycontroller.itemPositionsListener,
                        scrollOffsetListener:
                            querycontroller.scrollOffsetListener,
                        shrinkWrap: true,
                        itemScrollController:
                            querycontroller.itemScrollController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: drop
                            .quran.value[drop.chapterIndex.value].verses.length,
                        itemBuilder: (context, index) {
                          // drop.currentAyahIndex.value = index;
                          final data = drop.quran.value[drop.chapterIndex.value]
                              .verses[index];

                          drop.quran.value[drop.chapterIndex.value].verses;
                          // querycontroller.verses.value = index;

                          return InkWell(
                            onTap: () {
                              drop.currentAyahIndex.value = index;

                              drop.playAudio(drop.position.value.inSeconds);
                              querycontroller.itemScroll(index);
                            },
                            onLongPress: () {
                              drop.currentAyahIndex.value = index;
                              drop.playAudio(index);
                              querycontroller.itemScroll(index);
                            },
                            child: Obx(() => Card(
                                  color: drop.currentAyahIndex.value == index
                                      ? !Get.isDarkMode
                                          ? Colors.greenAccent
                                          : const Color.fromARGB(
                                              255, 6, 172, 11)
                                      : Theme.of(context).cardColor,
                                  child: Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                              onPressed: () async {
                                                await Clipboard.setData(
                                                    ClipboardData(
                                                        text:
                                                            "[${data.id}] ${data.text}\n\n${data.translation}\n\n${data.english}"));

                                                Get.rawSnackbar(
                                                    title: "succés",
                                                    messageText: Text(
                                                        "Text copied to clipboard"));
                                              },
                                              icon: const Icon(Icons.copy))),
                                      DetailListCard(
                                          index: index,
                                          id: data.id,
                                          text: data.text,
                                          translation: data.translation,
                                          english: data.english),
                                    ],
                                  ),
                                )),
                          );
                        }),
                  );
                }),
              ],
            )));
  }
}
