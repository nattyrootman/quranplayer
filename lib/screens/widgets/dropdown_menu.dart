// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../audio_controller/player_contrroler.dart';

class MyDropDownButton extends StatelessWidget {
   MyDropDownButton({super.key});

final controller = Get.find<AudioPlayerController>();

  @override
  Widget build(BuildContext context) {
    
    return Obx(() => Container(
        margin:  const EdgeInsets.symmetric(horizontal: 15),
        child: DropdownMenu<dynamic>(
          //initialSelection: controller.collection.value,
          hintText: "Reciters",
          inputDecorationTheme: InputDecorationTheme(
              contentPadding: const EdgeInsets.all(10),
              constraints: const BoxConstraints(maxHeight: 45),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                //borderSide: BorderSide.none
              )),
          trailingIcon: const Icon(Icons.arrow_drop_down_circle),
          width: MediaQuery.of(context).size.width / 1.3,
          label: const Text("Recitateurs"),
          leadingIcon: const ImageIcon(
            AssetImage('assets/drop1.png'),
            size: 20,
          ),
          onSelected: (newValue) {
            controller.collection.value = newValue;
          },
          dropdownMenuEntries: controller.items.value
              .map((e) => DropdownMenuEntry(
                  leadingIcon: const Icon(Icons.person),
                  value: e.value,
                  //leadingIcon: ImageIcon(NetworkImage(e.image)),
                  label: e.label))
              .toList(),
        )));
  }
}
