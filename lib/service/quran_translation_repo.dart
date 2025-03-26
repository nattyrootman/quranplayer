import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:myapp/models/quran_tlansaltion.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../audio_controller/player_contrroler.dart';

class QuranTranslationController extends GetxController
    with WidgetsBindingObserver {
  static QuranTranslationController get instance => Get.find();
  final TextEditingController textController = TextEditingController();
  final controller = Get.put(AudioPlayerController());
  var myQuaran = <MyQuran>[].obs;
  final RxBool isLoading = true.obs;
  final RxString searchQuery = ''.obs;
  final key = "list".obs;
  final firebase = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    //WidgetsBinding.instance.addObserver(this);
   // fetchData();
    getPrefernces();
    // getListVerses();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

 /* Future<void> fetchData() async {
    isLoading.value = true;
    try {
      // Fetch data and assign to quranList
      myQuaran.value =
          await getQuranTranslation(); // Replace with your data fetching logic
    } catch (e) {
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }*/

  Future<List<MyQuran>> getQuranTranslation() async {
    // final controller = Get.put(AudioPlayerController());

    List<MyQuran> quran = [];
    try {
      final store = await FirebaseFirestore.instance
          .collection(controller.collection.value)
          .orderBy('id')
          .get();
      setPrefercences();
      return store.docs.map((doc) => MyQuran.fromJson(doc.data())).toList();
    } on FirebaseException catch (e) {
      throw Exception('Failed to load Quran data: $e');
    } catch (e) {
      throw Exception('Failed to load Quran data: $e');
    }
  }

  getPrefernces() async {
    final pref = await SharedPreferences.getInstance();
    controller.collection.value =
        pref.getString("collection") ?? "Saheeh_english";
  }

  setPrefercences() async {
    final pref = await SharedPreferences.getInstance();
    pref.setString("collection", controller.collection.value);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
