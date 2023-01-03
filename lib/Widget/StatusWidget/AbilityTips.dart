import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:relative_scale/relative_scale.dart';

class AbilityTips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
          appBar: AppBar(
            title: Text("스웨트빌리티 올리는 팁"),
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: SvgPicture.asset('assets/appbarIcon/btn_back.svg'),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: width,
              padding: EdgeInsets.only(top: sx(30)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  tipCard(
                      title: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          style: TextStyle(
                              color: const Color(0xff707070), fontWeight: FontWeight.w800, fontStyle: FontStyle.normal, fontSize: sx(30)),
                          text: "소통 게이지는\n",
                        ),
                        TextSpan(
                            style: TextStyle(
                                color: const Color(0xff084bff), fontWeight: FontWeight.w800, fontStyle: FontStyle.normal, fontSize: sx(30)),
                            text: "커뮤니티"),
                        TextSpan(
                          style: TextStyle(
                              color: const Color(0xff707070), fontWeight: FontWeight.w800, fontStyle: FontStyle.normal, fontSize: sx(30)),
                          text: "에서 올려보세요!",
                        ),
                      ])),
                      subTitle: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          style: TextStyle(
                              color: const Color(0xff707070), fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: sx(25)),
                          text: ". 댓글은 롸잇 나우!\n",
                        ),
                        TextSpan(
                          style: TextStyle(
                              color: const Color(0xff707070), fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: sx(25)),
                          text: ". 좋아요와 같은 ",
                        ),
                        TextSpan(
                            style: TextStyle(
                                color: const Color(0xff084bff), fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: sx(25)),
                            text: "드랍"),
                        TextSpan(
                          style: TextStyle(
                              color: const Color(0xff707070), fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: sx(25)),
                          text: "을 꾹!",
                        ),
                      ])),
                      tags: ["마이웨이", "눈팅족", "소통의신"],
                      sx: sx,
                      ability: "comu"),
                  SizedBox(
                    height: sx(40),
                  ),
                  tipCard(
                      title: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          style: TextStyle(
                              color: const Color(0xff707070), fontWeight: FontWeight.w800, fontStyle: FontStyle.normal, fontSize: sx(30)),
                          text: "나의 끈기 게이지는 \n",
                        ),
                        TextSpan(
                            style: TextStyle(
                                color: const Color(0xff084bff), fontWeight: FontWeight.w800, fontStyle: FontStyle.normal, fontSize: sx(30)),
                            text: "다이어리"),
                        TextSpan(
                          style: TextStyle(
                              color: const Color(0xff707070), fontWeight: FontWeight.w800, fontStyle: FontStyle.normal, fontSize: sx(30)),
                          text: "와 ",
                        ),
                        TextSpan(
                            style: TextStyle(
                                color: const Color(0xff084bff), fontWeight: FontWeight.w800, fontStyle: FontStyle.normal, fontSize: sx(30)),
                            text: "PR"),
                        TextSpan(
                          style: TextStyle(
                              color: const Color(0xff707070), fontWeight: FontWeight.w800, fontStyle: FontStyle.normal, fontSize: sx(30)),
                          text: "에서!",
                        ),
                      ])),
                      subTitle: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          style: TextStyle(
                              color: const Color(0xff707070), fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: sx(25)),
                          text: ". 매일 와드를 착실히 ",
                        ),
                        TextSpan(
                            style: TextStyle(
                                color: const Color(0xff084bff), fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: sx(25)),
                            text: "다이어리!\n"),
                        TextSpan(
                          style: TextStyle(
                              color: const Color(0xff707070), fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: sx(25)),
                          text: ". 종목별로 알 수 있는 ",
                        ),
                        TextSpan(
                            style: TextStyle(
                                color: const Color(0xff084bff), fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: sx(25)),
                            text: "퍼스널 레코드!\n"),
                      ])),
                      tags: [
                        "다이어리",
                        "스웨트 랭커",
                      ],
                      sx: sx,
                      ability: "kkunkey"),
                  SizedBox(
                    height: sx(40),
                  ),
                  tipCard(
                      title: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          style: TextStyle(
                              color: const Color(0xff707070), fontWeight: FontWeight.w800, fontStyle: FontStyle.normal, fontSize: sx(30)),
                          text: "나이 노력 게이지는 \n",
                        ),
                        TextSpan(
                            style: TextStyle(
                                color: const Color(0xff084bff), fontWeight: FontWeight.w800, fontStyle: FontStyle.normal, fontSize: sx(30)),
                            text: "다채로운"),
                        TextSpan(
                          style: TextStyle(
                              color: const Color(0xff707070), fontWeight: FontWeight.w800, fontStyle: FontStyle.normal, fontSize: sx(30)),
                          text: "느낌!",
                        ),
                      ])),
                      subTitle: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          style: TextStyle(
                              color: const Color(0xff707070), fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: sx(25)),
                          text: ". 끝없이 도전할 수 있는 ",
                        ),
                        TextSpan(
                            style: TextStyle(
                                color: const Color(0xff084bff), fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: sx(25)),
                            text: "랜덤와드\n"),
                        TextSpan(
                          style: TextStyle(
                              color: const Color(0xff707070), fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: sx(25)),
                          text: ". 와드할 때 필수적인 ",
                        ),
                        TextSpan(
                            style: TextStyle(
                                color: const Color(0xff084bff), fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: sx(25)),
                            text: "와드 타이머\n"),
                        TextSpan(
                          style: TextStyle(
                              color: const Color(0xff707070), fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: sx(25)),
                          text: ". 영상으로 증명하는 ",
                        ),
                        TextSpan(
                            style: TextStyle(
                                color: const Color(0xff084bff), fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: sx(25)),
                            text: "스웨트 레코드\n"),
                        TextSpan(
                          style: TextStyle(
                              color: const Color(0xff707070), fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: sx(25)),
                          text: ". 나의 한계를 측정하는 ",
                        ),
                        TextSpan(
                            style: TextStyle(
                                color: const Color(0xff084bff), fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: sx(25)),
                            text: "RM Pad\n"),
                      ])),
                      tags: ["와드", "타이머키고 와드", "와드무비"],
                      sx: sx,
                      ability: "trybility"),
                  SizedBox(
                    height: sx(40),
                  ),
                  tipCard(
                      title: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          style: TextStyle(
                              color: const Color(0xff707070), fontWeight: FontWeight.w800, fontStyle: FontStyle.normal, fontSize: sx(30)),
                          text: "나의 강함 게이지는\n스웨트 랭커 ",
                        ),
                        TextSpan(
                            style: TextStyle(
                                color: const Color(0xff084bff), fontWeight: FontWeight.w800, fontStyle: FontStyle.normal, fontSize: sx(30)),
                            text: "탈환!"),
                      ])),
                      subTitle: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          style: TextStyle(
                              color: const Color(0xff707070), fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: sx(25)),
                          text: ". 퍼스널 레코드에서 종목을 골고루!\n",
                        ),
                        TextSpan(
                          style: TextStyle(
                              color: const Color(0xff707070), fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: sx(25)),
                          text: ". 좋아요와 같은 ",
                        ),
                      ])),
                      tags: ["무게등록", "랩스등록"],
                      sx: sx,
                      ability: "strength"),
                  SizedBox(
                    height: sx(40),
                  )
                ],
              ),
            ),
          ));
    });
  }

  tipCard(
      {required Widget title,
      required Widget subTitle,
      required List<String> tags,
      required double Function(double) sx,
      required String ability}) {
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

    RxBool showAll = false.obs;
    return Obx(() => AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          width: sx(450),
          height: showAll.value ? sx(450) : sx(200),
          padding: EdgeInsets.all(sx(20)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                height: sx(400),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            Obx(() => InkWell(
                                  onTap: () {
                                    showAll.value = !showAll.value;
                                  },
                                  child: AnimatedContainer(
                                      duration: Duration(milliseconds: 500),
                                      width: sx(40),
                                      height: sx(40),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: !showAll.value ? Color(0xfff7f7f7) : Color(0xffd6e4ff),
                                          borderRadius: BorderRadius.all(Radius.circular(900))),
                                      child: RotatedBox(
                                        quarterTurns: !showAll.value ? 0 : 2,
                                        child: SvgPicture.asset(
                                          'assets/StatusIcon/drawer.svg',
                                          color: !showAll.value ? Color(0xffb9b9b9) : Color(0xff084bff),
                                        ),
                                      )),
                                ))
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(top: sx(30)),
                          child: title,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: sx(30)),
                          child: subTitle,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        for (int i = 0; i < tags.length; i++)
                          Text(
                            "  #${tags[i]}",
                            style: TextStyle(color: const Color(0xff707070), fontWeight: FontWeight.w100, fontSize: sx(25)),
                          )
                      ],
                    )
                  ],
                ),
              )),
        ));
  }
}
