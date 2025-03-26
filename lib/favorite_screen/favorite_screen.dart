// Suggested code may be subject to a license. Learn more: ~LicenseLog:110307886.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3984014291.
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/screens/details_screens/detail_screen.dart';
import 'package:myapp/screens/details_screens/single_audio_detail_screen.dart';
import 'package:myapp/service/query_items.dart';

import '../audio_controller/audio_initalizer_controller.dart';
import '../audio_controller/singleerplayer.dart';
import '../service/quran_translation_repo.dart';
import '../stylles/my_styles.dart';
import 'favorite_controller/favorite_controller.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final favoriteController = Get.find<FavoriteController>();
    final controller = Get.find<AudioSetUpController>();
    final drop = Get.find<SinglePlayerController>();
    final quranListController = Get.find<QuranTranslationController>();
    final queryController = Get.find<QueryItemsController>();

    return Scaffold(
        appBar: AppBar(
          
          title: const Text('Favorites'),
          actions: const [],
        ),
        body: favoriteController.favorites.isEmpty
            ? const Center(child: Text('No item in your favorite liste yet'))
            : Obx(() => ListView.builder(
                itemCount: favoriteController.favorites.length,
                itemBuilder: (context, int index) {
                  final data = favoriteController.favorites[index];
                  return Card(
                    color: controller.chapterIndex.value == index
                        ? Theme.of(context).cardColor
                        : null,
                    child: ListTile(
                      
                      onTap: () {
                     
                        controller.quran.value =favoriteController.favorites ;
                                  controller.chapterIndex.value = index;
                                  drop.quran.value = favoriteController.favorites;
                                  drop.chapterIndex.value = index;
                                  
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
                    
                                  trailing: 
                                      Text('${data.totalVerses}/versets'),

                                    
                                         
                    ),
                  );
                })));
  }
}
