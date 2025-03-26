import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../audio_controller/audio_initalizer_controller.dart';
import '../../audio_controller/singleerplayer.dart';
import '../params_screen/param_controller.dart';

class MyFullDialog extends StatelessWidget {
  const MyFullDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ParamController());
        final audicontroller = Get.put(AudioSetUpController());
        final singlePlayerController = Get.put(SinglePlayerController());
      


    return Obx(
      () => Dialog.fullscreen(
        insetAnimationCurve: Curves.decelerate,
        insetAnimationDuration: Durations.short1,
        
          child: SingleChildScrollView(
              child: Column(children: [
        AppBar(elevation: 0, title: const Text("Paramètres"), actions: [
          IconButton(
              alignment: Alignment.topRight,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close)),
        ]),
        const SizedBox(height: 10),
        const Divider(),
        ListTile(
          title: const Text("Taille de Police"),
          subtitle: Obx(() => Slider.adaptive(
              value: controller.size.value,
              min: 1,
              max: 30,
              onChanged: (value) {
                controller.change(value);
              })),
        ),
        const Divider(),
        ListTile(
            title: const Text('Choisir type de script'),
            subtitle: Column(children: [
              for (var i = 0; i < controller.options1.length; i++)
                Obx(() => RadioMenuButton<String>(
                      value: controller.options1[i],
                      groupValue: controller.menuIemText.value,
                      onChanged: (String? value) {
                        controller.saveRadioData(value);
                      },
                      child: Text(
                        controller.options1[i],
                        style: const TextStyle(fontSize: 10),
                      ),
                    )),
            ])),
        const Divider(),
        ListTile(
            title: const Text('Choisir la Vitesse de lecture'),
            subtitle: Row(children: [
              for (var i = 0; i < controller.speed.length; i++)
                Obx(() => RadioMenuButton<double>(
                      value: controller.speed[i],
                      groupValue: controller.defaultspeed.value,
                      onChanged: (dynamic value) {
                        controller.defaultspeed.value = value;
                        audicontroller.player.value.setSpeed(controller.defaultspeed.value);
                        singlePlayerController.player.value.setSpeed(controller.defaultspeed.value);
                      },
                      child: Text(
                        '${controller.speed[i]}',
                        style: const TextStyle(fontSize: 10),
                      ),
                    )),
            ]))
            ,const Divider(),
             const SizedBox(),

    
      

        const SizedBox(
          height: 30,
        )
      ]))),
    );
  }
}
