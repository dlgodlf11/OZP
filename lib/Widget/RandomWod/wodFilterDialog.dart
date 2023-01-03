import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:sweatbox2dot0/Controller/UserDataController.dart';
import 'package:sweatbox2dot0/Services/database.dart';

class WodFilterDialog extends StatelessWidget {
  UserController userData = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Container(
        width: width,
        height: height,
        child: Material(
          color: Colors.black.withOpacity(0.2),
          child: Center(
            child: Container(
              padding: EdgeInsets.only(left: sx(40), top: sx(20), right: sx(40)),
              width: sx(400),
              height: sx(600),
              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.all(Radius.circular(sx(40)))),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("와드 필터링",
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      TextButton(
                          onPressed: () {},
                          child: Text("전체선택",
                              style: TextStyle(
                                color: Colors.white,
                              )))
                    ],
                  ),
                  Expanded(
                      child: Obx(() => ListView.builder(
                          itemCount: userData.user.value.wodFilters.length,
                          itemBuilder: (context, index) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(padding: EdgeInsets.all(0), primary: Colors.black),
                              onPressed: () {
                                if (userData.user.value.wodfilter!
                                        .indexWhere((element) => element == userData.user.value.wodFilters[index]) ==
                                    -1) {
                                  Database().addWodFilter(filterText: userData.user.value.wodFilters[index]);
                                } else {
                                  Database().removeWodFilter(filterText: userData.user.value.wodFilters[index]);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: sx(10)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    AnimatedContainer(
                                      width: sx(40),
                                      height: sx(40),
                                      duration: Duration(milliseconds: 400),
                                      decoration: BoxDecoration(
                                          color: userData.user.value.wodfilter!
                                                      .indexWhere((element) => element == userData.user.value.wodFilters[index]) ==
                                                  -1
                                              ? Colors.black
                                              : Colors.blue,
                                          borderRadius: BorderRadius.all(Radius.circular(900)),
                                          border: Border.all(width: sx(3), color: Colors.white)),
                                    ),
                                    SizedBox(
                                      width: sx(20),
                                    ),
                                    Text(userData.user.value.wodFilters[index],
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                              ),
                            );
                          }))),
                  SizedBox(
                    height: sx(30),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: sx(70),
                      child: Text(
                        "닫기",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
