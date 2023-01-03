import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:sweatbox2dot0/Widget/SweatRecord/camController.dart';

class CamHorizontal extends StatelessWidget {
  var camConroll = Get.put(CamController());
  bool record = false;
  RxDouble camWidth = 0.0.obs;
  CamHorizontal() {}
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
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
              child: CameraPreview(
                camConroll.camController.value,
              ),
            )
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
