import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:myapp/models/quran_tlansaltion.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/query_items.dart';

class SinglePlayerController extends GetxController
    with WidgetsBindingObserver {
  static SinglePlayerController get instance => Get.find();

  Rx<AudioPlayer> player = Rx(AudioPlayer());

  Rx<bool> isPlaying = false.obs;
  Rx<bool> isLoading = false.obs;
  Rx<Duration> duration = Duration.zero.obs;
  Rx<Duration> position = Duration.zero.obs;
  Rx<int> currentAyahIndex = 0.obs;
  Rx<int> chapterIndex = 0.obs;
  Rx<bool> autoPlay = false.obs;
  Rx<double> playbackSpeed = 1.0.obs;
  Rx<List<Verses>> verses = Rx<List<Verses>>([]);
  Rx<ScrollController> scrollController = Rx(ScrollController());
  Rx<List<MyQuran>> quran = Rx<List<MyQuran>>([]);
  final RxDouble currentPosition = 0.0.obs;
  Rx<Duration> remainingTime = Duration.zero.obs;
  Rx<Duration> rest = Duration.zero.obs;
  RxString errorMessage = "".obs;
  RxInt selectedVerse = 0.obs;
  RxInt element = 0.obs;
  final queryController = Get.put(QueryItemsController());

  @override
  void onInit() {
    super.onInit();

    print("singlAudioController");
    setPlayer();

    readMusicData();
  }

  readMusicData() async {
    final pref = await SharedPreferences.getInstance();
    chapterIndex.value = pref.getInt("chapterIndex") ?? 0;
    currentAyahIndex.value = pref.getInt("currentAyahIndex") ?? 0;
    isPlaying.value = pref.getBool("isPlaying") ?? false;
  }

  writeMusicData() async {
    final pref = await SharedPreferences.getInstance();
    pref.setInt("chapterIndex", chapterIndex.value);
    pref.setInt("currentAyahIndex", currentAyahIndex.value);
    // pref.setInt("len", quran.value[chapterIndex.value].verses.length);
    pref.setBool("isPlaying", isPlaying.value);
  }

  playAudio(int index) async {
    isLoading.value = true;
    //chapterIndex.value = index;
      if(position.value.inSeconds!=0){
        currentAyahIndex.value = position.value.inSeconds;
    queryController.itemScroll(currentAyahIndex.value);

      }
    

    try {
      // isLoading.value = true;
      if (quran.value[chapterIndex.value].audio.isNotEmpty) {
        await player.value.setUrl(quran.value[chapterIndex.value].audio,
            tag: MediaItem(
                id: '${chapterIndex.value}',
                title: quran.value[chapterIndex.value].translation));
        isLoading.value = false;
        isPlaying.value = true;
        await player.value.play();
      } else {
        Get.snackbar("title", "une erreur s'est passée ");
      }
    } on PlayerException catch (e) {
      isLoading.value = false;
      isPlaying.value = false;

      Get.rawSnackbar(messageText: Text(e.message!));
    } catch (e) {
      Get.rawSnackbar(messageText: Text(e.toString()));
    } finally {
      isLoading.value = false;
    }
  }

  void setPlayer() async {
    player.value.playerStateStream.listen((state) {
      if (state.playing) {
        isPlaying.value = true;
        //isLoading.value = false;
      } else {
        isPlaying.value = false;
      }
      //isPlaying.value = event.playing;
    });
    player.value.positionStream.listen((event) async {
      position.value = event;

      // scroller();
    });

    player.value.durationStream.listen((event) {
      duration.value = event ?? Duration.zero;
    });

    player.value.playerStateStream.listen((state) async {
      if (state.processingState == ProcessingState.completed) {
        Future.delayed(const Duration(milliseconds: 300), () {
          nextBtn();
          // This triggers the next audio item after a short delay
        });
      }
    });
  }

  nextBtn() async {
    if (chapterIndex.value < quran.value.length - 1) {
      chapterIndex.value++;
    } else {
      chapterIndex.value = 0;
    }
    playAudio(chapterIndex.value);
    //setAudioPLayer(quran.value[chapterIndex.value].audio);
  }

  prevBtn() {
    if (chapterIndex.value > 0) {
      chapterIndex.value--;
    }
    playAudio(chapterIndex.value);
    //setAudioPLayer(quran.value[chapterIndex.value].audio);
  }

  togglePlay() async {
    if (isPlaying.value) {
      await player.value.pause();
      //isPlaying.value = false;
    } else {
      await player.value.play();
      // isPlaying.value = true;
    }
  }

  String getformatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
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
    // Wakelock.disable();
    super.onClose();
  }
}
