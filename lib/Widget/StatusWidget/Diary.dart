import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:sweatbox2dot0/Controller/StatusStateController.dart';
import 'package:sweatbox2dot0/Controller/UserDataController.dart';
import 'package:sweatbox2dot0/Services/database.dart';
import 'package:sweatbox2dot0/Widget/StatusWidget/DiaryEdit.dart';

class DiaryWidget extends StatelessWidget {
  var userData = Get.put(UserController());
  var statusStateController = Get.put(StatusStateController());
  RxInt selectedDay = DateTime.now().day.obs;
  RxInt selectedRealDay = DateTime.now().day.obs;
  RxInt month = DateTime.now().month.obs;

  Rx<DateTime> todayMonth = new Rx<DateTime>(DateTime(
    DateTime.now().year,
    DateTime.now().month,
  ));

  Rx<DateTime> nextMonth = new Rx<DateTime>(DateTime(
    DateTime.now().year,
    DateTime.now().month + 1,
  ));
  RxInt monthDayCount = 0.obs;
  var weekDayName = ['일', '월', '화', '수', '목', '금', '토'];
  Rx<DateTime> selectedDateTime = DateTime.now().obs;

  DiaryWidget() {
    monthDayCount.value = nextMonth.value.difference(todayMonth.value).inDays;
  }
  increaseMonth() {
    month.value++;
    todayMonth.value = DateTime(
      DateTime.now().year,
      month.value,
    );
    nextMonth.value = DateTime(
      DateTime.now().year,
      month.value + 1,
    );
    monthDayCount.value = nextMonth.value.difference(todayMonth.value).inDays;
  }

