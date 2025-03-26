import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../audio_controller/audio_initalizer_controller.dart';
import '../audio_controller/singleerplayer.dart';
import '../service/query_items.dart';
import '../service/quran_translation_repo.dart';

class VerseDropDowMenu1 extends StatelessWidget {
  const VerseDropDowMenu1({super.key});

  @override
  Widget build(BuildContext context) {

    final QuranTranslationController verseController = Get.find<QuranTranslationController>();
    final QueryItemsController querycontroller = Get.find<QueryItemsController>();

    final AudioSetUpController audioController = Get.find<AudioSetUpController>();
    final SinglePlayerController singleAudioControler = Get.find<SinglePlayerController>();
    final verse = audioController.quran.value[audioController.chapterIndex.value];


    return Obx(() => DropdownButton<int>(
          value:querycontroller.selectedVerse.value,
          underline: Container(), //
          hint: const Text('Select Verse'),
          dropdownColor: Theme.of(context).cardColor,
          style: const TextStyle(fontSize: 16),
          icon: const Icon(Icons.arrow_drop_down),
          items:audioController.quran.value[audioController.chapterIndex.value].verses.contains("secondAudio")? audioController.quran.value[audioController.chapterIndex.value].verses
              .map((verse) {
            return DropdownMenuItem<int>(
              value: verse.id,
              child: Text(
                'Verset ${verse.id}',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            );
          }).toList():singleAudioControler.quran.value[singleAudioControler.chapterIndex.value].verses
              .map((verse) {
            return DropdownMenuItem<int>(
              value: verse.id,
              child: Text(
                'Verset ${verse.id}',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {

             // querycontroller.selectedVerse.value = value;
              audioController.currentAyahIndex.value = value-1;
              singleAudioControler.currentAyahIndex.value = value-1;
              querycontroller.itemScroll(value);
            }
          },
        ));
  }
}

class VerseDropDowMenu2 extends StatelessWidget {
  const VerseDropDowMenu2({super.key});

  @override
  Widget build(BuildContext context) {
    final querycontroller = Get.put(QueryItemsController());
    final verseController = Get.put(QuranTranslationController());

    final audioController = Get.put(AudioSetUpController());
    final singleAudioControler = Get.put(SinglePlayerController());
    return Obx(() {
      if (audioController
          .quran.value[audioController.chapterIndex.value].verses.isEmpty) {
        return const Text(
          "Aucun verset disponible",
          style: TextStyle(fontSize: 6),
        );
      }

      // Vérifier si selectedVerse est valide, sinon prendre le premier verset
      if (!audioController
          .quran.value[audioController.chapterIndex.value].verses
          .any((verse) => verse.id == querycontroller.selectedVerse.value)) {
        querycontroller.selectedVerse.value = audioController
            .quran.value[audioController.chapterIndex.value].verses.first.id;
      }

      return DropdownButton<int>(
        value: querycontroller.selectedVerse.value,
        underline: Container(), //
        hint: const Text('Select Verse'),
        dropdownColor: Theme.of(context).cardColor,
        style: const TextStyle(fontSize: 16),
        icon: const Icon(Icons.arrow_drop_down),
        items: audioController
            .quran.value[audioController.chapterIndex.value].verses
            .map((verse) {
          return DropdownMenuItem<int>(
            value: verse.id,
            child: Text(
              'Verset ${verse.id}',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          );
        }).toList(),
        onChanged: (int? value) {
          //querycontroller.selectedVerse.value = value!;
          if (value != null) {
            audioController.currentAyahIndex.value = value;
            singleAudioControler.currentAyahIndex.value = value;
            querycontroller.itemScroll(value);
          }
        },
      );
    });
  }
}
