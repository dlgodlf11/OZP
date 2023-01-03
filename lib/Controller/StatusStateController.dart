import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sweatbox2dot0/Controller/ViewMainStateController.dart';

class StatusStateController extends GetxController {
  PageController pageController = new PageController();
  RxBool shortInfoOn = false.obs;
  RxBool showmargin = false.obs;
  ScrollController statusScrollController = new ScrollController();
  RxInt pageIndex = 0.obs;
  RxDouble enablePadding = 0.0.obs;
  ViewMainStateController viewMainStateController = Get.put(ViewMainStateController());
  @override
  void onInit() {
    statusScrollController.addListener(() {
      if (statusScrollController.position.userScrollDirection != ScrollDirection.forward) {
        viewMainStateController.showBars.value = false;
      } else {
        viewMainStateController.showBars.value = true;
      }
    });
    super.onInit();
  }
}
