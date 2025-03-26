import 'package:get/get.dart';
import 'package:myapp/themes/my_ttheme_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  Rx<bool> isDark = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadTheme();
  }

  void loadTheme() async {
    final pref = await SharedPreferences.getInstance();
    isDark.value = pref.getBool('isDark') ?? true;
  }

  void toggleMode() async {
    isDark.value = !isDark.value;
    final pref = await SharedPreferences.getInstance();
    pref.setBool('isDark', isDark.value);
  }

  getTheme() {
    return isDark.value ? MythemeData.darkThemData : MythemeData.ligthThem;
  }
}
