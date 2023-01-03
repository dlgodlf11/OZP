import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:sweatbox2dot0/Controller/UserDataController.dart';
import 'package:sweatbox2dot0/Services/database.dart';

class ShowAllRecord extends StatelessWidget {
  Rx<List<QueryDocumentSnapshot<Map<String, dynamic>>>> pr = Rx<List<QueryDocumentSnapshot<Map<String, dynamic>>>>([]);
  List<dynamic> sortedList = [];
  String type = "Weight";
  String prName = "";
  Rx<List<QueryDocumentSnapshot<Map<String, dynamic>>>> otherUsersData = Rx<List<QueryDocumentSnapshot<Map<String, dynamic>>>>([]);
  UserController userData = Get.put(UserController());

  ShowAllRecord({required this.pr, required this.type, required this.prName}) {
    Database().getOtherUserProfile().then((value) {
      otherUsersData.value = value;
    });
    var prData = pr.value.where((element) => element.data().containsKey(prName));
    if (prData.length != 0) {
      sortedList = prData.first.data()[prName];
      if (type == "Weight") {
        sortedList.sort((a, b) => double.parse(b.split("kg")[0]).compareTo(double.parse(a.split("kg")[0])));
      } else if (type == "Reps") {
        sortedList.sort((a, b) => int.parse(b.split("/")[0]).compareTo(int.parse(a.split("/")[0])));
      } else {
        sortedList.sort((a, b) => int.parse(a.split("/")[0]).compareTo(int.parse(b.split("/")[0])));
      }
    }
    print("print in Show all personal record");
    print(sortedList);
  }
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
          appBar: AppBar(
            title: Text("스웨트 랭커 모두보기"),
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: SvgPicture.asset('assets/appbarIcon/btn_back.svg'),
            ),
          ),
          body: Container(
            width: width,
            height: height,
            child: Obx(() => Column(
                  children: [
                    Row(
                      children: [showTopRanker(rank: 0, sx: sx), showTopRanker(rank: 1, sx: sx), showTopRanker(rank: 2, sx: sx)],
                    ),
                    SizedBox(
                      height: sx(20),
                    ),
                    Divider(
                      thickness: sx(30),
                    ),
                    Expanded(child: ListView.builder(itemBuilder: (context, index) {
                      return showRankList(rank: index + 3, sx: sx);
                    }))
                  ],
                )),
          ));
    });
  }

  showRankList({required int rank, required double Function(double) sx}) {
    if (otherUsersData.value.length == 0) {
      return Container(child: Text("아이고 로딩중입니다"));
    }
    if (sortedList.length >= rank + 1) {
      var rankerData = otherUsersData.value.where((element) => element.id == sortedList[rank].split("/")[1]);
      if (rankerData.length == 0) {
        return Container(
          child: Row(
            children: [Text((rank + 1).toString()), Text("이젠 없는 그 사람"), Text(changeText(text: sortedList[rank], type: type))],
          ),
        );
      } else {
        return Container(
          child: Row(
            children: [
              Text((rank + 1).toString()),
              Text(rankerData.first.data()["nickname"]),
              Text(changeText(text: sortedList[rank], type: type))
            ],
          ),
        );
      }
    } else {
      return Container(
        child: Row(
          children: [Text((rank + 1).toString()), Text("공석"), Text("")],
        ),
      );
    }
  }

  showTopRanker({required int rank, required double Function(double) sx}) {
    if (otherUsersData.value.length == 0) {
      return Container(child: Text("아이고 로딩중입니다"));
    }
    if (sortedList.length >= rank + 1) {
      var rankerData = otherUsersData.value.where((element) => element.id == sortedList[rank].split("/")[1]);
      if (rankerData.length == 0) {
        return Container(
          child: Column(
            children: [
              CircleAvatar(
                child: Text((rank + 1).toString()),
              ),
              CircleAvatar(
                radius: sx(80),
              ),
              Text("그가 떠난 자리에는\n 땀자국만 남아있습니다.")
            ],
          ),
        );
      } else {
        return Container(
          child: Column(
            children: [
              CircleAvatar(
                child: Text((rank + 1).toString()),
              ),
              CircleAvatar(
                radius: sx(80),
              ),
              Text(rankerData.first.data()["nickname"])
            ],
          ),
        );
      }
    } else {
      return Container(
        child: Column(
          children: [
            CircleAvatar(
              child: Text((rank + 1).toString()),
            ),
            CircleAvatar(
              radius: sx(80),
            ),
            Text("공석")
          ],
        ),
      );
    }
  }

  changeText({required String text, required type}) {
    switch (type) {
      case ("Weight"):
        return "${Database().changeEasyLbKg(value: text.split("kg")[0].toString())} ${userData.user.value.showKg.value ? "kg" : "lb"}";

      case ("Time"):
        int totalTime = int.parse(text.split("/")[0]);
        String result = (totalTime / 60).floor().toString() + "' " + (totalTime % 60).floor().toString() + '"';
        return result;
      case ("Reps"):
        String result = text.split("/")[0] + "회";
        return result;
      case ("Named"):
        int totalTime = int.parse(text.split("/")[0]);
        String result = (totalTime / 60).floor().toString() + "' " + (totalTime % 60).floor().toString() + '"';
        return result;
      default:
    }
  }
}
