import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:sweatbox2dot0/Controller/UserDataController.dart';
import 'package:sweatbox2dot0/Services/database.dart';
import 'package:sweatbox2dot0/Widget/StatusWidget/DiaryPickWoeCategory.dart';

class DiaryEdit extends StatelessWidget {
  UserController userData = Get.put(UserController());
  var scaffoldScrollController = new ScrollController();

  TextEditingController diaryText = TextEditingController();
  Rx<DateTime> selectedDateTime = DateTime.now().obs;

  RxList<dynamic> pickList = [
    // {
    //   "type": "weight / reps / time",
    //   "content": "Barbell Behind Shoulder Press",
    //   "round": [
    //     {"lb": 0.0, "reps": 0.0, "time": 0.0},
    //     {"lb": 0.0, "reps": 0.0}
    //   ].obs
    // }
  ].obs;
  RxString simpleComment = "".obs;
  RxBool showRestButton = true.obs;
  var diaryData = null;
  DiaryEdit({this.diaryData, required this.selectedDateTime}) {
    if (userData.user.value.diary.indexWhere((element) => element["date"].contains(selectedDateTime.value.toString().split(" ")[0])) !=
        -1) {
      if (userData.user.value.diary
              .where((element) => element["date"].contains(selectedDateTime.value.toString().split(" ")[0]))
              .toList()
              .indexWhere((element) => element["category"] == "rest") ==
          -1) {
        showRestButton.value = false;
      } else {
        print("오잉");
        showRestButton.value = true;
      }
    } else {
      print("오잉");

      showRestButton.value = true;
    }

    if (diaryData != null) {
      //print(diaryData);
      var temp = diaryData["category"].toList();
      for (int i = 0; i < temp.length; i++) {
        temp[i]["round"] = new RxList(diaryData["category"][i]["round"]);
      }
      pickList.value = temp;
      var aa = [1, 2, 3, 1, 2, 3];
      diaryText.text = diaryData["text"];
      simpleComment.value = diaryData["simplecomment"];
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTapDown: (value) {
      FocusScope.of(context).requestFocus(FocusNode());
      SystemChrome.setEnabledSystemUIOverlays([]);
    }, child: RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("다이어리"),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.dialog(diaryDialog(
                  sy: sy,
                  sx: sx,
                  width: width,
                  height: height,
                  title: "다이어리 종료",
                  text: "편집중에는 저장되지 않습니다.\n작성을 종료하시나요?",
                  cancel: () {
                    Get.back();
                    Get.back();
                  },
                  ok: () {
                    Get.back();
                  },
                  cancelText: "종료",
                  okText: "계속작성"));
              //Get.back();
            },
            icon: SvgPicture.asset('assets/appbarIcon/btn_back.svg'),
          ),
        ),
        body: SingleChildScrollView(
          controller: scaffoldScrollController,
          child: Container(
            padding: EdgeInsets.only(left: sx(30), right: sx(30), top: sx(30), bottom: sx(190)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                categoryPickerField(sx: sx, width: width),
                SizedBox(
                  height: sx(30),
                ),
                categoryDetailEdit(sx: sx, width: width),
                SizedBox(
                  height: sx(30),
                ),
                // simpleCommentField(sx: sx, width: width),
                SizedBox(
                  height: sx(30),
                ),
                diaryTextField(sx: sx, width: width),
                SizedBox(
                  height: sx(30),
                ),
                Obx(() => showRestButton.value
                    ? Container(
                        width: width,
                        child: TextButton(
                            onPressed: () {
                              Get.dialog(diaryDialog(
                                  sy: sy,
                                  sx: sx,
                                  width: width,
                                  height: height,
                                  title: "오늘은 쉬는날",
                                  text: "내일의 성장을 위해 잠시 쉴 수\n있는 것도 좋습니다.",
                                  cancel: () {
                                    Get.back();
                                  },
                                  ok: () {
                                    var diary = {
                                      "date": selectedDateTime.value.toString(),
                                      "category": "Rest",
                                      "simplecomment": "Rest",
                                      "text": "Rest"
                                    };
                                    Database().addRestDiary(diaryData: diary);
                                    Get.back();
                                    Get.back();
                                  },
                                  okText: "푹 쉬기"));
                            },
                            child: Text(
                              "오늘은 쉬는날인가요?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color(0xff0046ff),
                                  fontSize: sx(35),
                                  fontWeight: FontWeight.w600),
                            )),
                      )
                    : Container())
              ],
            ),
          ),
        ),
        bottomSheet: InkWell(
          onTap: () {
            if (pickList.length != 0) {
              Get.dialog(diaryDialog(
                  sy: sy,
                  sx: sx,
                  width: width,
                  height: height,
                  title: "다이어리 완료",
                  text: "당신이 성장한 역사적인 순간운\n더 발전된 모습으로 나타날 겁니다!",
                  okText: "완료",
                  cancel: () {
                    Get.back();
                  },
                  ok: () {
                    Get.bottomSheet(simpleCommentBottomSheet(sx: sx, width: width)).then((value) {
                      simpleComment.value = value;
                      if (diaryData == null) {
                        var diary = {
                          "date": selectedDateTime.value.toString(),
                          "category": pickList,
                          "simplecomment": simpleComment.value,
                          "text": diaryText.text
                        };

                        Database()
                            .addDiary(
                              diaryData: diary,
                            )
                            .then((value) => Get.back());
                        print(diary);
                      } else {
                        var diary = diaryData;
                        diary["category"] = pickList;
                        diary["simplecomment"] = simpleComment.value;
                        diary["text"] = diaryText.text;
                        Database().updateDiary(beforeDiaryData: diaryData, afterDiaryData: diary);
                      }
                      Get.back();
                      Get.back();
                    });
                  }));
            }
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            margin: EdgeInsets.all(sx(20)),
            width: width,
            height: sx(90),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: pickList.length == 0 ? Colors.grey : Color(0xff0046ff), borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Text(
              "작성끝",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: sx(20)),
            ),
          ),
        ),
      );
    }));
  }

  categoryPickerField({required double Function(double) sx, required width}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "종목 입력",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: sx(25)),
        ),
        SizedBox(
          height: sx(20),
        ),
        InkWell(
          onTap: () {
            Get.to(() => PickCategory(
                      picklist: pickList,
                    ))!
                .then((value) {
              pickList = value;
              print(value);
              if (pickList.value.length != 0)
                showRestButton.value = false;
              else
                showRestButton.value = true;
              print(showRestButton);
              SystemChrome.setEnabledSystemUIOverlays([]);
            });
          },
          child: Container(
            width: double.infinity,
            height: sx(70),
            padding: EdgeInsets.only(left: sx(20)),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(color: Color(0xfff7f7f7), borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Text(
              "오늘 끝낸 종목을 찾아보세요!",
              style: TextStyle(
                fontSize: sx(20),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // simpleCommentField({required double Function(double) sx, required width}) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         "초간단 한줄평",
  //         style: TextStyle(fontWeight: FontWeight.w600, fontSize: sx(25)),
  //       ),
  //       SizedBox(
  //         height: sx(20),
  //       ),
  //       InkWell(
  //         onTap: () {
  //           Get.bottomSheet(simpleCommentBottomSheet(sx: sx, width: width)).then((value) {
  //             simpleComment.value = value;
  //           });
  //         },
  //         child: Container(
  //             width: double.infinity,
  //             height: sx(70),
  //             padding: EdgeInsets.only(left: sx(20)),
  //             alignment: Alignment.centerLeft,
  //             decoration: BoxDecoration(color: Color(0xfff7f7f7), borderRadius: BorderRadius.all(Radius.circular(10))),
  //             child: Obx(
  //               () => Text(
  //                 simpleComment.value == "" ? "간단한 심정을 선택해보세요!" : simpleComment.value,
  //                 style: TextStyle(
  //                   fontSize: sx(20),
  //                   fontWeight: FontWeight.w800,
  //                 ),
  //               ),
  //             )),
  //       ),
  //     ],
  //   );
  // }

  diaryTextField({required double Function(double) sx, required width}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "다이어리 쓰기",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: sx(25)),
        ),
        SizedBox(
          height: sx(20),
        ),
        TextField(
          maxLength: 300,
          maxLines: null,
          textAlign: TextAlign.left,
          controller: diaryText,
          onTap: () {
            Future.delayed(Duration(milliseconds: 500)).then((value) {
              scaffoldScrollController.animateTo(scaffoldScrollController.position.maxScrollExtent - sx(70),
                  duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
            });
          },
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Color(0xffb4b4b4))),
              isDense: true,
              fillColor: Color(0xfff7f7f7),
              filled: true,
              errorStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Colors.red)),
              labelText: "오늘 변화된 역사적인 순간을 기록해요!",
              hintStyle: TextStyle(
                  color: Color(0xffb4b4b4),
                  fontWeight: FontWeight.w300,
                  fontFamily: "AppleSDGothicNeo",
                  fontStyle: FontStyle.normal,
                  fontSize: sx(15)),
              labelStyle: TextStyle(
                  color: Color(0xffb4b4b4),
                  fontWeight: FontWeight.w300,
                  fontFamily: "AppleSDGothicNeo",
                  fontStyle: FontStyle.normal,
                  fontSize: sx(15))),
        ),
      ],
    );
  }

  categoryDetailEdit({required double Function(double) sx, required width}) {
    return Obx(() => Container(
          width: width,
          constraints: BoxConstraints(maxHeight: sx(800)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (int index = 0; index < pickList.value.length; index++)
                  Container(
                      width: width,
                      child: Obx(() => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pickList.value[index]["content"],
                                style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xff707070), fontSize: sx(30)),
                                textAlign: TextAlign.start,
                              ),
                              Obx(() => pickList.value.length != 0
                                  ? Column(
                                      children: [
                                        for (int roundindex = 0; roundindex < pickList.value[index]["round"].value.length; roundindex++)
                                          Container(
                                            width: width,
                                            padding: EdgeInsets.only(bottom: sx(20)),
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: FittedBox(
                                                    alignment: Alignment.centerLeft,
                                                    fit: BoxFit.scaleDown,
                                                    child: Row(
                                                      children: [
                                                        for (int keyindex = 0;
                                                            keyindex < pickList.value[index]["round"][roundindex].keys.length;
                                                            keyindex++)
                                                          pickList.value[index]["round"][roundindex].keys.toList()[keyindex] == "lb"
                                                              ? roundItem(index: index, sx: sx, roundindex: roundindex, keyindex: keyindex)
                                                              : pickList.value[index]["round"][roundindex].keys.toList()[keyindex] == "kg"
                                                                  ? roundItem(
                                                                      index: index, sx: sx, roundindex: roundindex, keyindex: keyindex)
                                                                  : pickList.value[index]["round"][roundindex].keys.toList()[keyindex] ==
                                                                          "reps"
                                                                      ? roundItem(
                                                                          index: index, sx: sx, roundindex: roundindex, keyindex: keyindex)
                                                                      : pickList.value[index]["round"][roundindex].keys
                                                                                  .toList()[keyindex] ==
                                                                              "kcal"
                                                                          ? roundItem(
                                                                              index: index,
                                                                              sx: sx,
                                                                              roundindex: roundindex,
                                                                              keyindex: keyindex)
                                                                          : pickList.value[index]["round"][roundindex].keys
                                                                                      .toList()[keyindex] ==
                                                                                  "meter"
                                                                              ? roundItem(
                                                                                  index: index,
                                                                                  sx: sx,
                                                                                  roundindex: roundindex,
                                                                                  keyindex: keyindex)
                                                                              : pickList.value[index]["round"][roundindex].keys
                                                                                          .toList()[keyindex] ==
                                                                                      "ft"
                                                                                  ? roundItem(
                                                                                      index: index,
                                                                                      sx: sx,
                                                                                      roundindex: roundindex,
                                                                                      keyindex: keyindex)
                                                                                  : roundItem(
                                                                                      index: index,
                                                                                      sx: sx,
                                                                                      roundindex: roundindex,
                                                                                      keyindex: keyindex),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    pickList.value[index]["round"].removeAt(roundindex);
                                                  },
                                                  child: Container(
                                                      width: sx(40),
                                                      height: sx(40),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(width: 0.3),
                                                          borderRadius: BorderRadius.all(Radius.circular(5))),
                                                      child: SvgPicture.asset('assets/StatusIcon/minus.svg', color: Color(0xff326aff))),
                                                )
                                              ],
                                            ),
                                          )
                                      ],
                                    )
                                  : Text("data")),
                              InkWell(
                                onTap: () {
                                  var types = pickList.value[index]["type"].split("/");
                                  var newRoundForTypes = {};
                                  int typeindex = 1;
                                  types.forEach((type) {
                                    if (type == "weight") {
                                      newRoundForTypes[userData.user.value.showKg.value ? "${typeindex}.kg" : "${typeindex}.lb"] = 0.0;
                                    } else {
                                      newRoundForTypes[typeindex.toString() + "." + type] = 0.0;
                                    }
                                    typeindex++;
                                  });
                                  // print([newRoundForTypes].runtimeType);
                                  if (pickList.value[index]["round"] == null) {
                                    pickList.value[index]["round"] = [newRoundForTypes].toList();
                                    // print(pickList.value[index]);
                                  } else {
                                    pickList.value[index]["round"].add(newRoundForTypes);
                                    print(pickList.value[index]);
                                  }
                                  // var newRoundForType = {};
                                  // types
                                  // pickList[index]["round"] = [];
                                },
                                child: Container(
                                    width: width,
                                    height: sx(40),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(color: Color(0xff0046ff), borderRadius: BorderRadius.all(Radius.circular(5))),
                                    child: SvgPicture.asset(
                                      'assets/StatusIcon/plus.svg',
                                      color: Colors.white,
                                    )),
                              ),
                            ],
                          )))
              ],
            ),
          ),
        ));
  }

  roundItem({required int index, required double Function(double) sx, required int roundindex, required int keyindex}) {
    return Row(children: [
      Container(
        margin: EdgeInsets.only(right: sx(10)),
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
        width: sx(80),
        height: sx(70),
        child: TextField(
          textAlign: TextAlign.left,
          keyboardType: TextInputType.number,
          style: TextStyle(fontSize: sx(20)),
          onChanged: (text) {
            pickList.value[index]["round"][roundindex][pickList.value[index]["round"][roundindex].keys.toList()[keyindex]] =
                double.parse(text);
            print(pickList.value[index]["round"][roundindex][pickList.value[index]["round"][roundindex].keys.toList()[keyindex]]);
          },
          decoration: InputDecoration(
            // contentPadding: EdgeInsets.only(
            //     bottom: sx(60) / 2, // HERE THE IMPORTANT PART
            //     left: sx(30)),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Color(0xffb4b4b4))),
            isDense: true,
            fillColor: Color(0xfff7f7f7),
            filled: true,
            errorStyle: TextStyle(color: Colors.white),
            focusedBorder: InputBorder.none,
            hintText:
                pickList.value[index]["round"][roundindex][pickList.value[index]["round"][roundindex].keys.toList()[keyindex]].toString(),
            border: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Colors.red)),
            // hintStyle: TextStyle(
            //     color: Color(0xffb4b4b4),
            //     fontWeight: FontWeight.w300,
            //     fontFamily: "AppleSDGothicNeo",
            //     fontStyle: FontStyle.normal,
            //     fontSize: sx(15)),
            // labelStyle: TextStyle(
            //     color: Color(0xffb4b4b4),
            //     fontWeight: FontWeight.w300,
            //     fontFamily: "AppleSDGothicNeo",
            //     fontStyle: FontStyle.normal,
            //     fontSize: sx(15))
          ),
        ),
      ),
      Text(
        pickList.value[index]["round"][roundindex].keys.toList()[keyindex].split(".")[1],
        style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff707070), fontSize: sx(30)),
      ),
      SizedBox(
        width: sx(40),
      ),
    ]);
  }

  simpleCommentBottomSheet({required double Function(double) sx, required width}) {
    return Container(
      padding: EdgeInsets.all(sx(20)),
      width: width,
      height: sx(630),
      decoration:
          BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: width,
            alignment: Alignment.center,
            child: Text("초간단 한줄평",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: sx(25),
                )),
          ),
          SizedBox(
            height: sx(30),
          ),
          bottomSheetButton(
              sx: sx,
              width: width,
              text: "😄 쉬웠어요",
              onPressed: () {
                var text = [
                  "오늘 샤워 안 해도 되겠네~",
                  "이 정도는 껌이지ㅋㅋ",
                  "운동했다고 하기도 민망한 정도 ㅎㅎ;;",
                  "아주 가벼운 강도!",
                  "Very Easy~",
                  "이 정도면 하루종일 할 수도 있어!",
                  "Easy Peasy~",
                  "아따 마 쉽다 쉬워~",
                  "운동 안한 느낌이야",
                  "리커버리 수준으로 쉬엄쉬엄"
                ];

                Get.back(result: text[Random().nextInt(text.length)]);
              }),
          SizedBox(
            height: sx(30),
          ),
          bottomSheetButton(
              sx: sx,
              width: width,
              text: "😊할만 했어요",
              onPressed: () {
                var text = [
                  "적당한 강도로 수행!",
                  "다음에는 조금 더 강도를 높여볼까?",
                  "약간 땀은 나지만, 이 정도면 수월하지!",
                  "오늘은 쉬엄쉬엄~",
                  "끝나고 한 번 더 해도 될 정도인데?",
                  "크로스핏, 누가 어렵대? ㅎㅎ",
                  "좀 쉬었다가 한번 더 할까?",
                  "이 정도면 웃으면서 할 수 있어!",
                  "할만한 수준이군!",
                ];

                Get.back(result: text[Random().nextInt(text.length)]);
              }),
          SizedBox(
            height: sx(30),
          ),
          bottomSheetButton(
              sx: sx,
              width: width,
              text: "😭 힘들었어요",
              onPressed: () {
                var text = [
                  "오늘은 조금 버거운 느낌?",
                  "오늘도 한 단계 성장했다...",
                  "힘들지만 결국 해냈다!",
                  "조금 더 빡세게 했다간 죽을지도 몰라..",
                  "오늘도 견뎌냈다.",
                  "내일은 좀 쉽겠지...?",
                  "견디는 삶에서 나아가는 삶으로",
                  "꾸준하게 하는것이 중요하다.",
                  "힘들지만, 운동할 맛이 나네!",
                  "숨이 벅차오르는구만!"
                ];

                Get.back(result: text[Random().nextInt(text.length)]);
              }),
          SizedBox(
            height: sx(30),
          ),
          bottomSheetButton(
              sx: sx,
              width: width,
              text: "🤮 죽을뻔 했어요",
              onPressed: () {
                var text = [
                  "와... 진짜.. 와... ㅜㅜ",
                  "오늘 토할 뻔했네...",
                  "이 힘든걸 내가 해냅니다!",
                  "내 모든 것을 다 쏟아냈다.",
                  "이게 맞나 싶다....",
                  "내일은 쉬어야겠다....;;",
                  "크로스핏... 너 이러기야? 나 서운해",
                  "이걸 가볍게 하는 사람도 있겠지?",
                  "Rx'd는 역시 무리인 듯...",
                  "세계 최고의 몸을 대한민국에 만듭니다."
                ];

                Get.back(result: text[Random().nextInt(text.length)]);
              }),
          SizedBox(
            height: sx(10),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.blue,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
            onPressed: () {
              Get.back();
            },
            child: Container(
              width: width,
              height: sx(80),
              alignment: Alignment.center,
              child: Text("닫기",
                  style: TextStyle(
                    color: Color(0xff0046ff),
                    fontWeight: FontWeight.w700,
                    fontSize: sx(25),
                  )),
            ),
          )
        ],
      ),
    );
  }

  bottomSheetButton({required double Function(double) sx, required width, required String text, required void Function()? onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.blue,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
      onPressed: onPressed,
      child: Container(
        width: width,
        height: sx(80),
        alignment: Alignment.center,
        child: Text(text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: sx(25),
            )),
      ),
    );
  }

  diaryDialog({
    required double Function(double) sy,
    required double Function(double) sx,
    required double width,
    required double height,
    required String title,
    required String text,
    void Function()? cancel,
    void Function()? ok,
    String? cancelText = "취소",
    String? okText = "확인",
  }) {
    return Container(
      width: width,
      height: height,
      child: Center(
        child: Material(
          color: Colors.black87.withOpacity(0),
          child: Container(
            width: sx(400),
            height: sx(400),
            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.all(Radius.circular(40))),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: sx(60), bottom: sx(30)),
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: sx(35)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(sx(30)),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xff707070), fontWeight: FontWeight.w500, fontSize: sx(25)),
                  ),
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(left: sx(30)),
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.black),
                        onPressed: cancel,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: sx(40), vertical: sx(20)),
                          child: Text(
                            cancelText!,
                            style: TextStyle(color: Color(0xff464646), fontWeight: FontWeight.w800, fontSize: sx(23)),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.black),
                        onPressed: ok,
                        child: Container(
                          constraints: BoxConstraints(maxWidth: sx(200)),
                          padding: EdgeInsets.symmetric(horizontal: sx(40), vertical: sx(20)),
                          child: Text(
                            okText!,
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: sx(23)),
                          ),
                        ),
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
