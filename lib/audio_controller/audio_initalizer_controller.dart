import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'package:myapp/models/quran_tlansaltion.dart';
import 'package:myapp/service/query_items.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioSetUpController extends GetxController with WidgetsBindingObserver {
  static AudioSetUpController get instance => Get.find();

  Rx<AudioPlayer> player = Rx(AudioPlayer());

  Rx<bool> isPlaying = false.obs;
  Rx<bool> isLoading = false.obs;

  Rx<Duration> duration = Duration.zero.obs;
  Rx<Duration> position = Duration.zero.obs;
  Rx<int> currentAyahIndex = 0.obs;
  Rx<int> chapterIndex = 0.obs;
  Rx<double> playbackSpeed = 1.0.obs;
  RxInt seleced = 1.obs;
  Rx<ScrollController> scrollController = Rx(ScrollController());
  Rx<List<MyQuran>> quran = Rx<List<MyQuran>>([]);
    final queryController = Get.put(QueryItemsController());

  

 
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);

    setAudio();
    readMusicData();
    print("AudioSetUpController");
  }

  readMusicData() async {
    final pref = await SharedPreferences.getInstance();
    chapterIndex.value = pref.getInt("chapterIndex") ?? 0;
    currentAyahIndex.value = pref.getInt("currentAyahIndex") ?? 0;
    isPlaying.value = pref.getBool("isPlaying") ?? false;
//quran.value[chapterIndex.value].verses.length = pref.getInt("len") ?? 0;
  }

  writeMusicData() async {
    final pref = await SharedPreferences.getInstance();
    pref.setInt("chapterIndex", chapterIndex.value);
    pref.setInt("currentAyahIndex", currentAyahIndex.value);
    // pref.setInt("len", quran.value[chapterIndex.value].verses.length);
    pref.setBool("isPlaying", isPlaying.value);
  }

  initAudio(int index) async {
    isLoading.value = true;
    if (index >= 0 && index < quran.value[chapterIndex.value].verses.length) {
      currentAyahIndex.value = index;
     queryController.itemScroll(currentAyahIndex.value);
    }

    try {
      final chapterItem = quran.value[chapterIndex.value];
      final audioV = chapterItem.verses[currentAyahIndex.value];

      if (audioV.secondAudio.isNotEmpty && audioV.audio.isNotEmpty) {
        final playlist = ConcatenatingAudioSource(children: [
          AudioSource.uri(
              Uri.parse(quran.value[chapterIndex.value]
                  .verses[currentAyahIndex.value].audio),
              tag: MediaItem(
                  id: '${chapterIndex.value}',
                  title: quran.value[chapterIndex.value].translation)),
          AudioSource.uri(
              Uri.parse(quran.value[chapterIndex.value]
                  .verses[currentAyahIndex.value].secondAudio),
              tag: MediaItem(
                  id: '${chapterIndex.value}',
                  title: quran.value[chapterIndex.value].translation)),
        ]);

        await player.value.setAudioSource(playlist);

        isLoading.value = false;
        isPlaying.value = true;
        await player.value.play();
      } else {
        await player.value.setUrl(
            quran
                .value[chapterIndex.value].verses[currentAyahIndex.value].audio,
            tag: MediaItem(
                id: '${chapterIndex.value}',
                title: quran.value[chapterIndex.value].translation));
        isLoading.value = false;
        isPlaying.value = true;
        await player.value.play();
      }
    } on PlayerException catch (e) {
      Get.rawSnackbar(messageText: Text(e.message!));
      isPlaying.value = false;
    } catch (e) {
      Get.rawSnackbar(message: e.toString());
    } finally {
      //isPlaying.value = false;
      isLoading.value = false;
    }
  }

  void setAudio() async {
    try {
      player.value.playerStateStream.listen((state) {
        if (state.playing) {
          isPlaying.value = true;
        } else {
          isPlaying.value = false;
        }
      });
      player.value.positionStream.listen((event) {
        position.value = event;
        //.value = position.value.inSeconds ~/ 6;
      });
      player.value.durationStream.listen((event) {
        print('Duration event: $event');
        duration.value = event ?? Duration.zero;
      });

      player.value.playerStateStream.listen((state) async {
        if (state.processingState == ProcessingState.completed) {
          if (quran.value[chapterIndex.value].verses[currentAyahIndex.value]
              .secondAudio.isNotEmpty) {
            Future.delayed(const Duration(milliseconds: 300), () {
              nextBtn();
            });
          } else {
            nextBtn();
          }
        }
      });
    } catch (e) {
      print("*********************************************");
      print(e.toString());
      Get.rawSnackbar(messageText: Text(e.toString()));
    }
  }

  nextBtn() async {
    if (currentAyahIndex.value <
        quran.value[chapterIndex.value].verses.length - 1) {
      currentAyahIndex.value++;
    } else {
      if (chapterIndex.value < quran.value.length - 1) {
        chapterIndex.value++;

        currentAyahIndex.value = 0;
      } else {
        Get.snackbar("title", "Fin de la lecture des chapitres");
      }
    }
    initAudio(currentAyahIndex.value);
  }

  prevBtn() {
    if (currentAyahIndex.value > 0) {
      //  currentAyahIndex.value - 1;
      initAudio(currentAyahIndex.value - 1);
    } else {
      initAudio(currentAyahIndex.value++);
    }
  }

  togglePlay() {
    if (isPlaying.value) {
      player.value.pause();
      //  isPlaying.value = false;
    } else {
      player.value.play();
      // isPlaying.value = true;
    }
  }

  formating(Duration duration) {
    String twoDigit(int n) => n.toString().padLeft(2, "0");
    final minut = twoDigit(duration.inMinutes.remainder(60));
    final second = twoDigit(duration.inSeconds.remainder(60));
    return '$minut:$second';
  }

  scroll(int number) {
    int index = quran.value[chapterIndex.value].verses
        .indexWhere((verse) => verse.id == number);
    if (index != -1) {
      scrollController.value
          .animateTo(index * 250.0, // Approximate height of ListTile
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    player.value.dispose();
    scrollController.value.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    player.value.dispose();

    super.onClose();
  }
}
