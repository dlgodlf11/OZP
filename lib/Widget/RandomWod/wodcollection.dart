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
import 'package:sweatbox2dot0/Widget/RandomWod/showWod.dart';

class WodCollection extends StatelessWidget {
  UserController userData = Get.put(UserController());
  ScrollController wodScrollController = new ScrollController();
  RxBool selectMode = false.obs;
  RxList selectedIndex = [].obs;
  List<String> filelist = [];
  ViewMainStateController viewMainStateController;
  WodCollection({required this.viewMainStateController});
  @override
  Widget build(BuildContext context) {
    print(userData.user.value.savedwod!.length);
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
        appBar: AppBar(
          title: Text("와드 타이머"),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset('assets/appbarIcon/btn_back.svg'),
          ),
          actions: [
            Obx(() => TextButton(
                onPressed: () {
                  selectMode.value = !selectMode.value;
                },
                child: Text(selectMode.value ? "취소" : "선택")))
          ],
        ),
        body: Obx(() => userData.user.value.savedwod!.length == 0
            ? Container()
            : Container(
                width: width,
                height: height,
                padding: EdgeInsets.all(sx(10)),
                child: GridView.builder(
                    itemCount: userData.user.value.savedwod!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, childAspectRatio: 1, crossAxisSpacing: sx(10), mainAxisSpacing: sx(10)),
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            if (selectMode.value) {
                              if (selectedIndex.value.indexWhere((element) => element == index) == -1) {
                                selectedIndex.add(index);
                              } else {
                                selectedIndex.removeWhere((element) => element == index);
                              }
                            } else {
                              Get.to(
                                () => ShowWod(
                                  wodindex: index,
                                  wodData: userData.user.value.savedwod![index],
                                ),
                                transition: Transition.size,
                                fullscreenDialog: false,
                              );
                            }
                          },
                          child: Hero(
                              tag: "wod${index}",
                              child: Material(
                                  child: Stack(
                                children: [
                                  Positioned(
                                    child: Container(
                                      color: Colors.white,
                                      width: double.infinity,
                                      height: double.infinity,
                                      padding: EdgeInsets.all(sx(5)),
                                      child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  SvgPicture.asset(splitCategory(text: userData.user.value.savedwod![index]["category"]),
                                                      width: sx(50)),
                                                  SizedBox(width: sx(15)),
                                                  Text(
                                                    userData.user.value.savedwod![index]["category"],
                                                    style: TextStyle(fontSize: sx(30), fontFamily: "AppleB"),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: sx(30),
                                              ),
                                              Text(
                                                userData.user.value.savedwod![index]["title"],
                                                style: TextStyle(fontSize: sx(25), height: 2),
                                              ),
                                              SizedBox(
                                                height: sx(10),
                                              ),
                                              for (int i = 0; i < userData.user.value.savedwod![index]["wods"].length; i++)
                                                Container(
                                                  width: width,
                                                  child: Text(
                                                    "${userData.user.value.savedwod![index]["wods"][i]["name"].replaceAll("-", "")}${userData.user.value.savedwod![index]["wods"][i]["weight"] == null ? '' : Database().changeLbKg(weight: userData.user.value.savedwod![index]["wods"][i]["weight"], type: userData.user.value.savedwod![index]["wods"][i]["type"])}",
                                                    style: TextStyle(fontSize: sx(25), height: 2),
                                                    maxLines: null,
                                                  ),
                                                ),
                                              SizedBox(
                                                height: sx(10),
                                              ),
                                              Text(
                                                "UNITED FOR STRENGTH",
                                                style: TextStyle(
                                                    fontSize: sx(15), height: 2, fontWeight: FontWeight.w800, fontFamily: "AppleB"),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                  Obx(() => Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: selectMode.value
                                          ? IconButton(
                                              onPressed: () {
                                                // print("object");
                                                // Database().removeWod(wodData: userData.user.value.savedwod![index]);
                                                if (selectedIndex.value.indexWhere((element) => element == index) == -1) {
                                                  selectedIndex.add(index);
                                                } else {
                                                  selectedIndex.removeWhere((element) => element == index);
                                                }
                                              },
                                              icon: Icon(
                                                selectedIndex.value.indexWhere((element) => element == index) == -1
                                                    ? Icons.circle
                                                    : Icons.check_circle,
                                                color: Colors.blue,
                                              ))
                                          : SizedBox()))
                                ],
                              ))));
                    }),
              )),
        bottomSheet: Obx(() => selectMode.value
            ? Container(
                width: width,
                height: sx(80),
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    bottomButton(
                      icon: SvgPicture.asset('assets/RandomWodIcon/share.svg', color: Colors.white),
                      onTap: () async {
                        int sucfile = 0;
                        await Permission.storage.request();
                        selectedIndex.value.forEach((index) async {
                          await viewMainStateController.screenshotController
                              .captureFromWidget(
                            Container(
                              color: Colors.white,
                              width: width,
                              height: width,
                              padding: EdgeInsets.all(sx(5)),
                              child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(splitCategory(text: userData.user.value.savedwod![index]["category"]),
                                              width: sx(50)),
                                          SizedBox(width: sx(15)),
                                          Text(
                                            userData.user.value.savedwod![index]["category"],
                                            style: TextStyle(fontSize: sx(30), fontFamily: "AppleB", color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: sx(30),
                                      ),
                                      Text(
                                        userData.user.value.savedwod![index]["title"],
                                        style: TextStyle(fontSize: sx(25), height: 2, color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: sx(10),
                                      ),
                                      for (int i = 0; i < userData.user.value.savedwod![index]["wods"].length; i++)
                                        Container(
                                          width: width,
                                          child: Text(
                                            "${userData.user.value.savedwod![index]["wods"][i]["name"].replaceAll("-", "")}${userData.user.value.savedwod![index]["wods"][i]["weight"] == null ? '' : Database().changeLbKg(weight: userData.user.value.savedwod![index]["wods"][i]["weight"], type: userData.user.value.savedwod![index]["wods"][i]["type"])}",
                                            style: TextStyle(fontSize: sx(25), height: 2, color: Colors.black),
                                            maxLines: null,
                                          ),
                                        ),
                                      SizedBox(
                                        height: sx(10),
                                      ),
                                      Text(
                                        "UNITED FOR STRENGTH",
                                        style: TextStyle(
                                            fontSize: sx(15),
                                            height: 2,
                                            fontWeight: FontWeight.w800,
                                            fontFamily: "AppleB",
                                            color: Colors.black),
                                      ),
                                    ],
                                  )),
                            ),
                          )
                              .then((image) async {
                            final tempDir = await getTemporaryDirectory();
                            final file = await new File('${tempDir.path}/image${index}.jpg').create();
                            file.writeAsBytesSync(image);
                            filelist.add(file.path);
                            if (filelist.length == selectedIndex.length) {
                              selectedIndex.clear();
                              selectMode.value = false;
                              await Share.shareFiles(filelist).then((value) {});
                              showSnackbar(
                                  text: "랜덤와드가 공유 되었습니다.",
                                  margin: EdgeInsets.symmetric(horizontal: sx(20), vertical: sx(80)),
                                  radius: sx(20));
                            }
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
                    Text("${selectedIndex.value.length}개 선택됨", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                    bottomButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        onTap: () {
                          selectedIndex.clear();
                          selectMode.value = false;
                          Database().removeWod(removeIndex: selectedIndex.value);
                        })
                  ],
                ),
              )
            : SizedBox()),
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

  bottomButton({required icon, required void Function() onTap}) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return InkWell(
        onTap: onTap,
        child: Container(width: sx(70), height: sx(70), child: icon),
      );
    });
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
