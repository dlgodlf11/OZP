import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CamController extends GetxController {
  RxList cameras = <dynamic>[].obs;
  late Rx<CameraController> camController;
  RxBool mounted = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("init");
    availableCameras().then((value) {
      value.forEach((element) {
        cameras.add(element);
      });
      camController = new CameraController(
              cameras.firstWhere((description) => description.lensDirection == CameraLensDirection.front), ResolutionPreset.max)
          .obs;
      // camController.value.addListener(() {
      //   print(camController.value.value.aspectRatio);
      //   print(camController.value.value.deviceOrientation);
      // });
      camController.value.initialize().then((value) {
        camController.value.lockCaptureOrientation(
          DeviceOrientation.portraitUp,
        );
        mounted.value = !mounted.value;
      });

      print(cameras);
    });
  }

  changeCam() {
    // get current lens direction (front / rear)
    print("object");
    mounted.value = false;
    final lensDirection = camController.value.description.lensDirection;
    CameraDescription newDescription;
    if (lensDirection == CameraLensDirection.front) {
      newDescription = cameras.firstWhere((description) => description.lensDirection == CameraLensDirection.back);
    } else {
      newDescription = cameras.firstWhere((description) => description.lensDirection == CameraLensDirection.front);
    }

    if (newDescription != null) {
      camController = new CameraController(newDescription, ResolutionPreset.max).obs;
      camController.value.initialize().then((value) {
        mounted.value = !mounted.value;
      });
      ;
    } else {
      print('Asked camera not available');
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    print("dispose");
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      // DeviceOrientation.portraitDown,
    ]);
    camController.value.dispose();
    cameras.clear();
  }
}
