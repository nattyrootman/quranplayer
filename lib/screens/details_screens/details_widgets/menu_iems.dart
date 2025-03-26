import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../params_screen/param_controller.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ParamController());

    return Container(
    
        child: PopupMenuButton(
      icon: const Icon(
        Icons.more_vert,
        size: 40,
      ),
      initialValue: controller.menuIemText.value,
      onSelected: (value) {
        //controller.menuIemText.value = value;
      },
      itemBuilder: (context) {
        return [
          

          PopupMenuItem(
              onTap: () {
               // controller.menuIemText.value = "Amiri";
              },
              value: "Amiri",
              child: ListTile(
              title: const Text('Choisir type de script'),
              subtitle: Column(children: [
                for (var i = 0; i < controller.options1.length; i++)
                  Obx(() => RadioMenuButton<String>(
                        value: controller.options1[i],
                        groupValue: controller.menuIemText.value,
                        onChanged: (String? value) {
                          controller.menuIemText.value = value!;
                        },
                        child: Text(controller.options1[i]),
                      )),
              ])
              )
              
              
              
              ),

          
          
             
            


        ];
      },
    ));
  }
}












/*

PopupMenuItem(
           onTap: () {
            controller.menuIemText.value = "Amiri";
          }, 
          value: "Amiri",
          child: Text("AmiriQuran")),
          PopupMenuItem(
              onTap: () {
                controller.menuIemText.value = "Naskh";
              },
              value: "Naskh",
              child: Text("Naskh")),

               PopupMenuItem(
              onTap: () {
                controller.menuIemText.value = "Uthmani";
              },
              value: "Uthmani",
              child: Text("Uthmani 1")),

              PopupMenuItem(
              onTap: () {
                controller.menuIemText.value = "Hafs";
              },
              value: "Hafs",
              child: Text("HafsNastaleeq")),



*/