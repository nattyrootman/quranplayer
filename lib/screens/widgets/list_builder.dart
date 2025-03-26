import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/screens/details_screens/single_audio_detail_screen.dart';
import 'package:myapp/service/query_items.dart';

import '../../audio_controller/audio_initalizer_controller.dart';
import '../../audio_controller/singleerplayer.dart';
import '../../favorite_screen/favorite_controller/favorite_controller.dart';
import '../../service/quran_translation_repo.dart';
import '../../stylles/my_styles.dart';
import '../details_screens/detail_screen.dart';

// Use Obx only where needed and ensure Expanded is in a proper parent

class MyListBuilder extends StatefulWidget {
  const MyListBuilder({super.key});

  @override
  State<MyListBuilder> createState() => _MyListBuilderState();
}

class _MyListBuilderState extends State<MyListBuilder> {
  final controller = Get.find<AudioSetUpController>();
  final drop = Get.find<SinglePlayerController>();
  final quranListController = Get.find<QuranTranslationController>();
  final queryController = Get.find<QueryItemsController>();
  final favoriteController = Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => FutureBuilder(
        future: quranListController.getQuranTranslation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.connectionState == ConnectionState.none) {
            return const Text("Verifiez votre connexion");
          }
          if (snapshot.hasError) {
            return const Text(" error , data not found");
          }
          //
          final filterList = queryController.searchQuran(
              snapshot.data!, queryController.searchQuery.value);

          return Expanded(
            flex: 1,
            child: snapshot.data!.isEmpty
                ? const Center(child: Text("No data found"))
                : Obx(() {
                  final filterList = queryController.searchQuran(
                  snapshot.data!, queryController.searchQuery.value);
                    return ListView.builder(
                        shrinkWrap: true,
                        //  controller: controller.scrollController.value,
                        itemCount: filterList.length,
                        itemBuilder: (context, index) {
                          final data = filterList[index];
                          return Obx(() => Card(
                                color: data.verses[0].audio.isNotEmpty
                                    ? controller.chapterIndex.value == index
                                        ? const Color.fromARGB(255, 8, 190, 102)
                                        : null
                                    : drop.chapterIndex.value == index
                                        ? Colors.greenAccent
                                        : null,
                                child: ListTile(
                                    onTap: () async {
                                      queryController
                                          .textController.value.text = '';
                                      queryController.searchQuery.value = '';
                                      controller.quran.value = filterList;
                                      controller.chapterIndex.value = index;
                                      drop.quran.value = filterList;
                                      drop.chapterIndex.value = index;
                                       //quranListController.verses.value =
                                       // filterList[index].verses;

                                       //queryController.verses.value=filterList[index].verses;

                                      if (data.verses[0].audio.isNotEmpty) {
                                        controller.player.value.stop();
                                        drop.player.value.stop();
                                        controller.writeMusicData();
                                        Get.to(
                                            curve: Curves.bounceIn,
                                            () => const DetailScreen());
                                      } else {
                                        controller.player.value.stop();
                                        drop.player.value.stop();

                                        Get.to(const SingleAudioDetailScreen());
                                      }
                                    },
                                    selectedColor:
                                        const Color.fromARGB(255, 47, 36, 36),
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          const AssetImage("assets/sun.png"),
                                      //backgroundColor: Colors.teal.shade200,
                                      child: Text(
                                        data.id.toString(),
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ),
                                    title: Text(
                                      data.translation,
                                      style: MyStyles.opensanSmll,
                                    ),
                                    subtitle: Text(data.name,
                                        style: const TextStyle(
                                            fontFamily: "Hafs", fontSize: 20)),
                                    trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('${data.totalVerses}/versets'),
                                        InkWell(
                                            onTap: () {
                                              favoriteController
                                                  .toggleFavorite1(data);
                                            },
                                            child: Obx(() => Icon(
                                                  Icons.favorite,
                                                  color: favoriteController
                                                          .isFavorite(data)
                                                      ? Colors.red
                                                      : Colors.grey,
                                                  size: 20,
                                                )))
                                      ],
                                    )),
                              ));
                        });
                  }),
          );
        }));
  }
}