  decreaseMonth() {
    month.value--;
    todayMonth.value = DateTime(
      DateTime.now().year,
      month.value,
    );
    nextMonth.value = DateTime(
      DateTime.now().year,
      month.value + 1,
    );
    monthDayCount.value = nextMonth.value.difference(todayMonth.value).inDays;
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            controller: statusStateController.statusScrollController,
            child: Obx(() => Container(
                  width: width,
                  padding: EdgeInsets.only(top: sx(150) * statusStateController.enablePadding.value, bottom: sx(30)),
                  child: Column(
                    children: [
                      calendar(width: width, sx: sx),
                      Obx(() => userData.user.value.diary.indexWhere((element) => element["date"].contains(
                                  "${DateTime(DateTime.now().year, month.value, selectedRealDay.value).year}-${NumberFormat("00", "en_US").format(DateTime(DateTime.now().year, month.value, selectedRealDay.value).month)}-${NumberFormat("00", "en_US").format(DateTime(DateTime.now().year, month.value, selectedRealDay.value).day)}")) ==
                              -1
                          ? diaryAddButton(width: width, sx: sx)
                          : Column(
                              children: [
                                writedDiaryList(width: width, sx: sx),
                                userData.user.value.diary
                                            .where((element) => element["date"].contains(selectedDateTime.value.toString().split(" ")[0]))
                                            .toList()
                                            .indexWhere((element) => element["category"] == "Rest") ==
                                        -1
                                    ? diaryAddButton(width: width, sx: sx)
                                    : Container()
                              ],
                            ))
                    ],
                  ),
                )),
          ));
    });
  }

  writedDiaryList({required width, required double Function(double) sx}) {
    return Column(
      children: [
        for (int diaryIndex = 0;
            diaryIndex <
                userData.user.value.diary
                    .where((element) => element["date"].contains(selectedDateTime.value.toString().split(" ")[0]))
                    .toList()
                    .length;
            diaryIndex++)
          InkWell(
            onTap: () {
              userData.user.value.diary
                          .where((element) => element["date"].contains(selectedDateTime.value.toString().split(" ")[0]))
                          .toList()[diaryIndex]["category"] ==
                      "Rest"
                  ? null
                  : Get.to(() => DiaryEdit(
                        diaryData: userData.user.value.diary
                            .where((element) => element["date"].contains(selectedDateTime.value.toString().split(" ")[0]))
                            .toList()[diaryIndex],
                        selectedDateTime: selectedDateTime,
                      ));
            },
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: sx(30), vertical: sx(10)),
                width: width,
                height: sx(70),
                padding: EdgeInsets.only(left: sx(20)),
                decoration: BoxDecoration(
                    color: userData.user.value.diary
                                .where((element) => element["date"].contains(selectedDateTime.value.toString().split(" ")[0]))
                                .toList()[diaryIndex]["category"] ==
                            "Rest"
                        ? Color(0xffcdede6)
                        : Color(0xfff5e4bd),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  children: [
                    Container(
                      width: sx(30),
                      height: sx(30),
                      decoration: BoxDecoration(
                          color: userData.user.value.diary
                                      .where((element) => element["date"].contains(selectedDateTime.value.toString().split(" ")[0]))
                                      .toList()[diaryIndex]["category"] ==
                                  "Rest"
                              ? Color(0xffedfffb)
                              : Color(0xfffff8db),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: SvgPicture.asset(
                        'assets/StatusIcon/check.svg',
                        color: userData.user.value.diary
                                    .where((element) => element["date"].contains(selectedDateTime.value.toString().split(" ")[0]))
                                    .toList()[diaryIndex]["category"] ==
                                "Rest"
                            ? Color(0xff74e8cd)
                            : Color(0xffffb100),
                      ),
                    ),
                    SizedBox(
                      width: sx(20),
                    ),
                    Text(
                      userData.user.value.diary
                                  .where((element) => element["date"].contains(selectedDateTime.value.toString().split(" ")[0]))
                                  .toList()[diaryIndex]["category"] ==
                              "Rest"
                          ? "오늘은 푹쉬고 내일은 스웨트!"
                          : userData.user.value.diary
                              .where((element) => element["date"].contains(selectedDateTime.value.toString().split(" ")[0]))
                              .toList()[diaryIndex]["simplecomment"],
                      style: TextStyle(fontSize: sx(20), fontWeight: FontWeight.w600),
                    ),
                    Expanded(
                        child: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.all(sx(10)),
                            child: InkWell(
                              onTap: () {
                                Database().removeDiary(
                                    diaryData: userData.user.value.diary
                                        .where((element) => element["date"].contains(selectedDateTime.value.toString().split(" ")[0]))
                                        .toList()[diaryIndex]);
                              },
                              child: SvgPicture.asset(
                                'assets/StatusIcon/minus.svg',
                                color: userData.user.value.diary
                                            .where((element) => element["date"].contains(selectedDateTime.value.toString().split(" ")[0]))
                                            .toList()[diaryIndex]["category"] ==
                                        "Rest"
                                    ? Color(0xff74e8cd)
                                    : Color(0xffffb100),
                              ),
                            )))
                  ],
                )),
          ),
      ],
    );
  }

  diaryAddButton({required width, required double Function(double) sx}) {
    return InkWell(
      onTap: () {
        Get.to(() => DiaryEdit(
              selectedDateTime: selectedDateTime,
            ));
      },
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: sx(30), vertical: sx(10)),
          width: width,
          height: sx(70),
          padding: EdgeInsets.only(left: sx(20)),
          decoration: BoxDecoration(color: Color(0xffE2EAFF), borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            children: [
              Container(
                width: sx(30),
                height: sx(30),
                decoration: BoxDecoration(color: Color(0xff326Aff), borderRadius: BorderRadius.all(Radius.circular(5))),
                child: SvgPicture.asset(
                  'assets/StatusIcon/plus.svg',
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: sx(20),
              ),
              Text(
                "오늘은 어떤 와드를 했나요?",
                style: TextStyle(fontSize: sx(20), fontWeight: FontWeight.w600),
              )
            ],
          )),
    );
  }

  calendar({required width, required double Function(double) sx}) {
    return Container(
      width: width,
      height: sx(520),
      padding: EdgeInsets.all(sx(30)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    decreaseMonth();
                  },
                  icon: Icon(Icons.keyboard_arrow_left)),
              Text(
                "${todayMonth.value.year}.${todayMonth.value.month}",
                style: TextStyle(fontSize: sx(25), fontWeight: FontWeight.w800),
              ),
              IconButton(
                  onPressed: () {
                    increaseMonth();
                  },
                  icon: Icon(Icons.keyboard_arrow_right))
            ],
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var item in weekDayName)
                  Container(
                    width: sx(65),
                    height: sx(20),
                    alignment: Alignment.center,
                    child: Text(item,
                        textScaleFactor: 1,
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w200,
                            fontFamily: "AppleSDGothicNeo",
                            fontStyle: FontStyle.normal,
                            fontSize: sx(20)),
                        textAlign: TextAlign.center),
                  )
              ],
            ),
          ),
          SizedBox(
            height: sx(20),
          ),
          Expanded(
              child: Obx(() => RawScrollbar(
                  thumbColor: Color(0xff0b4bff).withOpacity(0.4),
                  radius: Radius.circular(300),
                  child: GridView.builder(
                      //physics: NeverScrollableScrollPhysics(),
                      itemCount: monthDayCount.value + (49 - monthDayCount.value),
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 1, crossAxisCount: 7, mainAxisExtent: sx(70)),
                      itemBuilder: (BuildContext ctx, index) {
                        if (todayMonth.value.weekday <= index && monthDayCount.value >= (index - todayMonth.value.weekday) + 1) {
                          return Obx(() => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  padding: EdgeInsets.all(0),
                                  primary: Colors.white,
                                  onPrimary: Color(0xfffd851a),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0)))),
                              onPressed: () {
                                selectedDay.value = index;
                                selectedRealDay.value = ((index - todayMonth.value.weekday) + 1);
                                selectedDateTime.value = new DateTime(
                                    DateTime(DateTime.now().year, month.value, ((index - todayMonth.value.weekday) + 1)).year,
                                    DateTime(DateTime.now().year, month.value, ((index - todayMonth.value.weekday) + 1)).month,
                                    DateTime(DateTime.now().year, month.value, ((index - todayMonth.value.weekday) + 1)).day);
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  userData.user.value.diary.indexWhere((element) => element["date"].contains(
                                              "${DateTime(DateTime.now().year, month.value, (index - todayMonth.value.weekday) + 1).year}-${NumberFormat("00", "en_US").format(DateTime(DateTime.now().year, month.value, (index - todayMonth.value.weekday) + 1).month)}-${NumberFormat("00", "en_US").format(DateTime(DateTime.now().year, month.value, (index - todayMonth.value.weekday) + 1).day)}")) ==
                                          -1
                                      ? SizedBox()
                                      : Container(
                                          padding: EdgeInsets.all(sx(10)),
                                          child: SvgPicture.asset(
                                            "assets/StatusIcon/diary_exercise.svg",
                                            color: userData.user.value.diary
                                                        .where((element) => element["date"].contains(
                                                            "${DateTime(DateTime.now().year, month.value, (index - todayMonth.value.weekday) + 1).year}-${NumberFormat("00", "en_US").format(DateTime(DateTime.now().year, month.value, (index - todayMonth.value.weekday) + 1).month)}-${NumberFormat("00", "en_US").format(DateTime(DateTime.now().year, month.value, (index - todayMonth.value.weekday) + 1).day)}"))
                                                        .toList()
                                                        .indexWhere((element) => element["category"] == "Rest") ==
                                                    -1
                                                ? Color(0xffe2eaff)
                                                : Color(0xffcdede6),
                                          ),
                                        ),
                                  selectedDay.value == index
                                      ? Container(
                                          padding: EdgeInsets.all(sx(10)),
                                          child: SvgPicture.asset(
                                            "assets/StatusIcon/diary_today.svg",
                                          ),
                                        )
                                      : SizedBox(),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      ((index - todayMonth.value.weekday) + 1).toString(),
                                      style: TextStyle(
                                        color: todayMonth.value.year == DateTime.now().year &&
                                                todayMonth.value.month == DateTime.now().month &&
                                                (index - todayMonth.value.weekday) + 1 == DateTime.now().day
                                            ? Color(0xff084bff)
                                            : DateTime(DateTime.now().year, month.value, (index - todayMonth.value.weekday) + 1).weekday ==
                                                        6 ||
                                                    DateTime(DateTime.now().year, month.value, (index - todayMonth.value.weekday) + 1)
                                                            .weekday ==
                                                        7
                                                ? Color(0xffd8d8d8)
                                                : selectedDay.value == index
                                                    ? userData.user.value.diary.indexWhere((element) => element["date"].contains(
                                                                "${DateTime(DateTime.now().year, month.value, (index - todayMonth.value.weekday) + 1).year}-${NumberFormat("00", "en_US").format(DateTime(DateTime.now().year, month.value, (index - todayMonth.value.weekday) + 1).month)}-${NumberFormat("00", "en_US").format(DateTime(DateTime.now().year, month.value, (index - todayMonth.value.weekday) + 1).day)}")) ==
                                                            -1
                                                        ? Colors.black
                                                        : Colors.white
                                                    : Colors.black,
                                        fontSize: sx(20),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                ],
                              )));
                        } else {
                          return Container(
                            decoration: BoxDecoration(),
                          );
                        }
                      }))))
        ],
      ),
    );
  }
}
