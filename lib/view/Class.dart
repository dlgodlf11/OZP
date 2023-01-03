import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:sweatbox2dot0/Controller/ViewMainStateController.dart';

class ClassPage extends StatelessWidget {
  ScrollController classScrollController = new ScrollController();
  var viewMainStateController = Get.put(ViewMainStateController());
  ClassPage() {
    classScrollController.addListener(() {
      //print(homeScrollController.offset);

      if (classScrollController.position.userScrollDirection != ScrollDirection.forward) {
        viewMainStateController.showBars.value = false;
      } else {
        viewMainStateController.showBars.value = true;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
        body: Container(
          width: width,
          height: height,
          child: ListView(
            controller: classScrollController,
            children: [
              Container(
                width: width,
                height: width,
                color: Colors.blue,
              ),
              Container(
                padding: EdgeInsets.all(sx(25)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: sx(50),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("4주 손지무 트레이닝 캠프"),
                        SizedBox(
                          height: sx(20),
                        ),
                        Text("커넥션 코치 . 크로스핏 게임즈 최초 출전자")
                      ],
                    )
                  ],
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: EdgeInsets.all(sx(25)),
                    child: Column(
                      children: [
                        Text("레벨"),
                        SizedBox(
                          height: sx(20),
                        ),
                        Text("초급자")
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(sx(25)),
                    child: Column(
                      children: [
                        Text("레벨"),
                        SizedBox(
                          height: sx(20),
                        ),
                        Text("초급자")
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(sx(25)),
                    child: Column(
                      children: [
                        Text("레벨"),
                        SizedBox(
                          height: sx(20),
                        ),
                        Text("초급자")
                      ],
                    ),
                  )
                ],
              ),
              Divider(),
              Container(
                padding: EdgeInsets.all(sx(25)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("할인가격"),
                    Text("가격"),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: Container(
                          alignment: Alignment.center,
                          width: sx(150),
                          height: sx(70),
                          child: Text(
                            "결제하기",
                            style: TextStyle(color: Colors.white),
                          ),
                        ))
                  ],
                ),
              ),
              Container(
                height: sx(230),
                margin: EdgeInsets.only(left: sx(25), right: sx(25), bottom: sx(25)),
                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(30))),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: sx(25)),
                child: Text(
                  "강의소개",
                  style: TextStyle(fontSize: sx(30)),
                ),
              ),
              SizedBox(
                height: sx(25),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: sx(25)),
                child: Text(
                  "강의소개에 대한 내용입니다. 폰트는 Apple SD 산돌고딕NEO로 Medium으로 40pt로 지정해주시기 바랍니다. 컬러는 #535353입니다. 3-4줄가량으로 000자로 입력해서 기획하는 것을 권장합니다. 최소 100자 최대 140자 가량으로 맞춰주세요.",
                  style: TextStyle(fontSize: sx(20), height: 1.5),
                ),
              ),
              SizedBox(
                height: sx(30),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: sx(25)),
                child: Text(
                  "커리큘럼",
                  style: TextStyle(fontSize: sx(30)),
                ),
              ),
              SizedBox(
                height: sx(25),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: sx(25)),
                child: Text(
                  "챕터1\n챕터2\n챕터3",
                  style: TextStyle(fontSize: sx(20), height: 1.5),
                ),
              ),
              SizedBox(
                height: sx(30),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: sx(25)),
                child: Text(
                  "준비물",
                  style: TextStyle(fontSize: sx(30)),
                ),
              ),
              SizedBox(
                height: sx(25),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: sx(25)),
                child: Text(
                  "준비물1\n분비물2\n준비물3",
                  style: TextStyle(fontSize: sx(20), height: 1.5),
                ),
              ),
              SizedBox(
                height: sx(30),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: sx(25)),
                child: Text(
                  "강의를 듣고 이렇게 변합니다.",
                  style: TextStyle(fontSize: sx(30)),
                ),
              ),
              SizedBox(
                height: sx(25),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: sx(25)),
                child: Text(
                  "골다공증\n관절염\n족저근막염",
                  style: TextStyle(fontSize: sx(20), height: 1.5),
                ),
              ),
              SizedBox(
                height: sx(30),
              ),
            ],
          ),
        ),
      );
    });
  }
}
