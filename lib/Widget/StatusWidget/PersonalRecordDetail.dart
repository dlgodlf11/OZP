import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:sweatbox2dot0/Controller/PrController.dart';
import 'package:sweatbox2dot0/Controller/UserDataController.dart';
import 'package:sweatbox2dot0/Services/database.dart';
import 'package:sweatbox2dot0/Widget/StatusWidget/showAllPersonalRecord.dart';

class PersonalRecordDetail extends StatelessWidget {
  String type = "Weight";
  String prName = "";
  UserController userData = Get.put(UserController());

  var prController = Get.put(PrController());

  Rx<List<QueryDocumentSnapshot<Map<String, dynamic>>>> pr = Rx<List<QueryDocumentSnapshot<Map<String, dynamic>>>>([]);
  TextEditingController firstTextController = new TextEditingController();
  TextEditingController secondTextController = new TextEditingController();
  PersonalRecordDetail({required this.type, required this.prName}) {
    print("??");
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
    print(pr);
  }

  changeText({required String text}) {
    switch (type) {
      case ("Weight"):
        return "${Database().changeEasyLbKg(value: text.split("kg")[0].toString())} ${userData.user.value.showKg.value ? "kg" : "lb"}";

      case ("Time"):
        int totalTime = int.parse(text.split("/")[0]);
        String result = (totalTime / 60).floor().toString() + "'" + (totalTime % 60).floor().toString() + '"';
        return result;
      case ("Reps"):
        String result = text.split("/")[0] + "회";
        return result;
      case ("Named"):
        int totalTime = int.parse(text.split("/")[0]);
        String result = (totalTime / 60).floor().toString() + "'" + (totalTime % 60).floor().toString() + '"';
        return result;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTapDown: (value) {
      FocusScope.of(context).requestFocus(FocusNode());
      SystemChrome.setEnabledSystemUIOverlays([]);
    }, child: RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(type.toUpperCase()),
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: SvgPicture.asset('assets/appbarIcon/btn_back.svg'),
            ),
          ),
          body: SingleChildScrollView(
            child: Obx(() => Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width,
                        height: width,
                        color: Colors.blue,
                        child: Image.asset(
                          'assets/pr/ezgif-2-e38424f37d66.gif',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(sx(25)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: sx(100),
                                  height: sx(100),
                                  decoration: BoxDecoration(
                                      color: userData.user.value.profileImage == "" ? Colors.blue : Colors.black,
                                      // image:DecorationImage(image: ),
                                      image: userData.user.value.profileImage == ""
                                          ? null
                                          : userData.user.value.profileImage!.contains("/data/user")
                                              ? DecorationImage(image: FileImage(File(userData.user.value.profileImage!)))
                                              : DecorationImage(image: FirebaseImage(userData.user.value.profileImage!)),
                                      borderRadius: BorderRadius.all(Radius.circular(900))),
                                ),
                                SizedBox(width: sx(20)),
                                Container(
                                  height: sx(100),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        prName,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: sx(30),
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Text(
                                        recordAndRankText()["record"],
                                        style: TextStyle(
                                          color: Color(0xff00c364),
                                          fontSize: sx(20),
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                      Text(
                                        "현재 랭킹은 ${recordAndRankText()["rank"]}위",
                                        style: TextStyle(
                                          color: Color(0xff707070),
                                          fontSize: sx(20),
                                          fontWeight: FontWeight.w200,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              getDate(),
                              style: TextStyle(
                                color: Color(0xff707070),
                                fontSize: sx(17),
                                fontWeight: FontWeight.w100,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: sx(25)),
                        child: type == "Weight"
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "나의 최대 무게는",
                                    style: TextStyle(
                                      color: Color(0xff707070),
                                      fontSize: sx(25),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      textField(controller: firstTextController, sx: sx),
                                      SizedBox(
                                        width: sx(15),
                                      ),
                                      Text(
                                        "${userData.user.value.showKg.value ? "kg" : "lb"}",
                                        style: TextStyle(
                                          color: Color(0xff707070),
                                          fontSize: sx(25),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            : type == "Time" || type == "Named"
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "몇분 몇초?",
                                        style: TextStyle(
                                          color: Color(0xff707070),
                                          fontSize: sx(25),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          textField(controller: firstTextController, sx: sx),
                                          Text(
                                            "분",
                                            style: TextStyle(
                                              color: Color(0xff707070),
                                              fontSize: sx(25),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(
                                            width: sx(15),
                                          ),
                                          textField(controller: secondTextController, sx: sx),
                                          Text(
                                            "초",
                                            style: TextStyle(
                                              color: Color(0xff707070),
                                              fontSize: sx(25),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                : Row(
                                    children: [
                                      Text(
                                        "나의 최대 랩스",
                                        style: TextStyle(
                                          color: Color(0xff707070),
                                          fontSize: sx(25),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          textField(controller: firstTextController, sx: sx),
                                          Text(
                                            "Reps",
                                            style: TextStyle(
                                              color: Color(0xff707070),
                                              fontSize: sx(25),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                      ),
                      Container(
                        padding: EdgeInsets.all(sx(25)),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: Color(0xff0046ff)),
                            onPressed: () {
                              if (type == "Weight" || type == "Reps") {
                                if (firstTextController.text != "")
                                  Database().setPR(type: type, prName: prName, record: firstTextController.text, pr: pr);
                              } else {
                                if (firstTextController.text != "" || secondTextController.text != "") {
                                  if (firstTextController.text == "") firstTextController.text = "0";
                                  if (secondTextController.text == "") secondTextController.text = "0";
                                  var record = (int.parse(firstTextController.text) * 60) + int.parse(secondTextController.text);
                                  Database().setPR(type: type, prName: prName, record: record.toString(), pr: pr);
                                }
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(sx(20)),
                              width: width,
                              alignment: Alignment.center,
                              child: Text(
                                "등록하기",
                                style: TextStyle(color: Colors.white, fontSize: sx(25), fontWeight: FontWeight.w700),
                              ),
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.all(sx(20)),
                        child: Text(
                          "스웨트 랭커",
                          style: TextStyle(
                            color: Color(0xff54594c),
                            fontSize: sx(27),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Divider(),
                      showRanker(rank: 0, sx: sx, width: width),
                      showRanker(rank: 1, sx: sx, width: width),
                      showRanker(rank: 2, sx: sx, width: width),
                      Container(
                        padding: EdgeInsets.all(sx(25)),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: Color(0xff0046ff)),
                            onPressed: () {
                              Get.to(() => ShowAllRecord(
                                    pr: pr,
                                    prName: prName,
                                    type: type,
                                  ));
                            },
                            child: Container(
                              padding: EdgeInsets.all(sx(20)),
                              width: width,
                              alignment: Alignment.center,
                              child: Text(
                                "등록하기",
                                style: TextStyle(color: Colors.white, fontSize: sx(25), fontWeight: FontWeight.w700),
                              ),
                            )),
                      ),
                    ],
                  ),
                )),
          ));
    }));
  }

  showRanker({required int rank, required double Function(double) sx, required double width}) {
    var leaderBoard = pr.value.where((element) => element.data().containsKey(prName));

    if (leaderBoard.length == 0) {
      return Container(
        child: Text("기록한 사용자가 없어용"),
      );
    } else {
      print(leaderBoard.first.data()[prName]);
      print("Tlqkf");
      if (leaderBoard.first.data()[prName].length >= rank + 1) {
        var sortedList = leaderBoard.first.data()[prName];
        if (type == "Weight") {
          sortedList.sort((a, b) => double.parse(b.split("kg")[0]).compareTo(double.parse(a.split("kg")[0])));
        } else if (type == "Reps") {
          sortedList.sort((a, b) => int.parse(b.split("/")[0]).compareTo(int.parse(a.split("/")[0])));
        } else {
          sortedList.sort((a, b) => int.parse(a.split("/")[0]).compareTo(int.parse(b.split("/")[0])));
        }
        print("print in show Ranker");
        print(sortedList);
        return Container(
          padding: EdgeInsets.all(sx(25)),
          width: width,
          child: Row(
            children: [
              Text(
                (rank + 1).toString(),
                style: TextStyle(color: Color(0xff0046ff), fontSize: sx(30), fontWeight: FontWeight.w800),
              ),
              SizedBox(
                width: sx(20),
              ),
              CircleAvatar(
                radius: sx(40),
                backgroundColor: rank == 0
                    ? Color(0xffffc608)
                    : rank == 1
                        ? Color(0xffcbcbcb)
                        : Color(0xffdec07c),
              ),
              Column(
                children: [
                  Text(
                    changeText(text: sortedList[rank]),
                  ),
                  Text(Database().changeTime(sortedList[rank].split("/")[2]) + " 랭커 탈환")
                ],
              )
            ],
          ),
        );
      } else {
        return Container(
          child: Text("기록한 사용자가 없어용"),
        );
      }
    }
  }

  recordAndRankText() {
    RxString myrecord = "".obs;
    RxInt myRank = 0.obs;
    var record =
        pr.value.where((element) => element.data().keys.toList().indexWhere((element) => element == prName) != -1).first.data()[prName];
    if (type == "Weight") {
      record.sort((a, b) => double.parse(b.split("kg")[0]).compareTo(double.parse(a.split("kg")[0])));
    } else if (type == "Reps") {
      record.sort((a, b) => int.parse(b.split("/")[0]).compareTo(int.parse(a.split("/")[0])));
    } else {
      record.sort((a, b) => int.parse(a.split("/")[0]).compareTo(int.parse(b.split("/")[0])));
    }
    print("퍼스널레코드디테일프린트");
    print(record);
    var result = record.where((element) => element.toString().contains(userData.user.value.email!));
    if (result.length == 0) {
      myrecord.value = type == "Weight"
          ? "000.0${userData.user.value.showKg.value ? "kg" : "lb"}"
          : type == "Time" || type == "Named"
              ? '0' + "' " + "0" + '"'
              : "00회";
      myRank.value = record.indexWhere((element) => element.toString().contains(userData.user.value.email!)) + 1;
      print(record);
    } else {
      myRank.value = record.indexWhere((element) => element.toString().contains(userData.user.value.email!)) + 1;
      print(myRank);
      myrecord.value = changeText(text: result.first);
      print(myrecord);
    }
    return {"record": myrecord.value, "rank": myRank.value};
  }

  getDate() {
    var record =
        pr.value.where((element) => element.data().keys.toList().indexWhere((element) => element == prName) != -1).first.data()[prName];
    var result = record.where((element) => element.toString().contains(userData.user.value.email!));
    if (result.length != 0) {
      var dateParts = result.first.split("/")[2].split(".");
      var dateString = dateParts[0].split(" ")[0].replaceAll("-", ". ");

      return dateString;
    } else {
      return "기록 없음";
    }
  }

  textField({required controller, required double Function(double) sx}) {
    return Container(
      width: sx(100),
      height: sx(50),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: controller,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: sx(20)),
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Color(0xffb4b4b4))),
            isDense: true,
            filled: true,
            fillColor: Color(0xffe2eaff),
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
    );
  }
}
