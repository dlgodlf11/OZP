import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:sweatbox2dot0/Controller/UserDataController.dart';
import 'package:sweatbox2dot0/Controller/ViewMainStateController.dart';
import 'package:sweatbox2dot0/Services/database.dart';

class RmPad extends StatelessWidget {
  UserController userData;
  RxInt errorhold = 0.obs;
  ScrollController rmScrollController = new ScrollController();
  var rmvar = [
    1,
    0.943,
    0.915,
    0.899,
    0.866,
    0.844,
    0.823,
    0.802,
    0.783,
    0.764,
    0.745,
    0.728,
    0.711,
    0.694,
    0.678,
    0.663,
    0.647,
    0.633,
    0.617,
    0.604
  ];
  RmPad({required this.userData}) {
    print(userData.user.value.rm);
    if (userData.user.value.rm.length != 0) {
      // _.reps.value = userData.user.value.rm.last["reps"];
      // _.weight.value = userData.user.value.rm.last["weight"];
      // _.repsText.text = userData.user.value.rm.last["reps"].toString();
      // _.weightText.text = userData.user.value.rm.last["weight"].toStringAsFixed(0);
    }
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewMainStateController>(
        init: ViewMainStateController(),
        builder: (_) {
          return RelativeBuilder(builder: (context, height, width, sy, sx) {
            if (errorhold.value == 0) {}
            return Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(
                    "RM Pad",
                    style: TextStyle(fontSize: sx(30)),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Color(0xffe2eaff), elevation: 0),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        SystemChrome.setEnabledSystemUIOverlays([]);
                        _.weight.value = double.parse(_.weightText.text);
                        _.reps.value = int.parse(_.repsText.text);
                        Database().updateRm(weight: _.weight.value, reps: _.reps.value);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: sx(80),
                        height: sx(40),
                        child: Text(
                          "계산하기",
                          style: TextStyle(color: Color(0xff084bff), fontWeight: FontWeight.bold),
                        ),
                      ))
                ]),
                SizedBox(
                  height: sx(20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "무게",
                          style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xff707070), fontSize: sx(25)),
                        ),
                        SizedBox(
                          width: sx(20),
                        ),
                        Container(
                          width: sx(80),
                          height: sx(60),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _.weightText,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: sx(20)),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  bottom: sx(60) / 2, // HERE THE IMPORTANT PART
                                ),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Color(0xffb4b4b4))),
                                isDense: true,
                                filled: true,
                                fillColor: Colors.white,
                                focusColor: Color(0xffe2eaff),
                                focusedBorder: InputBorder.none,
                                errorStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Colors.red)),
                                hintStyle: TextStyle(
                                    color: Color(0xffb4b4b4),
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "AppleSDGothicNeo",
                                    fontStyle: FontStyle.normal,
                                    fontSize: sx(20)),
                                labelStyle: TextStyle(
                                    color: Color(0xffb4b4b4),
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "AppleSDGothicNeo",
                                    fontStyle: FontStyle.normal,
                                    fontSize: sx(20))),
                          ),
                        ),
                        SizedBox(
                          width: sx(20),
                        ),
                        Text(
                          userData.user.value.showKg.value ? "kg" : 'lb',
                          style: TextStyle(fontWeight: FontWeight.w400, color: Color(0xff707070), fontSize: sx(25)),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "횟수",
                          style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xff707070), fontSize: sx(25)),
                        ),
                        SizedBox(
                          width: sx(20),
                        ),
                        Container(
                          width: sx(80),
                          height: sx(60),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _.repsText,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: sx(20)),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  bottom: sx(60) / 2, // HERE THE IMPORTANT PART
                                ),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Color(0xffb4b4b4))),
                                isDense: true,
                                filled: true,
                                fillColor: Colors.white,
                                focusColor: Color(0xffe2eaff),
                                focusedBorder: InputBorder.none,
                                errorStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Colors.red)),
                                hintStyle: TextStyle(
                                    color: Color(0xffb4b4b4),
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "AppleSDGothicNeo",
                                    fontStyle: FontStyle.normal,
                                    fontSize: sx(20)),
                                labelStyle: TextStyle(
                                    color: Color(0xffb4b4b4),
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "AppleSDGothicNeo",
                                    fontStyle: FontStyle.normal,
                                    fontSize: sx(20))),
                          ),
                        ),
                        SizedBox(
                          width: sx(20),
                        ),
                        Text(
                          'Reps',
                          style: TextStyle(fontWeight: FontWeight.w400, color: Color(0xff707070), fontSize: sx(25)),
                        ),
                      ],
                    )
                  ],
                ),
                Expanded(
                    child: DefaultTabController(
                  length: 2,
                  child: Container(
                    child: Column(
                      children: [
                        TabBar(
                            indicatorColor: Color(0xff084bff),
                            indicatorWeight: 3,
                            labelColor: Color(0xff084bff),
                            unselectedLabelColor: Color(0xffe4e4e4),
                            labelStyle: TextStyle(
                              fontSize: sx(25),
                            ),
                            onTap: (index) {
                              rmScrollController.animateTo(index * width,
                                  duration: Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
                            },
                            tabs: [
                              Tab(
                                text: "#RM",
                              ),
                              Tab(
                                text: "% of RM",
                              )
                            ]),
                        Expanded(
                            child: ListView(
                          controller: rmScrollController,
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                                width: width - (sx(30) * 2),
                                padding: EdgeInsets.all(sx(10)),
                                height: double.infinity,
                                color: Colors.white,
                                child: GridView.builder(
                                    itemCount: 20,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      childAspectRatio: 240 / 180,
                                    ),
                                    itemBuilder: (context, index) {
                                      print(_.reps.value);
                                      return Container(
                                        padding: EdgeInsets.all(sx(10)),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${index + 1}RM",
                                              style: TextStyle(color: Color(0xff0046ff), fontSize: sx(20)),
                                            ),
                                            FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                _.reps.value > 20
                                                    ? "${((_.weight.value + (_.weight.value * 0.025 * _.reps.value)) * rmvar[index]).toStringAsFixed(1)}${userData.user.value.showKg.value ? "kg" : "lb"}"
                                                    : "${((_.weight.value / rmvar[_.reps.value - 1]) * rmvar[index]).toStringAsFixed(1)}${userData.user.value.showKg.value ? "kg" : "lb"}",
                                                style: TextStyle(color: Colors.black, fontSize: sx(20)),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    })),
                            Container(
                                width: width - (sx(30) * 2),
                                padding: EdgeInsets.all(sx(10)),
                                height: double.infinity,
                                color: Colors.white,
                                child: GridView.builder(
                                    itemCount: 20,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      childAspectRatio: 240 / 180,
                                    ),
                                    itemBuilder: (context, index) {
                                      print(_.reps.value);
                                      return Container(
                                        padding: EdgeInsets.all(sx(10)),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${((1 - (0.05 * (index))) * 100).toStringAsFixed(0)}%",
                                              style: TextStyle(color: Color(0xff0046ff), fontSize: sx(20)),
                                            ),
                                            FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                _.reps.value > 20
                                                    ? "${((((_.weight.value + (_.weight.value * 0.025 * _.reps.value)) * rmvar[0])) * (1 - (0.05 * (index)))).toStringAsFixed(1)} ${userData.user.value.showKg.value ? "kg" : "lb"}"
                                                    : "${((((_.weight.value / rmvar[_.reps.value - 1])) * (0.05 * (index + 1)))).toStringAsFixed(1)}${userData.user.value.showKg.value ? "kg" : "lb"}",
                                                style: TextStyle(color: Colors.black, fontSize: sx(20)),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    })),
                          ],
                        ))
                      ],
                    ),
                  ),
                ))
              ],
            );
          });
        });
  }
}
