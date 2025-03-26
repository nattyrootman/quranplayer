import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/service/query_items.dart';

import '../../audio_controller/singleerplayer.dart';

class SingleAudioWidget extends StatelessWidget {
  const SingleAudioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SinglePlayerController>();
    final quercontroller = Get.find<QueryItemsController>();

    return Obx(
      () => Column(
       
        children: [
          //SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    controller.prevBtn();
                  },
                  icon: const Icon(Icons.skip_previous, size: 15)),
              const SizedBox(
                width: 20,
              ),
              controller.isLoading.value == true
                  ? Center(
                      child: SizedBox(
                        width: 15,
                        height: 15,
                        child: CircularProgressIndicator(strokeWidth: 2.0)),
                    )
                  : IconButton(
                      onPressed: () {
                        controller.togglePlay();
                        //controller.isPlaying.value = !controller.isPlaying.value;
                      },
                      icon: Icon(
                          controller.isPlaying.value
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 15)),
              const SizedBox(width: 20),
              IconButton(
                  onPressed: () {
                    controller.nextBtn();
                  },
                  icon: const Icon(
                    Icons.skip_next,
                    size: 15,
                  ))
            ]
        ),
          SizedBox(height: 2),

         SizedBox(
          width:!kIsWeb? MediaQuery.of(context).size.width/1.4:null,
          height:10,
          
           child: SliderTheme(
               data: SliderTheme.of(context).copyWith(
               trackHeight: 2, // Adjust track height
               thumbShape: RoundSliderThumbShape(enabledThumbRadius: 4), // Adjust thumb size
             ),
               child: Slider(
                
                //thumbColor: Colors.blue,
                    max: controller.duration.value.inSeconds.toDouble(),
                    value: controller.position.value.inSeconds.toDouble(),
                    onChanged: (value) {
                     
                      controller.player.value
                          .seek(Duration(seconds: value.toInt()));
                    }),
             ),
         ),
          
          SizedBox(height: 4)
          // Suggested code may be subject to a license. Learn more: ~LicenseLog:2967247671.
          /*   Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(controller.getformatDuration(controller.position.value)),
                    Text(controller.getformatDuration(controller.duration.value)),
                  ],
                ),
              )*/
        ],
      ),
    );
  }
}





/*Slider(
                max: controller.duration.value.inSeconds.toDouble(),
                value: controller.position.value.inSeconds.toDouble(),
                onChanged: (value) {
                  controller.player.value.seek(Duration(seconds: value.toInt()));
                }),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(controller.getformatDuration(controller.position.value)),
                  Text(controller.getformatDuration(controller.duration.value)),
                ],
              ),
            )*/