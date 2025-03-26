import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../params_screen/param_controller.dart';

class MyColorPicker extends StatelessWidget {
  const MyColorPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ParamController());
    return  SizedBox(
        width: double.infinity,
        child: Card(
          child: ColorPicker(
              width: 20,
              height: 20,
              borderRadius: 22,
              heading: Text(
                'Select color',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              subheading: Text(
                'Select color shade',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              onColorChanged: (color) {
                controller.color.value = color;
              }),
        ));
  }
}
