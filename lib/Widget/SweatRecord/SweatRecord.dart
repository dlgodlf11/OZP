import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:sweatbox2dot0/Widget/SweatRecord/SweatRecordCamera.dart';

class SweatRecord extends StatelessWidget {
  TextEditingController firstTextController = new TextEditingController(text: "3");
  TextEditingController secondTextController = new TextEditingController(text: "0");
  TextEditingController nameTextController = new TextEditingController(text: "비어있다");
  TextEditingController wodTitleTextController = new TextEditingController(text: "비어있다.");
  RxBool isUp = false.obs;
  RxBool isCount = false.obs;
  RxBool viewHorizontal = false.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTapDown: (value) {
      FocusScope.of(context).requestFocus(FocusNode());
      SystemChrome.setEnabledSystemUIOverlays([]);
    }, child: RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Container(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Text("이름"),
                Container(
                  width: width,
                  height: sx(70),
                  child: TextField(
                    textAlign: TextAlign.left,
                    maxLength: 100,
                    maxLines: null,
                    controller: nameTextController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Color(0xffb4b4b4))),
                        filled: true,
                        counterText: "",
                        isDense: true,
                        fillColor: Colors.grey[200],
                        errorStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Colors.red)),
                        labelText: "증명해낼 자신의 이름 작성",
                        hintStyle: TextStyle(
                            color: Color(0xffb4b4b4),
                            fontWeight: FontWeight.w300,
                            fontFamily: "AppleSDGothicNeo",
                            fontStyle: FontStyle.normal,
                            fontSize: sx(15)),
                        labelStyle:
                            TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal, fontSize: sx(20))),
                  ),
                ),
                Text("와드 타이틀"),
                Container(
                  width: width,
                  height: sx(70),
                  child: TextField(
                    textAlign: TextAlign.left,
                    maxLength: 100,
                    maxLines: null,
                    controller: wodTitleTextController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Color(0xffb4b4b4))),
                        filled: true,
                        counterText: "",
                        isDense: true,
                        fillColor: Colors.grey[200],
                        errorStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Colors.red)),
                        labelText: "극복해야할 미션 작성",
                        hintStyle: TextStyle(
                            color: Color(0xffb4b4b4),
                            fontWeight: FontWeight.w300,
                            fontFamily: "AppleSDGothicNeo",
                            fontStyle: FontStyle.normal,
                            fontSize: sx(15)),
                        labelStyle:
                            TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal, fontSize: sx(20))),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "TIME CAP",
                      style: TextStyle(
                        color: Color(0xff707070),
                        fontSize: sx(25),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      children: [
                        textField(controller: firstTextController, sx: sx),
                        Text(
                          "분",
                          style: TextStyle(
                            color: Color(0xff707070),
                            fontSize: sx(25),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          width: sx(15),
                        ),
                        textField(controller: secondTextController, sx: sx),
                        Text(
                          "초",
                          style: TextStyle(
                            color: Color(0xff707070),
                            fontSize: sx(25),
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                checkBox(value: isUp, sx: sx, opthion1: "Up", opthion2: "Down", settingTitle: "타이머"),
                checkBox(value: isCount, sx: sx, opthion1: "예", opthion2: "아니오", settingTitle: "카운트다운"),
                checkBox(value: viewHorizontal, sx: sx, opthion1: "가로", opthion2: "세로", settingTitle: "MODE"),
              ],
            ),
          )),
          bottomSheet: Container(
            margin: EdgeInsets.all(sx(25)),
            child: ElevatedButton(
              onPressed: () {
                print(isUp.value);
                print(secondTextController.text);
                Get.to(() => SweatRecordCamera(
                    timeCap: (int.parse(firstTextController.text) * 60) + int.parse(secondTextController.text),
                    isUp: isUp,
                    doingCount: isCount,
                    name: nameTextController.text,
                    wodTitle: wodTitleTextController.text,
                    viewhorizontal: viewHorizontal));
              },
              child: Container(
                height: sx(80),
                alignment: Alignment.center,
                child: Text("작성끝"),
              ),
            ),
          ));
    }));
  }

  textField({required controller, required double Function(double) sx}) {
    return Container(
      width: sx(100),
      height: sx(50),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: controller,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: sx(20)),
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Color(0xffb4b4b4))),
            isDense: true,
            filled: true,
            fillColor: Color(0xffe2eaff),
            focusColor: Color(0xffe2eaff),
            focusedBorder: InputBorder.none,
            errorStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Colors.red)),
            hintStyle: TextStyle(
                color: Color(0xffb4b4b4),
                fontWeight: FontWeight.w300,
                fontFamily: "AppleSDGothicNeo",
                fontStyle: FontStyle.normal,
                fontSize: sx(20)),
            labelStyle: TextStyle(
                color: Color(0xffb4b4b4),
                fontWeight: FontWeight.w300,
                fontFamily: "AppleSDGothicNeo",
                fontStyle: FontStyle.normal,
                fontSize: sx(20))),
      ),
    );
  }

  checkBox(
      {required value,
      required double Function(double) sx,
      required String opthion1,
      required String opthion2,
      required String settingTitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          settingTitle,
          style: TextStyle(
            fontSize: sx(22),
            fontWeight: FontWeight.w700,
            color: Color(0xff707070),
          ),
        ),
        Row(
          children: [
            Obx(() => InkWell(
                  onTap: () {
                    value.value = true;
                  },
                  child: Container(
                    height: sx(80),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          opthion1,
                          style: TextStyle(
                            fontSize: sx(22),
                            fontWeight: FontWeight.normal,
                            color: Color(0xff707070),
                          ),
                        ),
                        SizedBox(
                          width: sx(20),
                        ),
                        Container(
                          width: sx(44),
                          height: sx(44),
                          padding: EdgeInsets.all(sx(5)),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xff0046ff), width: 3),
                              borderRadius: BorderRadius.all(
                                Radius.circular(300),
                              )),
                          child: CircleAvatar(radius: sx(10), backgroundColor: value.value ? Color(0xff0046ff) : Colors.white),
                        )
                      ],
                    ),
                  ),
                )),
            SizedBox(
              width: sx(40),
            ),
            Obx(() => InkWell(
                  onTap: () {
                    value.value = false;
                  },
                  child: Container(
                    height: sx(80),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          opthion2,
                          style: TextStyle(
                            fontSize: sx(22),
                            fontWeight: FontWeight.normal,
                            color: Color(0xff707070),
                          ),
                        ),
                        SizedBox(
                          width: sx(20),
                        ),
                        Container(
                          width: sx(44),
                          height: sx(44),
                          padding: EdgeInsets.all(sx(5)),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xff0046ff), width: 3),
                              borderRadius: BorderRadius.all(
                                Radius.circular(300),
                              )),
                          child: CircleAvatar(radius: sx(10), backgroundColor: !value.value ? Color(0xff0046ff) : Colors.white),
                        )
                      ],
                    ),
                  ),
                )),
          ],
        )
      ],
    );
  }
}
