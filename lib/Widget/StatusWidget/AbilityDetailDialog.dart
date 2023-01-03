import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:sweatbox2dot0/Controller/UserDataController.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class AbilityDetail extends StatelessWidget {
  String title = "";
  String rankText = "";
  String tipText = "";
  int level = 0;
  var userData = Get.put(UserController());

  AbilityDetail({required String ability, required List<List<int>> data}) {
    var comuTitle = ["마이웨이", "눈팅족", "어서오고", "인싸", "인플루언서"];
    var kkunKeyTitle = ["Memory", "Memo", "Notebook", "Book", "Dictionary"];
    var trybilityTitle = ["Closed", "Open", "Quater Final", "Semi Final", "Games"];
    var strengthTitle = ["Beginner", "Novice", "Intermediate", "Advanced", "Elite"];
    var strengthRank = ["Fittest on SWEAT", "Second", "Third"];
    var honerTitle = ["Normal", "Rare", "Unique", "Hero", "Legend"];
    var enthusiasmTitle = ["Rare", "Medium Rare", "Medium", "Medium Well-done", "Well-done"];
    switch (ability) {
      case ("comu"):
        title = "소통";
        rankText = comuTitle[data[0][0] - 1];
        tipText = "많은 사람들과 활발한 소통을 해보세요!";
        level = data[0][0];
        break;
      case ("kkunkey"):
        tipText = "꾸준한 기록은 체계적인 성장을 위한 올바른 습관이에요!";
        rankText = kkunKeyTitle[data[0][1] - 1];
        title = "끈기";
        level = data[0][1];

        break;
      case ("trybility"):
        tipText = "당신의 강함을 마구 뽐내주세요!";
        rankText = trybilityTitle[data[0][2] - 1];
        title = "노력";
        level = data[0][2];
        break;
      case ("strength"):
        tipText = "스웨트박스의 다양한 기능을 마음껏 활용해보세요!";
        rankText = strengthTitle[data[0][3] - 1];
        title = "강함";
        level = data[0][3];
        break;
      case ("honer"):
        tipText = "나의 부족함을 채워주는 고급진 클래스를 통해 발전해보세요!";
        rankText = honerTitle[data[0][4] - 1];
        title = "명예";
        level = data[0][4];
        break;
      case ("enthusiasm"):
        tipText = "더 많은 뱃지로 당신의 명예를 높여보세요!";
        rankText = enthusiasmTitle[data[0][5] - 1];
        title = "열정";
        level = data[0][5];
        break;
      default:
    }
  }
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Container(
        width: width,
        height: height,
        child: Center(
          child: Material(
            color: Colors.black.withOpacity(0),
            child: Container(
              width: sx(400),
              height: sx(700),
              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.all(Radius.circular(40))),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: sx(40), bottom: sx(30)),
                    child: Text(
                      title,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: sx(35)),
                    ),
                  ),
                  Container(
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        style: TextStyle(
                            color: const Color(0xff707070), fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: sx(30)),
                        text: "현재 ${userData.user.value.nickName} 님은\n",
                      ),
                      TextSpan(
                          style: TextStyle(
                              color: const Color(0xff084bff), fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: sx(30)),
                          text: rankText),
                      TextSpan(
                        style: TextStyle(
                            color: const Color(0xff707070), fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: sx(30)),
                        text: "입니다.",
                      ),
                    ])),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: sx(20)),
                    child: SfSliderTheme(
                        data: SfSliderThemeData(
                          activeTrackHeight: 1,
                          inactiveTrackHeight: 1,
                          inactiveTrackColor: Color(0xff707070),
                          activeTickColor: Color(0xff707070),
                          activeDividerRadius: sx(10),
                          inactiveDividerRadius: sx(7),
                          thumbColor: Color(0xff326aff),
                          activeTrackColor: Color(0xff707070),
                          activeDividerColor: Color(0xff707070),
                          inactiveDividerColor: Color(0xff707070),
                          thumbStrokeWidth: sx(15),
                          thumbRadius: sx(15),
                        ),
                        child: SfSlider(
                            value: level,
                            max: 5,
                            min: 1,
                            interval: 1,
                            stepSize: 1,
                            showLabels: false,
                            //showTicks: true,
                            showDividers: true,
                            dividerShape: SfDividerShape(),
                            enableTooltip: true,
                            onChanged: (value) {})),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
