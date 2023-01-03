import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:sweatbox2dot0/Controller/UserDataController.dart';
import 'package:sweatbox2dot0/Controller/ViewMainStateController.dart';
import 'package:sweatbox2dot0/Services/database.dart';
import 'package:sweatbox2dot0/Widget/RandomWod/wodFilterDialog.dart';
import 'package:sweatbox2dot0/Widget/RandomWod/wodcollection.dart';

class RandomWod extends StatelessWidget {
  ViewMainStateController viewMainStateController;
  UserController userData;
  RxBool go = false.obs;
  ScrollController wodScrollController = new ScrollController();

  RandomWod({required this.viewMainStateController, required this.userData});

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Expanded(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(sx(25)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "랜덤 와드",
                      style: TextStyle(color: Colors.black, fontSize: sx(30)),
                    ),
                    SizedBox(width: sx(15)),
                    Obx(() => Container(
                          width: sx(120),
                          height: sx(40),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Color(0xffe2eaff), borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: Text(
                            "남은 횟수 ${userData.user.value.randomwodCount.value}회",
                            style: TextStyle(color: Color(0xff084bff), fontSize: sx(15)),
                          ),
                        ))
                  ],
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white.withOpacity(0),
                        shadowColor: Colors.white.withOpacity(0),
                        onPrimary: Colors.blue,
                        padding: EdgeInsets.all(0)),
                    onPressed: () {
                      Get.to(() => WodCollection(
                            viewMainStateController: viewMainStateController,
                          ));
                    },
                    child: Row(
                      children: [
                        Container(
                          width: sx(40),
                          height: sx(40),
                          decoration: BoxDecoration(color: Color(0xffe2eaff), borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: Icon(
                            Icons.circle,
                            size: sx(25),
                            color: Color(0xff084bff),
                          ),
                        ),
                        SizedBox(
                          width: sx(10),
                        ),
                        Text(
                          "콜렉션 보기",
                          style: TextStyle(color: Colors.black, fontSize: sx(15), fontWeight: FontWeight.w600),
                        ),
                      ],
                    ))
              ],
            ),
          ),
          Obx(
            () => go.value
                ? Container(
                    width: width,
                    height: width,
                    padding: EdgeInsets.all(sx(50)),
                    child: Lottie.asset(
                      "assets/RandomWodIcon/loading bar.json",
                      frameRate: FrameRate(120),
                      repeat: false,
                    ),
                  )
                : viewMainStateController.randomwod.length == 0
                    ? Container(
                        width: width,
                        height: width,
                        alignment: Alignment.center,
                        color: Colors.white,
                        child: SingleChildScrollView(
                          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                            SvgPicture.asset(
                              'assets/RandomWodIcon/status_.svg',
                              width: sx(150),
                              color: Color(0xff084bff),
                            ),
                            SizedBox(
                              height: sx(20),
                            ),
                            Text(
                              "랜덤와드는 처음이죠?\nGO!를 눌러주세요!",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: sx(30)),
                            )
                          ]),
                        ),
                      )
                    : Container(
                        width: width,
                        height: width,
                        color: Colors.white,
                        child: RawScrollbar(
                          controller: wodScrollController,
                          isAlwaysShown: true,
                          thumbColor: Colors.blue,
                          radius: Radius.circular(23),
                          child: SingleChildScrollView(
                            controller: wodScrollController,
                            child: Screenshot(
                              controller: viewMainStateController.screenshotController,
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.all(sx(25)),
                                child:
                                    Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                      Container(
                                        width: width,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(splitCategory(text: viewMainStateController.randomwod[0]["category"]),
                                                width: sx(50)),
                                            SizedBox(
                                              width: sx(30),
                                            ),
                                            Text(
                                              viewMainStateController.randomwod[0]["category"],
                                              style: TextStyle(fontSize: sx(30), fontFamily: "AppleB"),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: sx(30),
                                      ),
                                      Text(
                                        viewMainStateController.randomwod[0]["title"],
                                        style: TextStyle(fontSize: sx(25), height: 2),
                                      ),
                                      for (int i = 0; i < viewMainStateController.randomwod[0]["wods"].length; i++)
                                        Row(
                                          children: [
                                            Container(
                                              width: width - (sx(25) * 2),
                                              child: Text(
                                                "${viewMainStateController.randomwod[0]["wods"][i]["name"]}   ${viewMainStateController.randomwod[0]["wods"][i]["weight"] == null ? "" : Database().changeLbKg(weight: viewMainStateController.randomwod[0]["wods"][i]["weight"], type: viewMainStateController.randomwod[0]["wods"][i]["type"])}"
                                                    .replaceAll("- ", ""),
                                                style: TextStyle(fontSize: sx(25), height: 2),
                                                maxLines: null,
                                              ),
                                            ),
                                          ],
                                        ),
                                      Text(
                                        "UNITED FOR STRENGTH",
                                        style: TextStyle(fontSize: sx(15), fontWeight: FontWeight.w800, fontFamily: "AppleB"),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        )),
          ),
          Container(
            padding: EdgeInsets.only(left: sx(25), right: sx(25), bottom: sx(30)),
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    bottomButton(
                      icon: SvgPicture.asset('assets/RandomWodIcon/WODcolct.svg'),
                      onTap: () {
                        Database().saveWod(wodData: viewMainStateController.randomwod[0]).then((val) {
                          showSnackbar(
                              text: "랜덤와드 콜렉션에 저장되었습니다.",
                              margin: EdgeInsets.symmetric(horizontal: sx(20), vertical: sx(80)),
                              radius: sx(20));
                        });
                      },
                    ),
                    bottomButton(
                      icon: SvgPicture.asset('assets/RandomWodIcon/share.svg'),
                      onTap: () async {
                        await Permission.storage.request();
                        await viewMainStateController.screenshotController.capture().then((image) async {
                          final tempDir = await getTemporaryDirectory();
                          final file = await new File('${tempDir.path}/image.jpg').create();
                          file.writeAsBytesSync(image!);
                          await Share.shareFiles([file.path]).then((value) {
                            showSnackbar(
                                text: "랜덤와드가 공유 되었습니다.",
                                margin: EdgeInsets.symmetric(horizontal: sx(20), vertical: sx(80)),
                                radius: sx(20));
                          });
                        });

                        // String wods = "";
                        // for (int i = 0; i < viewMainStateController.randomwod[0]["wods"].length; i++) {
                        //   var weight = viewMainStateController.randomwod[0]["wods"][i]["weight"] == null
                        //       ? ""
                        //       : viewMainStateController.randomwod[0]["wods"][i]["weight"].toString() +
                        //           viewMainStateController.randomwod[0]["wods"][i]["type"];
                        //   wods += "\n${viewMainStateController.randomwod[0]["wods"][i]["name"]}${weight}";
                        // }
                        // print(viewMainStateController.randomwod[0]["category"]);
                        // Clipboard.setData(ClipboardData(
                        //     text:
                        //         '${viewMainStateController.randomwod[0]["category"]}\n${viewMainStateController.randomwod[0]["title"]}\n${wods}'));
                      },
                    ),
                    bottomButton(
                      icon: SvgPicture.asset('assets/RandomWodIcon/down.svg'),
                      onTap: () async {
                        print("asdf");

                        await Permission.storage.request();
                        await viewMainStateController.screenshotController.capture().then((image) async {
                          print(image);
                          if (image != null) {
                            var result = await ImageGallerySaver.saveImage(image, name: viewMainStateController.randomwod[0]["title"]);
                            await showSnackbar(
                                text: "랜덤와드 이미지를 저장하였습니다.",
                                margin: EdgeInsets.symmetric(horizontal: sx(20), vertical: sx(80)),
                                radius: sx(20));
                            print(result["filePath"]);
                          }
                        });
                      },
                    ),
                    bottomButton(
                      icon: SvgPicture.asset('assets/RandomWodIcon/filter.svg'),
                      onTap: () {
                        Get.dialog(WodFilterDialog(), barrierDismissible: true);
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        primary: Colors.blue,
                        elevation: 0,
                        onPrimary: Colors.white,
                        padding: EdgeInsets.all(sx(15)),
                        minimumSize: Size(sx(30), sx(30))),
                    onPressed: () {
                      if (go == false) {
                        if (userData.user.value.randomwodCount.value != 0) {
                          userData.getRandomWod().then((value) {
                            go.value = true;
                            Future.delayed(Duration(milliseconds: 1000)).then((_) {
                              go.value = false;
                            });
                            viewMainStateController.randomwod.insert(0, value);
                            if (viewMainStateController.randomwod.length == 2) viewMainStateController.randomwod.removeLast();
                            print(viewMainStateController.randomwod);
                          });
                        }
                      }
                    },
                    child: Container(
                        alignment: Alignment.center,
                        width: sx(60),
                        height: sx(30),
                        child: Text(
                          "GO!",
                          style: TextStyle(color: Colors.white),
                        )))
              ],
            ),
          )
        ],
      ));
    });
  }

  bottomButton({required icon, required void Function() onTap}) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return InkWell(
        onTap: onTap,
        child: Container(width: sx(70), height: sx(70), child: icon),
      );
    });
  }

  splitCategory({required String text}) {
    var category = text.split(" ");
    print(category);
    switch (category[0]) {
      case ('Bodyweight'):
        return 'assets/RandomWodIcon/test.svg';
      case ('Crossfit.com'):
        return 'assets/RandomWodIcon/datcom.svg';
      case ('Games'):
        return 'assets/RandomWodIcon/games_gold.svg';
      case ('Regionals'):
        return 'assets/RandomWodIcon/games_siver.svg';
      case ('Open'):
        return 'assets/RandomWodIcon/games_bronze.svg';
      case ('Home'):
        return 'assets/RandomWodIcon/home.svg';
      case ('Girls'):
        return 'assets/RandomWodIcon/girls.svg';
      case ('Hero'):
        return 'assets/RandomWodIcon/hero.svg';
      default:
    }
  }

  showSnackbar({required text, required EdgeInsets margin, required radius}) {
    Get.rawSnackbar(
        messageText: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        snackPosition: SnackPosition.TOP,
        margin: margin,
        backgroundColor: Color(0xff00c364),
        borderRadius: radius);
  }
}
