import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

class ViewMainStateController extends GetxController {
  RxBool showBars = true.obs;
  RxInt pageIndex = 0.obs;
  RxList randomwod = [].obs;
  ScreenshotController screenshotController = new ScreenshotController();
  TextEditingController weightText = new TextEditingController();
  TextEditingController repsText = new TextEditingController();
  RxDouble weight = 0.0.obs;
  RxInt reps = 1.obs;
  var randomWodFilter = [];
  changeCurrentPage(index) {
    pageIndex.value = index;
  }
}
