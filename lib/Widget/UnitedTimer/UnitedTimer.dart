import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:sweatbox2dot0/Widget/UnitedTimer/TapTimer.dart';
import 'package:sweatbox2dot0/Widget/UnitedTimer/TimerSetting.dart';

class UnitedTimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
        appBar: AppBar(
          title: Text("와드 타이머"),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset('assets/appbarIcon/btn_back.svg'),
          ),
        ),
        body: ListView(
          scrollDirection: Axis.horizontal,
          physics: PageScrollPhysics(),
          children: [
            timerTile(sx: sx, timertype: "tap", width: width, height: height),
            timerTile(sx: sx, timertype: "amrap", width: width, height: height),
            timerTile(sx: sx, timertype: "fortime", width: width, height: height),
            timerTile(sx: sx, timertype: "emom", width: width, height: height),
            timerTile(sx: sx, timertype: "tabata", width: width, height: height),
          ],
        ),
      );
    });
  }

  timerTile({required double Function(double) sx, required timertype, required width, required height}) {
    return Container(
      width: width,
      height: height,
      child: Column(
        children: [
          Expanded(
              child: Container(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(child: Lottie.asset(mothionPath(timertype))),
                Positioned(
                    child: Image.asset(
                  imagePath(timertype),
                ))
              ],
            ),
          )),
          Padding(
            padding: EdgeInsets.all(sx(40)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(border: Border(top: BorderSide(width: 1))),
                          child: Text(
                            timertype.toUpperCase(),
                            style: TextStyle(color: Colors.black, fontSize: sx(45), fontWeight: FontWeight.w800),
                          ),
                        ),
                        SizedBox(
                          height: sx(10),
                        ),
                        Text(
                          timerTitle(timertype),
                          style: TextStyle(color: Color(0xff595959), fontSize: sx(30), fontWeight: FontWeight.w800),
                        )
                      ],
                    ),
                    CircleAvatar(
                      radius: sx(45),
                      backgroundColor: Colors.white,
                      child: SvgPicture.asset(simbolPath(timertype)),
                    )
                  ],
                ),
                SizedBox(
                  height: sx(20),
                ),
                Text(
                  timerSubTitle(timertype),
                  style: TextStyle(color: Color(0xff595959), fontSize: sx(20), fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: sx(30),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0xff0046ff)),
                  onPressed: () {
                    switch (timertype) {
                      case ("tap"):
                        Get.to(() => TapTimer(), transition: Transition.size, duration: Duration(milliseconds: 500));
                        break;
                      case ("amrap"):
                        Get.bottomSheet(TimerSetting(timerType: "amrap"), isScrollControlled: true, enableDrag: false).then((value) {
                          SystemChrome.setEnabledSystemUIOverlays([]);
                        });
                        break;
                      case ("fortime"):
                        Get.bottomSheet(TimerSetting(timerType: "fortime"), isScrollControlled: true, enableDrag: false).then((value) {
                          SystemChrome.setEnabledSystemUIOverlays([]);
                        });
                        break;
                      case ("emom"):
                        Get.bottomSheet(TimerSetting(timerType: "emom"), isScrollControlled: true, enableDrag: false).then((value) {
                          SystemChrome.setEnabledSystemUIOverlays([]);
                        });
                        break;
                      case ("tabata"):
                        Get.bottomSheet(TimerSetting(timerType: "tabata"), isScrollControlled: true, enableDrag: false).then((value) {
                          SystemChrome.setEnabledSystemUIOverlays([]);
                        });
                        break;
                      default:
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: sx(80),
                    alignment: Alignment.center,
                    child: Text(
                      "시작하기",
                      style: TextStyle(color: Colors.white, fontSize: sx(20), fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  imagePath(timerType) {
    switch (timerType) {
      case ("tap"):
        return 'assets/RandomWodIcon/WODtimer(TAP).png';
      case ("amrap"):
        return 'assets/RandomWodIcon/WODtimer(AMRAP).png';
      case ("fortime"):
        return 'assets/RandomWodIcon/WODtimer(FORTIME).png';
      case ("emom"):
        return 'assets/RandomWodIcon/WODtimer(EMOM).png';
      case ("tabata"):
        return 'assets/RandomWodIcon/WODtimer(TABATA).png';
      default:
    }
  }

  mothionPath(timerType) {
    switch (timerType) {
      case ("tap"):
        return 'assets/Timer/Timer_Tap.json';
      case ("amrap"):
        return 'assets/Timer/Timer_AMRAP.json';
      case ("fortime"):
        return 'assets/Timer/Timer_FORTIME.json';
      case ("emom"):
        return 'assets/Timer/Timer_EMOM.json';
      case ("tabata"):
        return 'assets/Timer/Timer_TABATA.json';
      default:
    }
  }

  simbolPath(timerType) {
    switch (timerType) {
      case ("tap"):
        return 'assets/Timer/TAP.svg';
      case ("amrap"):
        return 'assets/Timer/AMRAP.svg';
      case ("fortime"):
        return 'assets/Timer/FORTIME.svg';
      case ("emom"):
        return 'assets/Timer/EMOM.svg';
      case ("tabata"):
        return 'assets/Timer/TABATA.svg';
      default:
    }
  }

  timerTitle(timerType) {
    switch (timerType) {
      case ("tap"):
        return '가장 빠른 손놀림!';
      case ("amrap"):
        return '라운드를 극복한 자!';
      case ("fortime"):
        return '시간을 걸고 한계를 넘어라!';
      case ("emom"):
        return '나에게 주어진 단 1분!';
      case ("tabata"):
        return '내 몸에 숨겨진 임계점!';
      default:
    }
  }

  timerSubTitle(timerType) {
    switch (timerType) {
      case ("tap"):
        return '주체할 수 없는 당신의 숨겨진 반응속도를 체감하라';
      case ("amrap"):
        return '시간 내에 누가 가장 많은 성과를 얻을 것인가';
      case ("fortime"):
        return '정해진 시간안에 모든 와드를 완성하라';
      case ("emom"):
        return '격렬함 뒤에 찾아오는 달콤한 휴식을 즐겨라';
      case ("tabata"):
        return '4분간에 모든 것을 끌어내고 더욱 강해짐을 경험하라';
      default:
    }
  }
}
