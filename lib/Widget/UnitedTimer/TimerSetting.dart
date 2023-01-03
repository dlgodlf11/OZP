import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:sweatbox2dot0/Widget/UnitedTimer/FortimeTimer.dart';
import 'package:sweatbox2dot0/Widget/UnitedTimer/InTimer.dart';

class TimerSetting extends StatelessWidget {
  String timerType = "";
  RxBool isUp = true.obs;
  TextEditingController minText = new TextEditingController(text: "0");
  TextEditingController secText = new TextEditingController(text: "0");
  TextEditingController restminText = new TextEditingController(text: "0");
  TextEditingController restsecText = new TextEditingController(text: "0");

  TextEditingController roundText = new TextEditingController(text: "0");

  TimerSetting({required this.timerType}) {
    if (timerType == "tabata") {
      secText.text = "20";
      restsecText.text = "10";
      roundText.text = "8";
    }
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        SystemChrome.setEnabledSystemUIOverlays([]);
      },
      child: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: sx(25), vertical: sx(10)),
            height: timerType == "tabata" || timerType == "emom" ? sx(460) : sx(440),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: sx(80),
                  child: Text(
                    titleText(timerType),
                    style: TextStyle(fontSize: sx(25), fontWeight: FontWeight.w600, color: Color(0xff54594c)),
                  ),
                ),
                Divider(),
                timerType == "emom" || timerType == "tabata"
                    ? Container(
                        height: sx(80),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "라운드",
                              style: TextStyle(
                                fontSize: sx(22),
                                fontWeight: FontWeight.w700,
                                color: Color(0xff707070),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.all(Radius.circular(5))),
                                  width: sx(70),
                                  height: sx(50),
                                  child: TextField(
                                    controller: roundText,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: sx(20)),
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Color(0xffb4b4b4))),
                                        isDense: true,
                                        filled: true,
                                        fillColor: Color(0xfff7f7f7),
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
                                  width: sx(10),
                                ),
                                Text("R"),
                              ],
                            ),
                          ],
                        ))
                    : SizedBox(),
                Container(
                    height: sx(80),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          timerType == "emom" || timerType == "tabata" ? "WORKOUT" : "TIME CAP",
                          style: TextStyle(
                            fontSize: sx(22),
                            fontWeight: FontWeight.w700,
                            color: timerType == "emom" || timerType == "tabata" ? Color(0xff0046ff) : Color(0xff707070),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.all(Radius.circular(5))),
                              width: sx(70),
                              height: sx(50),
                              child: TextField(
                                controller: minText,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: sx(20)),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Color(0xffb4b4b4))),
                                    isDense: true,
                                    filled: true,
                                    fillColor: Color(0xfff7f7f7),
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
                              width: sx(10),
                            ),
                            Text("분"),
                            SizedBox(
                              width: sx(20),
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.all(Radius.circular(5))),
                              width: sx(70),
                              height: sx(50),
                              child: TextField(
                                controller: secText,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: sx(20)),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Color(0xffb4b4b4))),
                                    isDense: true,
                                    filled: true,
                                    fillColor: Color(0xfff7f7f7),
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
                              width: sx(10),
                            ),
                            Text("초"),
                          ],
                        ),
                      ],
                    )),
                timerType == "emom" || timerType == "tabata"
                    ? Container(
                        height: sx(80),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "REST",
                              style: TextStyle(
                                fontSize: sx(22),
                                fontWeight: FontWeight.w700,
                                color: Color(0xff0046ff),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.all(Radius.circular(5))),
                                  width: sx(70),
                                  height: sx(50),
                                  child: TextField(
                                    controller: restminText,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: sx(20)),
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Color(0xffb4b4b4))),
                                        isDense: true,
                                        filled: true,
                                        fillColor: Color(0xfff7f7f7),
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
                                  width: sx(10),
                                ),
                                Text("분"),
                                SizedBox(
                                  width: sx(20),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.all(Radius.circular(5))),
                                  width: sx(70),
                                  height: sx(50),
                                  child: TextField(
                                    controller: restsecText,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: sx(20)),
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Color(0xffb4b4b4))),
                                        isDense: true,
                                        filled: true,
                                        fillColor: Color(0xfff7f7f7),
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
                                  width: sx(10),
                                ),
                                Text("초"),
                              ],
                            ),
                          ],
                        ))
                    : SizedBox(),
                timerType == "fortime" || timerType == "amrap"
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "TIMER",
                                style: TextStyle(
                                  fontSize: sx(22),
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff707070),
                                ),
                              ),
                              Row(
                                children: [
                                  Obx(() => InkWell(
                                        onTap: () {
                                          isUp.value = true;
                                        },
                                        child: Container(
                                          height: sx(80),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "UP",
                                                style: TextStyle(
                                                  fontSize: sx(22),
                                                  fontWeight: FontWeight.normal,
                                                  color: Color(0xff707070),
                                                ),
                                              ),
                                              SizedBox(
                                                width: sx(20),
                                              ),
                                              Container(
                                                width: sx(44),
                                                height: sx(44),
                                                padding: EdgeInsets.all(sx(5)),
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Color(0xff0046ff), width: 3),
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(300),
                                                    )),
                                                child: CircleAvatar(
                                                    radius: sx(10), backgroundColor: isUp.value ? Color(0xff0046ff) : Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                                  SizedBox(
                                    width: sx(40),
                                  ),
                                  Obx(() => InkWell(
                                        onTap: () {
                                          isUp.value = false;
                                        },
                                        child: Container(
                                          height: sx(80),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "DOWN",
                                                style: TextStyle(
                                                  fontSize: sx(22),
                                                  fontWeight: FontWeight.normal,
                                                  color: Color(0xff707070),
                                                ),
                                              ),
                                              SizedBox(
                                                width: sx(20),
                                              ),
                                              Container(
                                                width: sx(44),
                                                height: sx(44),
                                                padding: EdgeInsets.all(sx(5)),
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Color(0xff0046ff), width: 3),
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(300),
                                                    )),
                                                child: CircleAvatar(
                                                    radius: sx(10), backgroundColor: !isUp.value ? Color(0xff0046ff) : Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    : SizedBox(),
                Container(
                  height: sx(70),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xff0046ff), shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                    onPressed: () {
                      try {
                        Get.back();
                        var totalSec = (int.parse(minText.text) * 60) + int.parse(secText.text);
                        var round = int.parse(roundText.text);
                        var rest = (int.parse(restminText.text) * 60) + int.parse(restsecText.text);
                        switch (timerType) {
                          case ("fortime"):
                            Get.to(
                                () => InTimer(
                                      totalsec: totalSec,
                                      timerType: timerType,
                                      isUp: isUp.value,
                                    ),
                                transition: Transition.zoom);
                            break;
                          case ("amrap"):
                            Get.to(() => InTimer(totalsec: totalSec, timerType: timerType, isUp: isUp.value, rest: rest),
                                transition: Transition.zoom);
                            break;
                          case ("emom"):
                            Get.to(
                                () => InTimer(
                                      totalsec: totalSec,
                                      timerType: timerType,
                                      isUp: isUp.value,
                                      rest: rest,
                                      rounds: round,
                                    ),
                                transition: Transition.zoom);
                            break;
                          case ("tabata"):
                            Get.to(
                                () => InTimer(
                                      totalsec: totalSec,
                                      timerType: timerType,
                                      isUp: isUp.value,
                                      rest: rest,
                                      rounds: round,
                                    ),
                                transition: Transition.zoom);
                            break;
                          default:
                        }
                      } catch (e) {}
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: width,
                      child: Text("완료"),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  titleText(timertype) {
    switch (timerType) {
      case ("amrap"):
        return 'AMRAP 라운드를 극복한 자!';
      case ("fortime"):
        return 'FORTIME 시간을 걸고 한계를 넘어라!';
      case ("emom"):
        return 'EMOM 나에게 주어진 단 1분!';
      case ("tabata"):
        return 'TABATA 내 몸에 숨겨진 임계점!';
      default:
    }
  }
}
