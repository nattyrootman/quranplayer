import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/models/quran_tlansaltion.dart';
import 'package:myapp/models/surahs_model.dart';
import 'package:just_audio/just_audio.dart';


class QuranServiceController extends GetxController {
  static QuranServiceController get instance => Get.find();

  final fr = "https://api.alquran.cloud/v1/quran/fr.leclerc";
  final english = "https://api.alquran.cloud/v1/quran/en.walk";
  static const String baseUrl = 'http://api.alquran.cloud/v1/quran/ar.alafasy';

  Rx<AudioPlayer> player = Rx(AudioPlayer());

  List<MyQuran> myQuran = [];

  Future<List<QuranAudio>> getCompleteQuran() async {
    try {
      final response = await http.get(Uri.parse(english));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final surahs = data['data']['surahs'] as List;

        return surahs.map((surah) => QuranAudio.fromJson(surah)).toList();
      } else {
        throw Exception('Failed to load Quran data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load Quran data: $e');
    }
  }
}
