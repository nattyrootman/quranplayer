import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/myfull_dialog.dart';
import 'param_controller.dart';

class ParamScreen extends StatelessWidget {
  const ParamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ParamController>();
    return  const Scaffold(
        body: MyFullDialog()
          
          
      
    );
  }
}
