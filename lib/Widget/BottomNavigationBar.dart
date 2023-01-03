import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:sweatbox2dot0/Controller/UserDataController.dart';
import 'package:sweatbox2dot0/Controller/ViewMainStateController.dart';
import 'package:sweatbox2dot0/Widget/Community/PhysicalData.dart';

class SwbBottomNavBar extends StatelessWidget {
  RxDouble backposition = 17.0.obs;
  var userData = Get.put(UserController());

  var viewMainStateController = Get.put(ViewMainStateController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (value) {
        print(value.delta.direction);
        if (value.delta.direction > 0) {
          viewMainStateController.showBars.value = false;
        } else {
          viewMainStateController.showBars.value = true;
        }
      },
      child: RelativeBuilder(builder: (context, height, width, sy, sx) {
        return Container(
            // padding: EdgeInsets.symmetric(horizontal: 30),
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            height: sx(120),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(300)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 9,
                  blurRadius: 9,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Obx(
              () => Stack(
                alignment: Alignment.center,
                children: [
                  // AnimatedPositioned(
                  //     left: sx(backposition.value),
                  //     curve: Curves.fastOutSlowIn,
                  //     child: CircleAvatar(
                  //       backgroundColor: Color(0xff326aff),
                  //       radius: sx(40),
                  //     ),
                  //     duration: Duration(milliseconds: 200)),
                  Positioned(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(340)),
                            color: viewMainStateController.pageIndex.value == 0 ? Color(0xff326aff) : Colors.white),
                        width: sx(80),
                        height: sx(80),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(340)),
                            color: viewMainStateController.pageIndex.value == 1 ? Color(0xff326aff) : Colors.white),
                        width: sx(80),
                        height: sx(80),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(340)),
                            color: viewMainStateController.pageIndex.value == 2 ? Color(0xff326aff) : Colors.white),
                        width: sx(80),
                        height: sx(80),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(340)),
                            color: viewMainStateController.pageIndex.value == 3 ? Color(0xff326aff) : Colors.white),
                        width: sx(80),
                        height: sx(80),
                      )
                    ],
                  )),
                  Positioned(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          splashColor: Color(0xff326aff),
                          color: Color(0xff326aff),
                          icon: SvgPicture.asset(
                            'assets/bottomNavBarIcon/home_1.svg',
                            color: viewMainStateController.pageIndex.value == 0 ? Colors.white : Color(0xff494949),
                          ),
                          onPressed: () {
                            viewMainStateController.changeCurrentPage(0);
                          }),
                      IconButton(
                          splashColor: Color(0xff326aff),
                          color: Color(0xff326aff),
                          icon: SvgPicture.asset(
                            'assets/bottomNavBarIcon/class.svg',
                            color: viewMainStateController.pageIndex.value == 1 ? Colors.white : Color(0xff494949),
                          ),
                          onPressed: () {
                            viewMainStateController.changeCurrentPage(1);
                          }),
                      IconButton(
                          icon: SvgPicture.asset(
                            'assets/bottomNavBarIcon/comunt.svg',
                            color: viewMainStateController.pageIndex.value == 2 ? Colors.white : Color(0xff494949),
                          ),
                          onPressed: () {
                            backposition.value = 245;

                            viewMainStateController.changeCurrentPage(2);
                          }),
                      IconButton(
                          icon: SvgPicture.asset(
                            'assets/bottomNavBarIcon/status.svg',
                            color: viewMainStateController.pageIndex.value == 3 ? Colors.white : Color(0xff494949),
                          ),
                          onPressed: () {
                            if (userData.user.value.nickName == null ||
                                userData.user.value.tall == null ||
                                userData.user.value.weight == null ||
                                userData.user.value.gender == null ||
                                userData.user.value.box == null) {
                              Get.to(PhysicalData())!.then((value) {
                                viewMainStateController.changeCurrentPage(3);
                              });
                            } else {
                              viewMainStateController.changeCurrentPage(3);
                            }
                          })
                    ],
                  ))
                ],
              ),
            ));
      }),
    );
  }
}
