import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:sweatbox2dot0/Controller/UserDataController.dart';
import 'package:sweatbox2dot0/Controller/ViewMainStateController.dart';
import 'package:sweatbox2dot0/Services/database.dart';
import 'package:characters/characters.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

// ignore: must_be_immutable
class PhysicalData extends StatelessWidget {
  var viewMainStateController = Get.put(ViewMainStateController());
  var scaffoldScrollController = new ScrollController();
  RxString boxString = "".obs;
  TextEditingController nickNameText = new TextEditingController();
  TextEditingController weightText = new TextEditingController();
  TextEditingController tallText = new TextEditingController();
  RxString profileImage = "".obs;
  RxDouble viewInsets = 0.0.obs;
  var userData = Get.put(UserController());

  RxBool isMan = true.obs;
  List<dynamic>? boxes;
  RxList searchList = [].obs;
  PhysicalData() {
    Database().getBoxList().then((value) {
      boxes = value;
    });
    viewMainStateController.showBars.value = false;
    nickNameText.text = userData.user.value.nickName == null ? "" : userData.user.value.nickName!;
    boxString.value = userData.user.value.box == null ? "" : userData.user.value.box!;
    weightText.text = userData.user.value.weight == null ? "" : userData.user.value.weight!.toString();
    tallText.text = userData.user.value.tall == null ? "" : userData.user.value.tall!.toString();
    nickNameText.text = userData.user.value.nickName == null ? "" : userData.user.value.nickName!;
    profileImage.value = userData.user.value.profileImage == null ? "" : userData.user.value.profileImage!;
    viewInsets.addListener(GetStream(onListen: () {
      SystemChrome.setEnabledSystemUIOverlays([]);
    }));
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: GestureDetector(onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          SystemChrome.setEnabledSystemUIOverlays([]);
          viewInsets.value = MediaQuery.of(context).viewInsets.bottom;
        }, child: RelativeBuilder(builder: (context, height, width, sy, sx) {
          return Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              appBar: AppBar(title: Text("피지컬 데이터"), backgroundColor: Colors.white, elevation: 0, automaticallyImplyLeading: false),
              body: SingleChildScrollView(
                controller: scaffoldScrollController,
                child: Container(
                  padding: EdgeInsets.all(sx(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: sx(100),
                        height: sx(100),
                        child: Stack(
                          children: [
                            Obx(
                              () => Container(
                                width: sx(100),
                                height: sx(100),
                                decoration: BoxDecoration(
                                    color: profileImage.value == "" ? Colors.blue : Colors.black,
                                    // image:DecorationImage(image: ),
                                    image: profileImage.value == ""
                                        ? null
                                        : !profileImage.value.contains("gs://moti")
                                            ? DecorationImage(image: FileImage(File(profileImage.value)))
                                            : DecorationImage(image: FirebaseImage(profileImage.value)),
                                    borderRadius: BorderRadius.all(Radius.circular(900))),
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () async {
                                    await AssetPicker.pickAssets(context, maxAssets: 1, gridCount: 4).then((value) {
                                      print(value);
                                      if (value == null) {
                                        return;
                                      }
                                      const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
                                      Random _rnd = Random();
                                      var aa = 0;
                                      value.forEach((element) async {
                                        await element.file.then((filedata) async {
                                          Directory tempDir = await getTemporaryDirectory();
                                          String tempPath = tempDir.path;

                                          await FlutterImageCompress.compressAndGetFile(
                                                  filedata!.path,
                                                  tempPath +
                                                      String.fromCharCodes(
                                                          Iterable.generate(5, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)))) +
                                                      ".jpg",
                                                  quality: 30,
                                                  format: CompressFormat.jpeg)
                                              .then((downsizefile) {
                                            aa++;

                                            profileImage.value = downsizefile!.path;
                                            print(profileImage);
                                          });
                                        });
                                      });
                                    });
                                  },
                                  child: CircleAvatar(
                                    radius: sx(20),
                                    backgroundColor: Colors.red,
                                  ),
                                ))
                          ],
                        ),
                      ),
                      nickNameField(sx),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [tallField(sx), weightField(sx)],
                      ),
                      genderField(sx),
                      boxSearchField(sx)
                    ],
                  ),
                ),
              ),
              bottomSheet: Obx(() => boxString.value != "" && nickNameText.text != "" && tallText.text != "" && weightText.text != ""
                  ? InkWell(
                      onTap: () {
                        Database()
                            .updatePhysicalData(
                                nickName: nickNameText.text,
                                tall: tallText.text,
                                weight: weightText.text,
                                box: boxString.value,
                                image: profileImage.value,
                                gender: isMan.value ? 1 : 0)
                            .then((value) => Get.back());
                      },
                      child: Container(
                        margin: EdgeInsets.all(sx(20)),
                        width: width,
                        height: sx(90),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: Color(0xff0046ff), borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          "시작하기",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: sx(20)),
                        ),
                      ),
                    )
                  : SizedBox()));
        })),
        onWillPop: () async => false);
  }

  genderField(double Function(double) sx) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Obx(() => InkWell(
              onTap: () {
                isMan.value = true;
              },
              child: Container(
                height: sx(80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "여자",
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
                      child: CircleAvatar(radius: sx(10), backgroundColor: isMan.value ? Color(0xff0046ff) : Colors.white),
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
                isMan.value = false;
              },
              child: Container(
                height: sx(80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "남자",
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
                      child: CircleAvatar(radius: sx(10), backgroundColor: !isMan.value ? Color(0xff0046ff) : Colors.white),
                    )
                  ],
                ),
              ),
            )),
      ],
    );
  }

  weightField(double Function(double) sx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("몸무게"),
        Container(
          alignment: Alignment.center,
          width: sx(220),
          height: sx(100),
          child: TextField(
            controller: weightText,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: sx(20)),
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Color(0xffb4b4b4))),
                isDense: true,
                filled: true,
                fillColor: Color(0xfff7f7f7),
                errorStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Colors.red)),
                counterStyle: TextStyle(color: Colors.black),
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
        ),
      ],
    );
  }

  boxSearchField(double Function(double) sx) {
    return Obx(() => boxString.value != ""
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("소속박스"),
              InkWell(
                onTap: () {
                  boxString.value = "";
                },
                child: Container(
                  alignment: Alignment.center,
                  width: sx(500),
                  height: sx(100),
                  child: TextField(
                    //keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: sx(20)),

                    enabled: false,
                    controller: TextEditingController(text: boxString.value),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Color(0xffb4b4b4))),
                        isDense: true,
                        filled: true,
                        fillColor: Color(0xfff7f7f7),
                        errorStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Colors.red)),
                        counterStyle: TextStyle(color: Colors.black),
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
                ),
              )
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("소속박스"),
              Container(
                alignment: Alignment.center,
                width: sx(500),
                height: sx(100),
                child: TextField(
                  maxLength: 12,
                  onChanged: (text) {
                    searchList.clear();
                    // print(result2);
                    if (Database().isKorean(text: text)) {
                      var covText = Database().checkKoreanString(text: text);

                      boxes!.forEach((box) {
                        var covBox = Database().checkKoreanString(text: box["이름"].replaceAll(" ", "").replaceAll("크로스핏", ""));
                        var similar = true;
                        for (int i = 0; i < covText.length; i++) {
                          try {
                            if (covText[i][0] != 0 && covText[i][1] == 0 && covText[i][2] == 0) {
                              if (covBox[i][0] != covText[i][0]) {
                                similar = false;
                              }
                            } else {
                              if (covBox[i][0] == covText[i][0] && covBox[i][1] == covText[i][1] && covBox[i][2] == covText[i][2]) {
                                //similar = true;
                              } else {
                                similar = false;
                              }
                            }
                          } catch (e) {
                            similar = false;
                          }
                        }
                        if (similar) {
                          searchList.value.add(box);
                        }
                      });
                    } else {
                      searchList.value = boxes!.where((element) => element["이름"].toLowerCase().contains(text.toLowerCase())).toList();
                    }
                  },
                  //keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: sx(20)),
                  onTap: () {
                    Future.delayed(Duration(milliseconds: 500)).then((value) {
                      scaffoldScrollController.animateTo(scaffoldScrollController.position.maxScrollExtent - sx(70),
                          duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
                    });
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Color(0xffb4b4b4))),
                      isDense: true,
                      filled: true,
                      fillColor: Color(0xfff7f7f7),
                      errorStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Colors.red)),
                      counterStyle: TextStyle(color: Colors.black),
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
              ),
              Obx(() => Container(
                    width: sx(500),
                    height: sx(400),
                    child: ListView.builder(
                        itemCount: searchList.value.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              boxString.value = searchList.value[index]["이름"];
                              FocusScope.of(context).requestFocus(FocusNode());
                              SystemChrome.setEnabledSystemUIOverlays([]);
                            },
                            child: Container(
                              padding: EdgeInsets.all(sx(10)),
                              width: sx(500),
                              height: sx(85),
                              decoration: BoxDecoration(border: Border.all(width: 0.1)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(searchList.value[index]["이름"]),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: sx(500),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(searchList.value[index]["주소"]),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ))
            ],
          ));
  }

  tallField(double Function(double) sx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("키"),
        Container(
          alignment: Alignment.center,
          width: sx(220),
          height: sx(100),
          child: TextField(
            controller: tallText,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: sx(20)),
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Color(0xffb4b4b4))),
                isDense: true,
                filled: true,
                fillColor: Color(0xfff7f7f7),
                errorStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Colors.red)),
                counterStyle: TextStyle(color: Colors.black),
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
        ),
      ],
    );
  }

  nickNameField(double Function(double) sx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("닉네임"),
        Container(
          alignment: Alignment.center,
          width: sx(500),
          height: sx(100),
          child: TextField(
            maxLength: 12,
            controller: nickNameText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: sx(20)),
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Color(0xffb4b4b4))),
                isDense: true,
                filled: true,
                fillColor: Color(0xfff7f7f7),
                errorStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Colors.red)),
                counterStyle: TextStyle(color: Colors.black),
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
        ),
      ],
    );
  }
}
