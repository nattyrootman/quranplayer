import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myapp/models/policy.dart';

class ProposController extends GetxController {
  static ProposController get instance => Get.find();

  RxString loadJson = "".obs;
  RxList<PrivacyPolicy>? list;
  Rx<Map<String, dynamic>> jsonData = Rx<Map<String, dynamic>>({});
  // Map<String, dynamic>? jsonData;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    _laodData();
  }

  _laodData() async {
   
    var myJson = await rootBundle.loadString("assets/jsons/apropos.json");

    jsonData.value = json.decode(myJson);

    jsonData.value = await json.decode(myJson);
  }
}
