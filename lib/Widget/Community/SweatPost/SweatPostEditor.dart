import 'dart:io';
import 'dart:math';

import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:sweatbox2dot0/Controller/UserDataController.dart';
import 'package:sweatbox2dot0/Services/database.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class SweatPostEditor extends StatelessWidget {
  TextEditingController title = new TextEditingController();
  TextEditingController tag = new TextEditingController();
  TextEditingController post = new TextEditingController();
  RxList<File> photoList = RxList<File>([]);
  RxList<dynamic> tagList = RxList<dynamic>([]);
  RxInt maxPhoto = 4.obs;
  var userData = Get.put(UserController());
  var postData = null;
  SweatPostEditor({this.postData}) {
    if (postData != null) {
      title.text = postData.title;
      post.text = postData.post;
      tagList.value = postData.tag;
    }
  }
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return GestureDetector(
        onTapDown: (value) {
          FocusScope.of(context).requestFocus(FocusNode());
          SystemChrome.setEnabledSystemUIOverlays([]);
        },
        child: Hero(
            tag: "edit",
            child: Obx(() => Scaffold(
                  backgroundColor: Colors.white,
                  resizeToAvoidBottomInset: true,
                  body: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(top: sx(20), bottom: sx(100), left: sx(30), right: sx(30)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "제목",
                            style: TextStyle(fontSize: sx(30), fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: sx(20),
                          ),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.all(Radius.circular(5))),
                            child: TextField(
                              controller: title,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Color(0xffb4b4b4))),
                                  isDense: true,
                                  fillColor: Colors.red,
                                  errorStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Colors.red)),
                                  labelText: "센스넘치는 포스트 제목",
                                  hintStyle: TextStyle(
                                      color: Color(0xffb4b4b4),
                                      fontWeight: FontWeight.w300,
                                      fontFamily: "AppleSDGothicNeo",
                                      fontStyle: FontStyle.normal,
                                      fontSize: sx(15)),
                                  labelStyle: TextStyle(
                                      color: Color(0xffb4b4b4),
                                      fontWeight: FontWeight.w300,
                                      fontStyle: FontStyle.normal,
                                      fontSize: sx(20))),
                            ),
                          ),
                          SizedBox(
                            height: sx(20),
                          ),
                          Text(
                            "포스트 쓰기",
                            style: TextStyle(fontSize: sx(30), fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: sx(20),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: TextField(
                              controller: post,
                              maxLines: null,
                              maxLength: 500,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Color(0xffb4b4b4))),
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  errorStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Colors.red)),
                                  labelText: "크로스핏터들과 즐거운 소통을 해봐요!",
                                  hintStyle: TextStyle(
                                      color: Color(0xffb4b4b4),
                                      fontWeight: FontWeight.w300,
                                      fontFamily: "AppleSDGothicNeo",
                                      fontStyle: FontStyle.normal,
                                      fontSize: sx(15)),
                                  labelStyle: TextStyle(
                                      color: Color(0xffb4b4b4),
                                      fontWeight: FontWeight.w300,
                                      fontStyle: FontStyle.normal,
                                      fontSize: sx(20))),
                            ),
                          ),
                          SizedBox(
                            height: sx(20),
                          ),
                          Text(
                            "사진 추가",
                            style: TextStyle(fontSize: sx(30), fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: sx(20),
                          ),
                          postData != null ? Text("사진은 수정이 불가능 합니다.") : Container(),
                          Container(
                              width: width,
                              height: sx(100),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    for (int i = 0; i < 4; i++)
                                      i == photoList.value.length
                                          ? InkWell(
                                              onTap: () async {
                                                if (postData != null) {
                                                  return;
                                                }
                                                print(photoList.length);
                                                await AssetPicker.pickAssets(context, maxAssets: 4 - photoList.length, gridCount: 4)
                                                    .then((value) {
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
                                                                  String.fromCharCodes(Iterable.generate(
                                                                      5, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)))) +
                                                                  ".jpg",
                                                              quality: 30,
                                                              format: CompressFormat.jpeg)
                                                          .then((downsizefile) {
                                                        aa++;

                                                        photoList.add(File(downsizefile!.path));
                                                      });
                                                    });
                                                  });
                                                });
                                              },
                                              child: Container(
                                                width: sx(100),
                                                height: sx(100),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xfff7f7f7)),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor: Colors.white,
                                                      radius: sx(20),
                                                      child: SvgPicture.asset(
                                                        'assets/postAsset/camera.svg',
                                                        width: sx(30),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: sx(5),
                                                    ),
                                                    RichText(
                                                        text: TextSpan(children: [
                                                      TextSpan(
                                                        style: TextStyle(
                                                            color: const Color(0xff0046ff),
                                                            fontWeight: FontWeight.w100,
                                                            fontStyle: FontStyle.normal,
                                                            fontSize: sx(20)),
                                                        text: "${photoList.length}",
                                                      ),
                                                      TextSpan(
                                                          style: TextStyle(
                                                              color: const Color(0xff707070),
                                                              fontWeight: FontWeight.w100,
                                                              fontStyle: FontStyle.normal,
                                                              fontSize: sx(20)),
                                                          text: "/4"),
                                                    ])),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : i < photoList.length
                                              ? Stack(
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(right: sx(15)),
                                                        width: sx(100),
                                                        height: sx(100),
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(image: FileImage(photoList[i]), fit: BoxFit.fill),
                                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                                            color: const Color(0xffb5b5b5))),
                                                    Positioned(
                                                        right: sx(20),
                                                        child: InkWell(
                                                          onTap: () {
                                                            photoList.removeAt(i);
                                                          },
                                                          child: CircleAvatar(
                                                            backgroundColor: Color(0xfff7f7f7),
                                                            radius: sx(15),
                                                            child: SvgPicture.asset('assets/StatusIcon/cancle.svg'),
                                                          ),
                                                        ))
                                                  ],
                                                )
                                              : Container()
                                  ],
                                ),
                              )

                              // ListView.builder(
                              //       itemCount: maxPhoto.value,
                              //       scrollDirection: Axis.horizontal,
                              //       itemBuilder: (context, index) {
                              //         if (index == photoList.value.length) {
                              //           return InkWell(
                              //             onTap: () async {
                              //               if (postData != null) {
                              //                 return;
                              //               }
                              //               print(photoList.length);
                              //               await AssetPicker.pickAssets(context, maxAssets: 4 - photoList.length, gridCount: 4)
                              //                   .then((value) {
                              //                 if (value == null) {
                              //                   return;
                              //                 }
                              //                 const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
                              //                 Random _rnd = Random();
                              //                 var aa = 0;
                              //                 value.forEach((element) async {
                              //                   await element.file.then((filedata) async {
                              //                     Directory tempDir = await getTemporaryDirectory();
                              //                     String tempPath = tempDir.path;

                              //                     await FlutterImageCompress.compressAndGetFile(
                              //                             filedata!.path,
                              //                             tempPath +
                              //                                 String.fromCharCodes(Iterable.generate(
                              //                                     5, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)))) +
                              //                                 ".jpg",
                              //                             quality: 30,
                              //                             format: CompressFormat.jpeg)
                              //                         .then((downsizefile) {
                              //                       aa++;

                              //                       photoList.add(File(downsizefile!.path));
                              //                     });
                              //                   });
                              //                 });
                              //               });
                              //             },
                              //             child: Container(
                              //               width: sx(100),
                              //               height: sx(100),
                              //               decoration: BoxDecoration(
                              //                   borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xfff7f7f7)),
                              //               child: Column(
                              //                 mainAxisAlignment: MainAxisAlignment.center,
                              //                 children: [
                              //                   CircleAvatar(
                              //                     backgroundColor: Colors.white,
                              //                     radius: sx(20),
                              //                     child: SvgPicture.asset(
                              //                       'assets/postAsset/camera.svg',
                              //                       width: sx(30),
                              //                     ),
                              //                   ),
                              //                   SizedBox(
                              //                     height: sx(5),
                              //                   ),
                              //                   RichText(
                              //                       text: TextSpan(children: [
                              //                     TextSpan(
                              //                       style: TextStyle(
                              //                           color: const Color(0xff0046ff),
                              //                           fontWeight: FontWeight.w100,
                              //                           fontStyle: FontStyle.normal,
                              //                           fontSize: sx(20)),
                              //                       text: "${photoList.length}",
                              //                     ),
                              //                     TextSpan(
                              //                         style: TextStyle(
                              //                             color: const Color(0xff707070),
                              //                             fontWeight: FontWeight.w100,
                              //                             fontStyle: FontStyle.normal,
                              //                             fontSize: sx(20)),
                              //                         text: "/4"),
                              //                   ])),
                              //                 ],
                              //               ),
                              //             ),
                              //           );
                              //         } else if (index < photoList.length) {
                              //           return Container(
                              //               margin: EdgeInsets.only(right: sx(15)),
                              //               width: sx(100),
                              //               height: sx(100),
                              //               decoration: BoxDecoration(
                              //                   image: DecorationImage(image: FileImage(photoList[index]), fit: BoxFit.fill),
                              //                   borderRadius: BorderRadius.all(Radius.circular(10)),
                              //                   color: const Color(0xffb5b5b5)));
                              //         } else {
                              //           return Container();
                              //         }
                              //       })
                              ),
                          SizedBox(
                            height: sx(20),
                          ),
                          Text(
                            "스웨트 태그",
                            style: TextStyle(fontSize: sx(30), fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: sx(20),
                          ),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.all(Radius.circular(5))),
                            height: sx(70),
                            child: TextField(
                              controller: tag,
                              onChanged: (text) {
                                if (text.contains(" ")) {
                                  tagList.add(text.split(" ")[0]);
                                  tag.clear();
                                }
                                if (text.contains(",")) {
                                  tagList.add(text.split(",")[0]);
                                  tag.clear();
                                }
                              },
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Color(0xffb4b4b4))),
                                  isDense: true,
                                  fillColor: Colors.red,
                                  errorStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Colors.red)),
                                  labelText: "스웨트 태그 추가",
                                  hintText: "스페이스바, 쉼표를 입력하면 태그가 추가됩니다.",
                                  hintStyle: TextStyle(
                                      color: Color(0xffb4b4b4),
                                      fontWeight: FontWeight.w300,
                                      fontFamily: "AppleSDGothicNeo",
                                      fontStyle: FontStyle.normal,
                                      fontSize: sx(15)),
                                  labelStyle: TextStyle(
                                      color: Color(0xffb4b4b4),
                                      fontWeight: FontWeight.w300,
                                      fontStyle: FontStyle.normal,
                                      fontSize: sx(20))),
                            ),
                          ),
                          SizedBox(
                            height: sx(30),
                          ),
                          tagList.length == 0
                              ? SizedBox()
                              : Container(
                                  width: width,
                                  padding: EdgeInsets.only(bottom: sx(10)),
                                  height: sx(70),
                                  child: ListView.builder(
                                      itemCount: tagList.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.only(right: sx(20)),
                                          child: Chip(
                                              backgroundColor: Colors.white,
                                              label: Text(
                                                "#" + tagList[index],
                                                style: TextStyle(color: Color(0xff707070), fontSize: sx(16)),
                                              ),
                                              onDeleted: () {
                                                tagList.removeAt(index);
                                              }),
                                        );
                                      }),
                                ),
                          Divider(
                            height: sx(30),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (title.text != "" && post.text != "") {
                                if (postData == null) {
                                  Database()
                                      .createPost(title: title.text, post: post.text, taglist: tagList, images: photoList)
                                      .then((value) {
                                    Get.back();
                                  });
                                } else {
                                  Database()
                                      .updatePost(
                                          postid: postData.id, title: title.text, post: post.text, taglist: tagList, images: photoList)
                                      .then((value) {
                                    Get.back();
                                  });
                                }
                              } else {}
                            },
                            child: Container(
                              height: sx(80),
                              alignment: Alignment.center,
                              child: Text("작성끝"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))),
      );
    });
  }
}
