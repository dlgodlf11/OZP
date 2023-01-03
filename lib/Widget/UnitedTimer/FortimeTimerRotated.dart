import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:sweatbox2dot0/Controller/TimerController.dart';

class FortimeTimerRotated extends StatelessWidget {
  String? timerType;

  TimerController timerController;
  FortimeTimerRotated({totalsec, this.timerType, required this.timerController}) {}

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
          backgroundColor: Color(0xff313131),
          body: Obx(() => Stack(
                children: [
                  Positioned(
                      child: Container(
                          padding: EdgeInsets.all(sy(30)),
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
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                timerType == "emom" || timerType == "tabata" ? rounds(sy) : tapCount(sy),
                                                timerType == "emom" || timerType == "tabata"
                                                    ? Row(
                                                        children: [
                                                          pauseButton(sy),
                                                          SizedBox(
                                                            width: sy(50),
                                                          ),
                                                          giveUpButton(sy)
                                                        ],
                                                      )
                                                    : workOut(sy)
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              child: Container(
                                            color: Color(0xff313131),
                                          ))
                                        ],
                                      ))),
                              timerType == "emom" || timerType == "tabata"
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [workOut(sy), rest(sy)],
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        timerType == "fortime" ? slideToEnd(sy) : SizedBox(),
                                        SizedBox(
                                          width: sy(40),
                                        ),
                                        pauseButton(sy),
                                        SizedBox(
                                          width: sy(40),
                                        ),
                                        giveUpButton(sy)
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
                                  height: sy(30),
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
                                            fontSize: sy(30)),
                                        text: "TIP\n",
                                      ),
                                      TextSpan(
                                          style: TextStyle(
                                              color: const Color(0xfff5e4bd),
                                              fontWeight: FontWeight.w800,
                                              fontFamily: "AppleSDGothicNeo",
                                              fontStyle: FontStyle.normal,
                                              fontSize: sy(27)),
                                          text: "\n탭 카은트를 할때,\n왼쪽은 - 오른쪽은 +")
                                    ])),
                                SizedBox(
                                  height: sy(30),
                                ),
                                Text(
                                  "${timerController.countDown.value}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: "AppleSDGothicNeo",
                                      fontStyle: FontStyle.normal,
                                      fontSize: sy(170)),
                                ),
                                SizedBox(
                                  height: sy(30),
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Color(0xff707070),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(300)))),
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Container(
                                      width: sy(50),
                                      height: sy(90),
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
