import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:better_sound_effect/better_sound_effect.dart';
import 'package:get/get.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:sweatbox2dot0/Services/database.dart';

class TimerController extends GetxController {
  RxInt totalTime = 0.obs;
  RxInt restTime = 0.obs;
  RxInt countDown = 10.obs;
  bool isUp = true;
  String timeType = "";
  RxBool? finish = null;
  RxInt tap = 0.obs;
  RxInt rounds = 0.obs;
  RxInt runtime = 0.obs;
  StreamSubscription<AccelerometerEvent>? sensor;
  RxInt rotate = 1.obs;
  Timer? timer;
  RxBool pause = false.obs;

  int? soundId;
  final soundEffect = BetterSoundEffect();

  var workout = 0;
  var rest = 0;
  var runningRound = 0;

  initAFTimer({
    required totaltime,
    required isup,
    required timetype,
  }) {
    countDown.value = 10;
    totalTime.value = totaltime;
    timeType = timetype;
    isUp = isup;
  }

  initTETimer({required totaltime, required timetype, required resttime, required round}) {
    countDown.value = 10;
    totalTime.value = totaltime;
    restTime.value = resttime;
    timeType = timetype;

    rounds.value = round;
  }

  startTimer() async {
    finish = false.obs;
    timer = await Timer.periodic(Duration(seconds: 1), (time) {
      if (!finish!.value) {
        countDown.value--;
        print(countDown.value);
        if (countDown.value == 0) {
          time.cancel();

          switch (timeType) {
            case ("fortime"):
              _startAFTimer();
              break;
            case ("amrap"):
              _startAFTimer();
              break;
            case ("emom"):
              _startTETimer();
              break;
            case ("tabata"):
              _startTETimer();
              break;
            default:
          }
        }
      } else {
        timer!.cancel();
      }
    });
  }

  _startTETimer() {
    finish!.value = false;
    workout = totalTime.value;
    rest = restTime.value;
    runningRound = rounds.value;
    var state = "workout";
    timer = Timer.periodic(Duration(seconds: 1), (time) {
      if (pause.value == false) {
        if (state == "workout") {
          totalTime.value--;
        } else {
          restTime.value--;
        }
        runtime.value++;
        print(runtime);
        if (finish!.value) {
          time.cancel();

          //  Get.back();
        }
        if (totalTime.value == 0) {
          totalTime.value = workout;
          state = "rest";
          // restTime.value--;
        }
        if (runtime.value == 209) {
          //.soundEffect.play(soundId!);
          AssetsAudioPlayer.newPlayer().open(
            Audio("assets/audios/overwatch.mp3"),
            showNotification: true,
          );
        }
        if (restTime.value == 0) {
          restTime.value = rest;
          state = "workout";
          rounds.value--;
        }
        if (rounds.value == 0) {
          time.cancel();
          Database().saveTimerRecord(timeType, runtime.value, false, runningRound, rest, workout);
          finish!.value = true;
          // Get.back();
        }
      }
    });
  }

  _startAFTimer() {
    workout = totalTime.value;

    finish!.value = false;
    if (isUp) {
      totalTime.value = 0;
      timer = Timer.periodic(Duration(seconds: 1), (time) {
        if (pause.value == false) {
          totalTime.value++;
          runtime.value++;
          print(totalTime.value);
          if (finish!.value) {
            time.cancel();
            finish!.value = true;
            //Get.back();
          }
          if (totalTime.value == workout) {
            time.cancel();
            Database().saveTimerRecord(timeType, runtime.value, false, runningRound, rest, workout);
            finish!.value = true;
            //Get.back();
          }
        }
      });
    } else {
      timer = Timer.periodic(Duration(seconds: 1), (time) {
        if (pause.value == false) {
          totalTime.value--;
          runtime.value++;
          print(totalTime.value);
          if (finish!.value) {
            time.cancel();
            finish!.value = true;
            //Get.back();
          }
          if (totalTime.value == 31) {
            //soundEffect.play(soundId!);
            AssetsAudioPlayer.newPlayer().open(
              Audio("assets/audios/overwatch.mp3"),
              showNotification: true,
            );
          }
          if (totalTime.value <= 0) {
            time.cancel();
            Database().saveTimerRecord(timeType, runtime.value, false, runningRound, rest, workout);
            finish!.value = true;
            //Get.back();
          }
        }
      });
    }
  }

  stopTimer() {
    finish!.value = true;
    Database().saveTimerRecord(timeType, runtime.value, false, runningRound, rest, workout);
  }

  giveUp() {
    finish!.value = true;
    Database().saveTimerRecord(timeType, runtime.value, true, runningRound, rest, workout);
  }

  pauseTimer() {
    pause.value = !pause.value;
  }

  @override
  void onClose() {
    if (timer != null) timer!.cancel();
    sensor!.cancel();
    if (soundId != null) {
      soundEffect.release(soundId!);
    }
    super.onClose();
  }

  @override
  void onInit() {
    Future.microtask(() async {
      soundId = await soundEffect.loadAssetAudioFile('assets/audios/overwatch.wav');
    });
    sensor = accelerometerEvents.listen((AccelerometerEvent event) {
      //  print(event);
      if (event.x <= -5 && event.x < 0) {
        // print("홈버튼이 왼쪽으로 있는채로 세운다");
        rotate.value = 2;
      } else if (event.x >= 5) {
        // print("홈버튼이 오른쪽에 있는채로 세운다");
        rotate.value = 4;
      } else {
        rotate.value = 1;
      }
    });
    super.onInit();
  }
}
