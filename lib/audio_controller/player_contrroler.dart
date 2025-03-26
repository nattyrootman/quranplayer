import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AudioPlayerController extends GetxController {
  static AudioPlayerController get instance => Get.find();
  Rx<String> collection = 'Maher_French'.obs;


  

  RxBool isExpanded = false.obs;
  Rx<List<DropdownMenuEntry<String>>> items = Rx([
    const DropdownMenuEntry(value: 'Maher_French', label: "Maher-Français"),
    const DropdownMenuEntry(value: 'Saheeh_english', label: "Saheeh-Anglais"),
    const DropdownMenuEntry(value: 'french_saheeh', label: "Saheeh-Français"),
    const DropdownMenuEntry(value: 'Soudais_english', label: "Soudais-english"),
    const DropdownMenuEntry(value: 'matroud', label: "Abdullah Matroud"),
    const DropdownMenuEntry(value: 'Yasser_Dossari', label: "Yasser Dossari"),
    const DropdownMenuEntry(value: 'juany', label: 'Abdullah Juany',labelWidget: Text("Par chapitre")),
    const DropdownMenuEntry(value: 'maher', label: 'Maher Muaqli'),
    const DropdownMenuEntry(value: 'basit', label: "Abdul Basit"),
    const DropdownMenuEntry(value: 'Ibrahim_Jibreen', label: "Ibrahim Jibreen"),
    const DropdownMenuEntry(value: 'mouhsin', label: "Mohamed Mohaisany"),
    const DropdownMenuEntry(value: 'nabil_rafai', label: "Nabil Rafai"),
    const DropdownMenuEntry(value: 'nmajed', label: "Abdulrahman Almajed"),
    const DropdownMenuEntry(value: 'saad_ghamdi', label: "Saad AlGhamdi"),
    const DropdownMenuEntry(value: 'sudais', label: "Abubakr Shatry"),
    const DropdownMenuEntry(value: 'salah_bukhatir', label: "Salah Bukhatir"),
    const DropdownMenuEntry(value: 'qasm', label: "Abdulmohsen Alqasim"),
    const DropdownMenuEntry(value: 'khalil_jaleel', label: "Khalil Jaleel"),
    const DropdownMenuEntry(value: 'khalaf', label: "Abdullah Khalaf"),
    const DropdownMenuEntry(value: 'salah_budair', label: "Salah Al Bedair"),
    const DropdownMenuEntry(
        value: 'mishary_alafay', label: "Mishary Al Afassy"),
    const DropdownMenuEntry(value: 'basfar', label: "Abdullah Basfar"),
    const DropdownMenuEntry(
        value: 'abdurahman_sudais', label: "Abdurrahman Sudais"),
  ]);




}

  





    


