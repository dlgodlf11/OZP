import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sweatbox2dot0/Controller/TimerController.dart';
import 'package:sweatbox2dot0/Widget/UnitedTimer/FortimeTimer.dart';
import 'package:sweatbox2dot0/Widget/UnitedTimer/FortimeTimerRotated.dart';

class InTimer extends StatelessWidget {
  String? timerType;
  PageController pageController = new PageController();

  var timerController = Get.put(TimerController());
  InTimer({totalsec, this.timerType, isUp, rounds, rest}) {
    if (timerType == "amrap" || timerType == "fortime") {
      timerController.initAFTimer(totaltime: totalsec, isup: isUp, timetype: timerType);
    } else {
      timerController.initTETimer(totaltime: totalsec, timetype: timerType, resttime: rest, round: rounds);
    }
  }
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation.index == 1) {
        return FortimeTimerRotated(
          timerType: timerType,
          timerController: timerController,
        );
      } else {
        return FortimeTimer(
          timerController: timerController,
          timerType: timerType,
        );
      }
    });
    //return Scaffold(body: Obx(() => bodyView(timerController.rotate.value)));
  }

  bodyView(currentTab) {
    print(currentTab);

    List<Widget> tabView = [];
    //Current Tabs in Home Screen...
    switch (currentTab) {
      case 2:
        //Dashboard Page
        tabView = [
          FortimeTimerRotated(
            timerType: timerType,
            timerController: timerController,
          )
        ];
        break;
      case 4:
        //Search Page
        tabView = [
          FortimeTimerRotated(
            timerType: timerType,
            timerController: timerController,
          )
        ];
        break;
      case 1:
        //Dashboard Page
        tabView = [
          FortimeTimer(
            timerController: timerController,
            timerType: timerType,
          )
        ];
        break;
    }
    return PageView(controller: pageController, children: tabView);
  }
}
