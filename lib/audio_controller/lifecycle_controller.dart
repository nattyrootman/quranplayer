import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/quran_translation_repo.dart';
import 'audio_initalizer_controller.dart';
import 'singleerplayer.dart';

class LifecycleController extends GetxController with WidgetsBindingObserver {
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
   
    super.dispose();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
      // _handleResumed();

      // break;
      case AppLifecycleState.inactive:
      // _handleInactive();
      // break;
      case AppLifecycleState.paused:
        // _handlePaused();
        break;
      case AppLifecycleState.detached:
        detache();

        break;
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
    }
  }

  void detache() {
    final playerController = Get.put(AudioSetUpController());
    final playerController1 = Get.put(SinglePlayerController());
    playerController.player.value.stop();
    playerController1.player.value.stop();
  }

  void _handleResumed() {
    // Clear any cached data that might cause black screen
    Get.delete<QuranTranslationController>();
    Get.delete<AudioSetUpController>();
    Get.delete<SinglePlayerController>();
    //Get.delete<FavoriteController>();
    //Get.delete<ThemeController>();
    //Get.delete<ParamController>();
    
    // Replace with your screen controllers

    // Clear image cache
    imageCache.clear();
    imageCache.clearLiveImages();

    // Reinitialize necessary controllers
    Get.put(QuranTranslationController());
    Get.put(AudioSetUpController());
    Get.put(SinglePlayerController());
    //Get.put(ThemeController());
    //Get.put(ParamController());
    //Get.put(FavoriteController());

    // Refresh current screen
    if (Get.currentRoute != '') {
      Get.forceAppUpdate();
    }
  }
}
