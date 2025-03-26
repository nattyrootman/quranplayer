import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/models/quran_tlansaltion.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class QueryItemsController extends GetxController {
  static QueryItemsController get instance => Get.find();
  final Rx<TextEditingController> textController = Rx(TextEditingController());
  final Rx<TextEditingController> textVerseController =
      Rx(TextEditingController());
  //final ScrollController scrollController = ScrollController();
  Rx<ScrollController> scrollController = Rx(ScrollController());
  Rx<List<MyQuran>> quran = Rx<List<MyQuran>>([]);
  final RxBool isLoading = false.obs;
  final Rx<String> searchQuery = ''.obs;
  final Rx<String> searchQueryVers = ''.obs;
  Rx<int> selectedVerse = 1.obs;
  RxList<Verses> verses = <Verses>[].obs;
  var filterList = <MyQuran>[].obs;

  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  List<MyQuran> searchQuran(List<MyQuran> quranlist, String query) {
    if (query.trim().isEmpty || textController.value.text.trim().isEmpty) {
      return quranlist;
    }
    return quranlist.where((quran) {
      return quran.name.toLowerCase().contains(query.toLowerCase()) ||
          // quran.id.toString().toLowerCase().contains(query.toLowerCase()) ||
          quran.translation.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  List<Verses> searchQuranVerses(List<Verses> quranlist, String query) {
    if (query.trim().isEmpty || textVerseController.value.text.trim().isEmpty) {
      return quranlist;
    }
    return quranlist.where((quran) {
      return quran.id.toString().toLowerCase().contains(query.toLowerCase());
      //||
      //quran.text.toLowerCase().contains(query.toLowerCase()) ||
      // quran.translation.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  itemScroll(int item) {
    if (itemScrollController.isAttached) {
      itemScrollController.scrollTo(
          alignment: 0.1,
          index: item,
          duration: Duration(seconds: 2),
          curve: Curves.easeInOutCubic);
    }
    // audioController.currentAyahIndex.value = item;
    // singleAudioControler.currentAyahIndex.value = item;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textController.value.dispose();
    textVerseController.value.dispose();
    super.dispose();
  }
}
