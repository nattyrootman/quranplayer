import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/models/quran_tlansaltion.dart';
import 'package:get_storage/get_storage.dart';

class FavoriteController extends GetxController {
  RxBool isFavorite1 = false.obs;
  static FavoriteController get to => Get.find();
  RxList<MyQuran> favoriteQuran = <MyQuran>[].obs;
  RxList<MyQuran> favorites = <MyQuran>[].obs;
  final String storageKey = 'quran_favorites';
  final storage = GetStorage();
  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }


  void loadFavorites() {
    final storedFavorites = storage.read<List>(storageKey);
    if (storedFavorites != null) {
      favorites.value = storedFavorites
          .map((item) => MyQuran.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    }
  }

  // Save favorites to persistent storage
  void saveFavorites() {
    final favoritesJson = favorites.map((verse) => verse.toJson()).toList();
    storage.write(storageKey, favoritesJson);
  }

  // Toggle favorite status of a verse
  void toggleFavorite1(MyQuran verse) {
    if (isFavorite(verse)) {
      favorites.removeWhere((v) => v.id == verse.id);
      
      Get.showSnackbar(const GetSnackBar(
        messageText: Text("c'est supprimé de la list  favorite "),
      ));
    } else {
      favorites.add(verse);
      
      Get.rawSnackbar(
        messageText: Text("c'est ajouté dans la liste favorite"),
      );
    }
    saveFavorites();
  }

  // Check if a verse is favorite
  bool isFavorite(MyQuran verse) {
    return favorites.any((v) => v.id == verse.id);
  }
}
