import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:device_screen_recorder/device_screen_recorder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:speech_bubble/speech_bubble.dart';
import 'package:sweatbox2dot0/Controller/TimerController.dart';
import 'package:sweatbox2dot0/Widget/SweatRecord/camController.dart';
import 'package:video_compress/video_compress.dart';

class CamVertical extends StatelessWidget {
  var camConroll = Get.put(CamController());
  RxBool record = false.obs;
  RxDouble camWidth = 0.0.obs;
  String name = "비어있음";
  String wodTitle = "비어있음";
  TimerController timerController;
  RxString speechBubble = "".obs;
  Rx<File>? recordFile;
  CamVertical({required this.wodTitle, required this.name, required this.timerController}) {}
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      // DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);

    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Obx(() {
        if (camWidth.value == 0.0) {
          camWidth.value = MediaQuery.of(context).size.width;
        }
        return Scaffold(
            backgroundColor: Colors.black,
            body: Container(
                alignment: Alignment.center,
                width: width,
                height: height,
                child: Stack(
                  children: [
                    Stack(
                      children: [
                        CameraPreview(camConroll.camController.value),
                        Positioned(
                            top: sx(20),
                            left: sx(20),
                            child: Text(
                              name,
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: sx(30)),
                            )),
                        Positioned(
                            top: sx(70),
                            left: sx(20),
                            child: Text(
                              wodTitle,
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: sx(20)),
                            )),
                        Positioned(
                            top: sx(120),
                            left: sx(20),
                            child: Obx(() => AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.fastOutSlowIn,
                                  child: timerController.countDown.value == 0
                                      ? Text(
                                          NumberFormat("00", "en_US").format((timerController.totalTime.value / 60).floor()) +
                                              ":" +
                                              NumberFormat("00", "en_US").format(timerController.totalTime.value % 60),
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: sx(70)),
                                        )
                                      : Text(
                                          "${timerController.countDown.value}",
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: sx(70)),
                                        ),
                                ))),
                        Positioned(
                            top: sx(120),
                            left: sx(20),
                            child: Obx(() => AnimatedContainer(
                                  width: sx(10),
                                  height: sx(10),
                                  duration: Duration(milliseconds: 1000),
                                  curve: Curves.fastOutSlowIn,
                                  decoration: BoxDecoration(
                                      color: timerController.totalTime.value % 2 != 0 ? Colors.red : Colors.red.withOpacity(0),
                                      borderRadius: BorderRadius.all(Radius.circular(900))),
                                ))),
                        Positioned(
                            bottom: sx(20),
                            left: sx(20),
                            child: SvgPicture.asset('assets/sweatRecord/sweatbox.svg', width: sx(170), color: Colors.white))
                      ],
                    ),
                    Positioned(
                        bottom: sx(140),
                        right: sx(60),
                        child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.fastOutSlowIn,
                            width: record.value ? sx(170) : sx(0),
                            height: record.value ? sx(60) : sx(0),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: SpeechBubble(
                                color: Colors.white,
                                nipLocation: NipLocation.BOTTOM_RIGHT,
                                child: timerController.finish != null && timerController.finish!.value == true
                                    ? Text("타이머끝났어요\n다시 눌러서 녹화종료 해벌이세요.")
                                    : Text(speechBubble.value),
                              ),
                            ))),
                    Positioned(
                        bottom: sx(20),
                        right: sx(20),
                        child: InkWell(
                            onTap: () async {
                              print(timerController.totalTime.value);
                              if (record.value == false) {
                                DeviceScreenRecorder.startRecordScreen(name: "Asdfasdf");
                                record.value = true;
                                speechBubble.value = "녹화시작됬어용\n한번 더 눌러서 타이머도 기릿";
                              } else if (record.value && timerController.finish == null) {
                                print("타이머시작");
                                timerController.startTimer();

                                speechBubble.value = "타이머 시작됬어요\n중단 할라면 다시한번 누르시요\n 일시중지 이런거 없어요";
                              } else if (record.value && timerController.finish!.value == false) {
                                timerController.finish!.value = true;

                                speechBubble.value = "타이머끝났어요\n다시 눌러서 녹화종료 해벌이세요.";
                              } else if (record.value && timerController.finish!.value == true) {
                                record.value = false;
                                DeviceScreenRecorder.stopRecordScreen().then((value) {
                                  ImageGallerySaver.saveFile(value!);
                                  // VideoCompress.compressVideo(value!, quality: VideoQuality.MediumQuality).then((video) {
                                  //   ImageGallerySaver.saveFile(video!.file!.path);
                                  // });
                                });

                                speechBubble.value = "";
                              }
                            },
                            child: Obx(
                              () => Container(
                                  width: sx(100),
                                  height: sx(100),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(900)),
                                      border: Border.all(
                                        width: sx(10),
                                        color: Colors.white,
                                      )),
                                  child: Stack(
                                    children: [
                                      AnimatedContainer(
                                        width: record.value ? sx(50) : sx(80),
                                        height: record.value ? sx(50) : sx(80),
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.fastOutSlowIn,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(record.value ? 10 : 900)),
                                            color: record.value ? Colors.black : Colors.red),
                                      ),
                                    ],
                                  )),
                            )))
                  ],
                ))
            // body: Container(
            //     width: MediaQuery.of(context).size.width,
            //     height: MediaQuery.of(context).size.height,
            //     alignment: Alignment.center,
            //     child: Stack(
            //       alignment: Alignment.center,
            //       children: [
            //         Positioned(
            //             top: 1,
            //             child: Container(
            //               width: MediaQuery.of(context).size.width,
            //               child: camConroll.camController != null && camConroll.mounted.value
            //                   ? CameraPreview(
            //                       camConroll.camController.value,
            //                     )
            //                   : Container(
            //                       color: Colors.black,
            //                     ),
            //             )),
            //         Positioned(
            //             bottom: 0,
            //             child: IconButton(
            //               icon: Icon(
            //                 Icons.refresh,
            //                 color: Colors.white,
            //               ),
            //               onPressed: () {
            //                 camConroll.changeCam();
            //               },
            //             ))
            //       ],
            //     ))
            );
      });
    });
  }
}
