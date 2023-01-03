import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:sweatbox2dot0/Controller/TimerController.dart';
import 'package:sweatbox2dot0/Widget/SweatRecord/cameraHorizontal.dart';

import 'cameraVertical.dart';

class SweatRecordCamera extends StatelessWidget {
  String name = "";
  String wodTitle = "";

  var timerController = Get.put(TimerController());
  RxBool viewHorizontal = false.obs;
  SweatRecordCamera(
      {required timeCap, required isUp, required doingCount, required viewhorizontal, required this.name, required this.wodTitle}) {
    viewHorizontal.value = viewhorizontal.value;
    timerController.initAFTimer(totaltime: timeCap, isup: isUp.value, timetype: "fortime");
    if (viewHorizontal.value) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        // DeviceOrientation.portraitDown,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        // DeviceOrientation.portraitDown,
      ]);
    }
  }
  @override
  Widget build(BuildContext context) {
    if (viewHorizontal.value) {
      return CamHorizontal();
    } else {
      return CamVertical(wodTitle: wodTitle, name: name, timerController: timerController);
    }
  }
}
