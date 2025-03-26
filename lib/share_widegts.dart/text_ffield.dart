// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/themes/theme_controller.dart';

import '../service/query_items.dart';
import '../service/quran_translation_repo.dart';

class MyTextField extends StatelessWidget {
  final double witdh, height;
  final double radius;
  final Widget? iconData;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  void Function(String)? onChanged;
  MyTextField(
      {super.key,
      required this.controller,
      this.witdh = 130,
      this.height = 30,
      this.radius = 5,
      this.iconData,
      this.keyboardType,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final textController = Get.put(QuranTranslationController());
    final querycontroller = Get.put(QueryItemsController());
    return SizedBox(
        height: height,
        width: witdh,
        child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            onChanged: onChanged,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 2, bottom: 2, left: 8),
              hintText: "trouver le Verset",
              hintStyle: TextStyle(fontSize: 10),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius)),
              prefixIcon: iconData!,
            )));
  }
}

class MySearchField extends StatelessWidget {
  const MySearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final querycontroller = Get.find<QueryItemsController>();
    final themeController = Get.find<ThemeController>();

    final query = MediaQuery.of(context).size.width / 1.9;
    return Obx(() => SearchBar(
          autoFocus: querycontroller.isLoading.value,
          constraints: BoxConstraints.tight(Size(query, 40)),
          controller: querycontroller.textController.value,
          leading: const Icon(Icons.search),
          hintText: "Recherher",
          onChanged: (value) {
            querycontroller.searchQuery.value = value;
            querycontroller.isLoading.value = !querycontroller.isLoading.value;
          },
          trailing: [
            querycontroller.textController.value.text.trim().isNotEmpty
                ?
                //querycontroller.isLoading.value?
                IconButton(
                    onPressed: () {
                      querycontroller.textController.value.clear();
                      //querycontroller.searchQuery.value = "";
                    },
                    icon: const Icon(Icons.close, size: 20))
                : IconButton(
                    onPressed: () {
                      themeController.toggleMode();
                      //themeController.isDark.value = !themeController.isDark.value;
                    },
                    icon: Icon(themeController.isDark.value
                        ? Icons.dark_mode
                        : Icons.light_mode))
          ],
        ));
  }
}
