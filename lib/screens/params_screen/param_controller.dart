import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/stylles/my_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParamController extends GetxController {
  static ParamController get instance => Get.find();
  RxDouble size = 24.0.obs;
  RxBool ischeck = false.obs;
  RxString menuIemText = "Uthmany".obs;
  RxInt selectedIndex = 0.obs;
  RxDouble spaceWord = 2.0.obs;
  RxDouble spaceLetter = 2.0.obs;
  RxDouble lineHeight = 2.0.obs;
  RxDouble defaultspeed = 1.0.obs;
  Rx<Color> color = Colors.grey.shade300.obs;
  RxList speed = [0.75, 1.0, 1.25, 1.5, 2.0].obs;
  RxInt index = 0.obs;
  RxDouble slider = 0.0.obs;

  RxList<String> options1 = [
    'Uthmany',
    'Naskh',
    'Hafs',
    MyStyles.arabMedium.fontFamily.toString(),
    MyStyles.arab.fontFamily.toString()
  ].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    _laodData();
  }

  _laodData() async {
    var pref = await SharedPreferences.getInstance();
    size.value = pref.getDouble('size') ?? 24.0;
    menuIemText.value = pref.getString('menuIemText') ?? "Naskh";
    ischeck.value = pref.getBool('ischeck') ?? false;
    options1.value = pref.getStringList('options1') ??
        [
          'Uthmany',
          'Naskh',
          'Hafs',
          MyStyles.arabMedium.fontFamily.toString(),
          MyStyles.arab.fontFamily.toString()
        ];
  }

  saveRadioData(value) async {
    menuIemText.value = value;
    final pref = await SharedPreferences.getInstance();
    pref.setStringList('options1', options1);
    pref.setString('menuIemText', menuIemText.value);
  }

  void change(value) async {
    final pref = await SharedPreferences.getInstance();
    size.value = value;
    pref.setDouble('size', size.value);
  }

  @override
  void dispose() async {
    // TODO: implement dispose
    final pref = await SharedPreferences.getInstance();
    pref.remove('size');

    super.dispose();
  }
}
