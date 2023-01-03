import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:sweatbox2dot0/Controller/TimerController.dart';

class FortimeTimer extends StatelessWidget {
  String? timerType;

  TimerController timerController;
  FortimeTimer({totalsec, this.timerType, required this.timerController}) {}

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
          backgroundColor: Color(0xff313131),
          body: Obx(() => Stack(
                children: [
                  Positioned(
                      child: Container(
                          padding: EdgeInsets.all(sx(30)),
                          width: width,
                          height: height,
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                      onTapDown: (value) {
                                        print(value.globalPosition.dx);
                                        print(width / 2);
                                        if (value.globalPosition.dx < width / 2) {
                                          if (timerController.tap.value != 0) {
                                            timerController.tap.value--;
                                          }
                                        } else {
                                          timerController.tap.value++;
                                        }
                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: width,
                                            color: Color(0xff313131),
                                            child: timerType == "emom" || timerType == "tabata" ? rounds(sx) : tapCount(sx),
                                          ),
                                          SizedBox(
                                            width: width,
                                            height: sx(30),
                                          ),
                                          workOut(sx),
                                          timerType == "emom" || timerType == "tabata" ? rest(sx) : SizedBox(),
                                          Expanded(
                                            child: Container(
                                              color: Color(0xff313131),
                                            ),
                                          )
                                        ],
                                      ))),
                              Column(
                                children: [
                                  timerType == "fortime"
                                      ? Container(
                                          padding: EdgeInsets.only(bottom: sx(30)),
                                          width: width,
                                          child: SlideAction(
                                            outerColor: Color(0xff707070),
                                            innerColor: Colors.blue,
                                            submittedIcon: Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            ),
                                            onSubmit: () {
                                              timerController.stopTimer();
                                            },
                                            alignment: Alignment.center,
                                            child: Text(
                                              '밀어서 타이머 종료',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            sliderButtonIcon: Icon(
                                              Icons.arrow_forward_rounded,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(300)))),
                                          onPressed: () {
                                            timerController.pauseTimer();
                                          },
                                          child: Container(
                                            width: sx(300),
                                            height: sx(90),
                                            alignment: Alignment.center,
                                            child: Icon(timerController.pause.value ? Icons.play_arrow : Icons.pause),
                                          )),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Color(0xff707070),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(300)))),
                                          onPressed: () {
                                            timerController.giveUp();
                                          },
                                          child: Container(
                                            width: sx(50),
                                            height: sx(90),
                                            alignment: Alignment.center,
                                            child: Icon(Icons.close),
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: sx(30),
                                  )
                                ],
                              ),
                            ],
                          ))),
                  AnimatedPositioned(
                      curve: Curves.fastOutSlowIn,
                      bottom: timerController.countDown.value != 0 ? 0 : -height,
                      child: InkWell(
                        onTap: () {
                          if (timerController.finish == null) {
                            timerController.startTimer();
                          }
                        },
                        child: Container(
                            width: width,
                            height: height,
                            color: Colors.black.withOpacity(0.8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  height: sx(30),
                                ),
                                RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(children: [
                                      TextSpan(
                                        style: TextStyle(
                                            color: const Color(0xffffb100),
                                            fontWeight: FontWeight.w800,
                                            fontFamily: "AppleSDGothicNeo",
                                            fontStyle: FontStyle.normal,
                                            fontSize: sx(30)),
                                        text: "TIP\n",
                                      ),
                                      TextSpan(
                                          style: TextStyle(
                                              color: const Color(0xfff5e4bd),
                                              fontWeight: FontWeight.w800,
                                              fontFamily: "AppleSDGothicNeo",
                                              fontStyle: FontStyle.normal,
                                              fontSize: sx(27)),
                                          text: "\n탭 카은트를 할때,\n왼쪽은 - 오른쪽은 +")
                                    ])),
                                SizedBox(
                                  height: sx(30),
                                ),
                                Text(
                                  "${timerController.countDown.value}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: "AppleSDGothicNeo",
                                      fontStyle: FontStyle.normal,
                                      fontSize: sx(170)),
                                ),
                                SizedBox(
                                  height: sx(30),
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Color(0xff707070),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(300)))),
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Container(
                                      width: sx(50),
                                      height: sx(90),
                                      alignment: Alignment.center,
                                      child: Icon(Icons.close),
                                    )),
                              ],
                            )),
                      ),
                      duration: Duration(milliseconds: 500)),
                ],
              )));
    });
  }

  tapCount(double Function(double) sy) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tab counts",
          style: TextStyle(color: Color(0xff326aff), fontWeight: FontWeight.w700, fontSize: sy(30)),
        ),
        Text(
          "${timerController.tap.value}",
          style: TextStyle(color: Color(0xff326aff), fontWeight: FontWeight.w700, fontSize: sy(120), fontFamily: "Digital"),
        ),
      ],
    );
  }

  rounds(double Function(double) sy) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Round",
          style: TextStyle(color: Color(0xff326aff), fontWeight: FontWeight.w700, fontSize: sy(30)),
        ),
        Text(
          "${timerController.rounds.value}",
          style: TextStyle(color: Color(0xff326aff), fontWeight: FontWeight.w700, fontSize: sy(120), fontFamily: "Digital"),
        ),
      ],
    );
  }

  workOut(double Function(double) sy) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Workout",
          style: TextStyle(color: Color(0xffff2b2b), fontWeight: FontWeight.w700, fontSize: sy(30)),
        ),
        Text(
          NumberFormat("00", "en_US").format((timerController.totalTime.value / 60).floor()) +
              ":" +
              NumberFormat("00", "en_US").format(timerController.totalTime.value % 60),
          style: TextStyle(
            color: Color(0xffff2b2b),
            fontWeight: FontWeight.w700,
            fontFamily: "Digital",
            fontSize: sy(120),
          ),
        ),
      ],
    );
  }

  rest(double Function(double) sy) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Rest",
          style: TextStyle(color: Color(0xff00fe79), fontWeight: FontWeight.w700, fontSize: sy(30)),
        ),
        Text(
          NumberFormat("00", "en_US").format((timerController.restTime.value / 60).floor()) +
              ":" +
              NumberFormat("00", "en_US").format(timerController.restTime.value % 60),
          style: TextStyle(
            color: Color(0xff00fe79),
            fontWeight: FontWeight.w700,
            fontFamily: "Digital",
            fontSize: sy(120),
          ),
        ),
      ],
    );
  }

  slideToEnd(double Function(double) sy) {
    return Container(
      width: sy(450),
      child: SlideAction(
        outerColor: Color(0xff707070),
        innerColor: Colors.blue,
        submittedIcon: Icon(
          Icons.check,
          color: Colors.white,
        ),
        onSubmit: () {
          timerController.stopTimer();
        },
        alignment: Alignment.center,
        child: Text(
          '밀어서 타이머 종료',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        sliderButtonIcon: Icon(
          Icons.arrow_forward_rounded,
          color: Colors.white,
        ),
      ),
    );
  }

  pauseButton(double Function(double) sy) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(300)))),
        onPressed: () {
          timerController.pauseTimer();
        },
        child: Container(
          width: sy(300),
          height: sy(90),
          alignment: Alignment.center,
          child: Icon(timerController.pause.value ? Icons.play_arrow : Icons.pause),
        ));
  }

  giveUpButton(double Function(double) sy) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Color(0xff707070), shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(300)))),
        onPressed: () {
          timerController.giveUp();
        },
        child: Container(
          width: sy(50),
          height: sy(90),
          alignment: Alignment.center,
          child: Icon(Icons.close),
        ));
  }
}
