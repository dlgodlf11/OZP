import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:sweatbox2dot0/Controller/PrController.dart';
import 'package:sweatbox2dot0/Controller/StatusStateController.dart';
import 'package:sweatbox2dot0/Controller/UserDataController.dart';
import 'package:sweatbox2dot0/Services/database.dart';
import 'package:sweatbox2dot0/Widget/StatusWidget/PersonalRecordDetail.dart';

class PRWidget extends StatelessWidget {
  var statusStateController = Get.put(StatusStateController());
  var prController = Get.put(PrController());
  UserController userData = Get.put(UserController());
  var typeList = ["Weight", "Time", "Reps", "Named"];
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: DefaultTabController(
              length: 4,
              child: Obx(() => SingleChildScrollView(
                    controller: statusStateController.statusScrollController,
                    child: Container(
                      padding: EdgeInsets.only(top: sx(150) * statusStateController.enablePadding.value),
                      child: Column(
                        children: [
                          TabBar(
                              indicatorWeight: 0.1,
                              indicatorColor: Colors.white,
                              unselectedLabelColor: Color(0xffb7b7b7),
                              labelColor: Color(0xff084bff),
                              labelStyle: TextStyle(fontSize: sx(20), fontWeight: FontWeight.w600),
                              onTap: (int index) {
                                prController.prTypeText.value = typeList[index];
                                prController.open.clear();
                              },
                              tabs: [
                                Tab(
                                  text: "WEIGHT",
                                ),
                                Tab(
                                  text: "TIME",
                                ),
                                Tab(
                                  text: "REPS",
                                ),
                                Tab(
                                  text: "NAMED",
                                )
                              ]),
                          personalRecordItems(type: prController.prTypeText.value, sx: sx)
                        ],
                      ),
                    ),
                  ))));
    });
  }

  personalRecordItems({type, required double Function(double) sx}) {
    print("씨발");
    Rx<List<QueryDocumentSnapshot<Map<String, dynamic>>>> pr = Rx<List<QueryDocumentSnapshot<Map<String, dynamic>>>>([]);
    switch (type) {
      case ("Weight"):
        pr = prController.prWeight;
        break;
      case ("Time"):
        pr = prController.prTime;
        break;
      case ("Reps"):
        pr = prController.prReps;
        break;
      case ("Named"):
        pr = prController.prNamed;
        break;
      default:
    }

    return Obx(() => Column(
          children: [for (int i = 0; i < pr.value.length; i++) prContent(pr: pr, i: i, sx: sx, userData: userData, type: type)],
        ));
  }

  prContent(
      {required Rx<List<QueryDocumentSnapshot<Map<String, dynamic>>>> pr,
      required int i,
      required double Function(double) sx,
      userData,
      required String type}) {
    if (prController.open.length <= i) {
      prController.open.add(false.obs);
    } else {}

    return Container(
        padding: EdgeInsets.all(sx(20)),
        height: prController.open[i].value ? null : sx(80),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${pr.value[i].id.split(". ")[1]}",
                    style: TextStyle(color: Colors.black, fontSize: sx(30), fontWeight: FontWeight.w700),
                  ),
                  Obx(() => InkWell(
                        onTap: () {
                          prController.open[i].value = !prController.open[i].value;
                        },
                        child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            width: sx(40),
                            height: sx(40),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: !prController.open[i].value ? Color(0xfff7f7f7) : Color(0xffd6e4ff),
                                borderRadius: BorderRadius.all(Radius.circular(900))),
                            child: RotatedBox(
                              quarterTurns: !prController.open[i].value ? 0 : 2,
                              child: SvgPicture.asset(
                                'assets/StatusIcon/drawer.svg',
                                color: !prController.open[i].value ? Color(0xffb9b9b9) : Color(0xff084bff),
                              ),
                            )),
                      ))
                ],
              ),
              Column(
                children: [
                  for (int j = 0; j < pr.value[i].data().keys.length; j++)
                    Container(
                      margin: EdgeInsets.only(bottom: sx(10)),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Color(0xffCdede6),
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                          onPressed: () {
                            Get.to(() => PersonalRecordDetail(
                                  type: type,
                                  prName: pr.value[i].data().keys.toList()[j],
                                ));
                          },
                          child: Container(
                            padding: EdgeInsets.all(sx(15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  pr.value[i].data().keys.toList()[j],
                                  style: TextStyle(color: Colors.black, fontSize: sx(25)),
                                ),
                                Row(
                                  children: [
                                    recordText(pr: pr, i: i, sx: sx, j: j, type: type),
                                    SizedBox(
                                      width: sx(20),
                                    ),
                                    Text(
                                      pr.value[i]
                                                  .data()[pr.value[i].data().keys.toList()[j]]
                                                  .indexWhere((element) => element.toString().contains(userData.user.value.email!)) ==
                                              -1
                                          ? NumberFormat("00", "en_US").format(0) + "위"
                                          : getRank(pr: pr, i: i, j: j, type: type),
                                      style: TextStyle(color: Color(0xff00c364), fontSize: sx(25)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                    )
                ],
              )
            ],
          ),
        ));
  }

  getRank({required pr, required i, required j, required type}) {
    var recordList = pr.value[i].data()[pr.value[i].data().keys.toList()[j]];
    if (type == "Weight") {
      recordList.sort((a, b) => double.parse(b.split("kg")[0]).compareTo(double.parse(a.split("kg")[0])));
    } else if (type == "Reps") {
      recordList.sort((a, b) => int.parse(b.split("/")[0]).compareTo(int.parse(a.split("/")[0])));
    } else {
      recordList.sort((a, b) => int.parse(a.split("/")[0]).compareTo(int.parse(b.split("/")[0])));
    }
    print(recordList);
    print("개새끼야");
    return NumberFormat("00", "en_US")
            .format(recordList.indexWhere((element) => element.toString().contains(userData.user.value.email!)) + 1) +
        "위";
  }

  changeText({required String text, required type}) {
    switch (type) {
      case ("Weight"):
        return "${Database().changeEasyLbKg(value: text.split("kg")[0].toString())} ${userData.user.value.showKg.value ? "kg" : "lb"}";

      case ("Time"):
        int totalTime = int.parse(text.split("/")[0]);
        String result = (totalTime / 60).floor().toString() + "' " + (totalTime % 60).floor().toString() + '"';
        return result;
      case ("Reps"):
        String result = text.split("/")[0] + "회";
        return result;
      case ("Named"):
        int totalTime = int.parse(text.split("/")[0]);
        String result = (totalTime / 60).floor().toString() + "' " + (totalTime % 60).floor().toString() + '"';
        return result;
      default:
    }
  }

  recordText(
      {required Rx<List<QueryDocumentSnapshot<Map<String, dynamic>>>> pr,
      required int i,
      required double Function(double) sx,
      required j,
      required String type}) {
    String defaultText = type == "Weight"
        ? "000.0${userData.user.value.showKg.value ? "kg" : "lb"}"
        : type == "Time" || type == "Named"
            ? '0' + "' " + "0" + '"'
            : "00회";
    return Text(
        pr.value[i]
                    .data()[pr.value[i].data().keys.toList()[j]]
                    .indexWhere((element) => element.toString().contains(userData.user.value.email!)) ==
                -1
            ? defaultText
            : changeText(
                text: pr.value[i]
                    .data()[pr.value[i].data().keys.toList()[j]]
                    .where((element) => element.toString().contains(userData.user.value.email!))
                    .first
                    .toString(),
                type: type),
        style: TextStyle(color: Color(0xff00c364), fontSize: sx(25)));
  }
}
