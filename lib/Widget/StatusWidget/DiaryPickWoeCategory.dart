import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:sweatbox2dot0/Controller/UserDataController.dart';
import 'package:sweatbox2dot0/Services/database.dart';

class PickCategory extends StatelessWidget {
  UserController userData = Get.put(UserController());

  RxList searchList = [].obs;
  RxList<dynamic> pickList = [].obs;
  List<dynamic>? categorys;
  PickCategory({required picklist}) {
    pickList = picklist;
    print(picklist);
    Database().getWodCategoryList().then((value) {
      categorys = value;
    });
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
          title: Text("종목 입력"),
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
            padding: EdgeInsets.all(sx(30)),
            width: width,
            child: Column(
              children: [
                searchTextField(sx: sx),
                pickListView(sx: sx, width: width),
                SizedBox(
                  height: sx(20),
                ),
                Container(
                  width: width,
                  height: sx(500),
                  child: Obx(() => ListView.builder(
                      itemCount: searchList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            if (pickList.indexWhere((element) => element["content"] == searchList[index]["content"]) == -1) {
                              var temp = searchList[index];
                              temp["round"] = new RxList([]);
                              var types = temp["type"].split("/");
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
                              temp["round"].add(newRoundForTypes);
                              pickList.add(temp);
                              print(pickList);
                            } else {
                              pickList.removeWhere((element) => element["content"] == searchList[index]["content"]);
                            }
                          },
                          child: Container(
                            width: width,
                            height: sx(70),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  searchList[index]["content"],
                                  style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xff707070), fontSize: sx(30)),
                                ),
                                Obx(() => Container(
                                      width: sx(50),
                                      height: sx(50),
                                      decoration: BoxDecoration(
                                          color: pickList.indexWhere((element) => element["content"] == searchList[index]["content"]) == -1
                                              ? Colors.white
                                              : Color(0xff0046ff),
                                          border: Border.all(
                                              width: sx(5),
                                              color:
                                                  pickList.indexWhere((element) => element["content"] == searchList[index]["content"]) == -1
                                                      ? Color(0xff707070)
                                                      : Color(0xff0046ff)),
                                          borderRadius: BorderRadius.all(Radius.circular(900))),
                                      child: SvgPicture.asset(
                                        'assets/StatusIcon/check.svg',
                                        color: Colors.white,
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        );
                      })),
                )
              ],
            ),
          ),
        ),
        bottomSheet: InkWell(
          onTap: () {
            Get.back(result: pickList);
          },
          child: Container(
            margin: EdgeInsets.all(sx(20)),
            width: width,
            height: sx(90),
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Color(0xff0046ff), borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Text(
              "선택 완료",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: sx(20)),
            ),
          ),
        ),
      );
    }));
  }

  pickListView({required double Function(double) sx, required width}) {
    return Container(
      width: width,
      height: sx(70),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffb7b7b7)))),
      child: Obx(() => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: pickList.value.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(right: sx(30)),
              height: sx(70),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      pickList.removeAt(index);
                    },
                    child: CircleAvatar(
                      backgroundColor: Color(0xfff7f7f7),
                      radius: sx(15),
                      child: SvgPicture.asset(
                        'assets/StatusIcon/cancle.svg',
                        width: sx(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: sx(20),
                  ),
                  Text(
                    pickList[index]["content"],
                    style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xffb7b7b7), fontSize: sx(25)),
                  )
                ],
              ),
            );
          })),
    );
  }

  searchTextField({required double Function(double) sx}) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
      height: sx(70),
      child: TextField(
        onChanged: (text) {
          print(text);
          searchList.clear();
          if (text != "")
            searchList.value = categorys!.where((element) => element["content"].toUpperCase().contains(text.toUpperCase())).toList();
        },
        textAlign: TextAlign.left,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Color(0xffb4b4b4))),
            isDense: true,
            fillColor: Color(0xfff7f7f7),
            filled: true,
            errorStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Colors.red)),
            labelText: "오늘 끝낸 종목을 찾아보세요!",
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
    );
  }
}
