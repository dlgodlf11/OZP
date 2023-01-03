import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:sweatbox2dot0/Controller/AuthController.dart';
import 'package:sweatbox2dot0/Models/UserModel.dart';
import 'package:sweatbox2dot0/Services/database.dart';

class UserController extends GetxController {
  RxInt at = 0.obs;
  Rx<UserModel> _userModel = UserModel().obs;

  Rx<UserModel> get user => _userModel;
  set user(Rx<UserModel> value) => this._userModel.value = value.value;

  void clear() {
    _userModel.value = UserModel();
  }

  Future<dynamic> getRandomWod() async {
    Database().useRandomCoin();

    if (user.value.wodfilter!.length == 0) {
      DocumentSnapshot<Map<String, dynamic>> wods = await FirebaseFirestore.instance
          .collection("Wods")
          .doc(user.value.wodFilters[Random().nextInt(user.value.wodFilters.length)])
          .get();
      var wodindex = Random().nextInt(wods.data()!.keys.length);
      wods.data()![wods.data()!.keys.toList()[wodindex]].removeWhere((element) => element["name"] == "");
      return {
        "category": wods.id,
        "title": wods.data()!.keys.toList()[wodindex],
        "wods": wods.data()![wods.data()!.keys.toList()[wodindex]]
      };
    } else {
      DocumentSnapshot<Map<String, dynamic>> wods = await FirebaseFirestore.instance
          .collection("Wods")
          .doc(user.value.wodfilter![Random().nextInt(user.value.wodfilter!.length)])
          .get();
      var wodindex = Random().nextInt(wods.data()!.keys.length);
      wods.data()![wods.data()!.keys.toList()[wodindex]].removeWhere((element) => element["name"] == "");
      return {
        "category": wods.id,
        "title": wods.data()!.keys.toList()[wodindex],
        "wods": wods.data()![wods.data()!.keys.toList()[wodindex]]
      };
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    ever(_userModel, (asdf) {
      print(asdf);
    });
    super.onInit();
  }
}
