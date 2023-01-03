import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:sweatbox2dot0/Controller/UserDataController.dart';
import 'package:sweatbox2dot0/Controller/ViewMainStateController.dart';
import 'package:sweatbox2dot0/Widget/BottomNavigationBar.dart';
import 'package:sweatbox2dot0/Widget/Community/PhysicalData.dart';
import 'package:sweatbox2dot0/view/Class.dart';
import 'package:sweatbox2dot0/view/Community.dart';
import 'package:sweatbox2dot0/view/Home.dart';
import 'package:sweatbox2dot0/view/Status.dart';

class MainView extends StatelessWidget {
  PageController pageController = new PageController();
  var viewMainStateController = Get.put(ViewMainStateController());
  var userData = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Scaffold(
            body: Obx(
          () => Stack(
            children: [
              Positioned(child: Obx(() => bodyView(viewMainStateController.pageIndex.value))),
              AnimatedPositioned(
                top: viewMainStateController.showBars.value ? 0 : -sx(100),
                child: Container(
                  alignment: Alignment.center,
                  width: width,
                  height: sx(70),
                  color: Colors.white,
                  child: Text(
                    "홈",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                duration: Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
              ),
              AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  bottom: viewMainStateController.showBars.value ? 0 : -sx(200),
                  child: Container(
                    width: width,
                    child: SwbBottomNavBar(),
                  ))
            ],
          ),
        ));
      },
    );
  }

  bodyView(currentTab) {
    List<Widget> tabView = [];
    //Current Tabs in Home Screen...
    switch (currentTab) {
      case 0:
        //Dashboard Page
        tabView = [HomePage()];
        break;
      case 1:
        //Search Page
        tabView = [ClassPage()];
        break;
      case 2:
        //Profile Page
        tabView = [CommunityPage()];
        break;
      case 3:
        //Setting Page
        tabView = [StatausPage()];
        break;
    }
    return PageView(controller: pageController, children: tabView);
  }
}
