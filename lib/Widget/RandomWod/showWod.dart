import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:sweatbox2dot0/Services/database.dart';

class ShowWod extends StatelessWidget {
  int wodindex = 0;
  var wodData;
  ShowWod({required this.wodindex, this.wodData});
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Material(
            color: Colors.black.withOpacity(0.1),
            child: Center(
                child: Hero(
                    tag: "wod${wodindex}",
                    child: Material(
                      child: Container(
                        color: Colors.white,
                        width: double.infinity,
                        padding: EdgeInsets.all(sx(15)),
                        child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(splitCategory(text: wodData["category"]), width: sx(50)),
                                    SizedBox(width: sx(20)),
                                    Text(
                                      wodData["category"],
                                      style: TextStyle(fontSize: sx(30), fontFamily: "AppleB"),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: sx(30),
                                ),
                                Text(
                                  wodData["title"],
                                  style: TextStyle(fontSize: sx(25), height: 2),
                                ),
                                SizedBox(
                                  height: sx(10),
                                ),
                                for (int i = 0; i < wodData["wods"].length; i++)
                                  Container(
                                    width: width,
                                    child: Text(
                                      "${wodData["wods"][i]["name"].replaceAll("-", "")}${wodData["wods"][i]["weight"] == null ? '' : Database().changeLbKg(weight: wodData["wods"][i]["weight"], type: wodData["wods"][i]["type"])}",
                                      style: TextStyle(fontSize: sx(25), height: 2),
                                      maxLines: null,
                                    ),
                                  ),
                                SizedBox(
                                  height: sx(10),
                                ),
                                Text(
                                  "UNITED FOR STRENGTH",
                                  style: TextStyle(fontSize: sx(15), height: 2, fontWeight: FontWeight.w800, fontFamily: "AppleB"),
                                ),
                              ],
                            )),
                      ),
                    )))),
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
}
