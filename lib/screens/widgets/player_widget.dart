import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../audio_controller/audio_initalizer_controller.dart';

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AudioSetUpController>();
          
    return Obx(() =>  Column(
          children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          controller.prevBtn();
                        },
                        icon: const Icon(Icons.skip_previous, size: 15)),
                    const SizedBox(width: 20,),
                   
                 controller.isLoading.value==true ?Center(
                  child:SizedBox(
                    width:15,
                    height: 15,
                  child:CircularProgressIndicator(strokeWidth: 2.0,)),)  :  IconButton(
                        onPressed: () {
                          //controller.isPlaying.value = !controller.isPlaying.value;
                          controller.togglePlay();
                        
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
                  ]),
 
        SizedBox(height: 2),
          SizedBox(
            width: MediaQuery.of(context).size.width/1.4,
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
        ]),
    
    
      
        
      );
  }
}
