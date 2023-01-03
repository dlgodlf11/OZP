import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:sweatbox2dot0/Controller/StatusStateController.dart';
import 'package:sweatbox2dot0/Controller/UserDataController.dart';
import 'package:sweatbox2dot0/Controller/ViewMainStateController.dart';
import 'package:sweatbox2dot0/Services/database.dart';
import 'package:sweatbox2dot0/Widget/StatusWidget/AbilityDetailDialog.dart';
import 'package:sweatbox2dot0/Widget/StatusWidget/AbilityTips.dart';

class AblityWidget extends StatelessWidget {
  var ticks = [1, 2, 3, 4, 5];
  var features = [" ", " ", " ", " ", " ", " "];
  var data = [
    [3, 4, 2, 1, 5, 2]
  ];
  var userData = Get.put(UserController());
  var comuTitle = ["마이웨이", "눈팅족", "어서오고", "인싸", "인플루언서"];
  var kkunKeyTitle = ["Memory", "Memo", "Notebook", "Book", "Dictionary"];
  var trybilityTitle = ["Closed", "Open", "Quater Final", "Semi Final", "Games"];
  var strengthTitle = ["Beginner", "Novice", "Intermediate", "Advanced", "Elite"];
  var strengthRank = ["Fittest on SWEAT", "Second", "Third"];
  var honerTitle = ["Normal", "Rare", "Unique", "Hero", "Legend"];
  var enthusiasmTitle = ["Rare", "Medium Rare", "Medium", "Medium Well-done", "Well-done"];
  var statusStateController = Get.put(StatusStateController());

  bool useSides = true;
  AblityWidget() {
    print(Database().measureAbility());
    data = [Database().measureAbility()];
    print(data);
  }
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: Obx(() => SingleChildScrollView(
                controller: statusStateController.statusScrollController,
                child: Container(
                  width: width,
                  padding: EdgeInsets.only(top: sx(150) * statusStateController.enablePadding.value, bottom: sx(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: sx(400),
                        height: sx(400),
                        child: RadarChart.light(
                          ticks: ticks,
                          features: features,
                          data: data,
                          reverseAxis: false,
                          useSides: useSides,
                        ),
                      ),
                      abilityDetail(ability: "comu", sx: sx),
                      abilityDetail(ability: "kkunkey", sx: sx),
                      abilityDetail(ability: "trybility", sx: sx),
                      abilityDetail(ability: "strength", sx: sx),
                      abilityDetail(ability: "honer", sx: sx),
                      abilityDetail(ability: "enthusiasm", sx: sx),
                      Container(
                        width: width,
                        height: sx(100),
                        color: Color(0xfffff9ed),
                        padding: EdgeInsets.symmetric(horizontal: sx(30), vertical: sx(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: sx(50),
                              height: sx(50),
                              padding: EdgeInsets.all(sx(5)),
                              decoration: BoxDecoration(color: Color(0xffffb100), borderRadius: BorderRadius.all(Radius.circular(10))),
                              child: SvgPicture.asset(
                                "assets/bottomNavBarIcon/status.svg",
                                color: Color(0xffedfd00),
                              ),
                            ),
                            Text(
                              "스웨트빌리티 미친듯이 올리는 꿀팁",
                              style: TextStyle(fontSize: sx(20), fontWeight: FontWeight.w200),
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xffffb100), padding: EdgeInsets.all(0), minimumSize: Size(sx(50), sx(30))),
                                onPressed: () {
                                  Get.to(() => AbilityTips());
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: sx(50),
                                  height: sx(30),
                                  child: Text(
                                    "보기",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )));
    });
  }

  abilityDetail({required String ability, required double Function(double) sx}) {
    var svgPath = ability == "comu"
        ? "assets/StatusIcon/status_comunt.svg"
        : ability == "kkunkey"
            ? "assets/StatusIcon/status_patc.svg"
            : ability == "trybility"
                ? "assets/StatusIcon/status_efft.svg"
                : ability == "strength"
                    ? "assets/StatusIcon/status_strg.svg"
                    : ability == "honer"
                        ? "assets/StatusIcon/status_ownr.svg"
                        : "assets/StatusIcon/status_fashi.svg";
    var text = ability == "comu"
        ? "나의 소통 게이지는"
        : ability == "kkunkey"
            ? "나의 끈기 게이지는"
            : ability == "trybility"
                ? "나의 노력 게이지는"
                : ability == "strength"
                    ? "나의 강함 게이지는"
                    : ability == "honer"
                        ? "나의 명예 게이지는"
                        : "나의 열정 게이지는";
    var title;
    switch (ability) {
      case ("comu"):
        title = comuTitle[data[0][0] - 1];
        break;
      case ("kkunkey"):
        title = kkunKeyTitle[data[0][1] - 1];
        break;
      case ("trybility"):
        title = trybilityTitle[data[0][2] - 1];
        break;
      case ("strength"):
        title = strengthTitle[data[0][3] - 1];
        break;
      case ("honer"):
        title = honerTitle[data[0][4] - 1];
        break;
      case ("enthusiasm"):
        title = enthusiasmTitle[data[0][5] - 1];
        break;
      default:
    }
    return Container(
      padding: EdgeInsets.only(bottom: sx(35), left: sx(30), right: sx(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: sx(50),
                height: sx(50),
                decoration: BoxDecoration(color: Color(0xff326aff), borderRadius: BorderRadius.all(Radius.circular(10))),
                child: SvgPicture.asset(
                  svgPath,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: sx(20),
              ),
              Text(
                text,
                style: TextStyle(fontSize: sx(27), fontWeight: FontWeight.w700),
              ),
            ],
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.white, onPrimary: Color(0xff084bff), elevation: 1),
              onPressed: () {
                Get.dialog(AbilityDetail(
                  ability: ability,
                  data: data,
                ));
              },
              child: Text(
                title,
                style: TextStyle(fontSize: sx(27), fontWeight: FontWeight.w700, color: Color(0xff084bff)),
              ))
        ],
      ),
    );
  }
}
