import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sweatbox2dot0/Services/database.dart';

class PrController extends GetxController {
  Rx<List<QueryDocumentSnapshot<Map<String, dynamic>>>> prNamed = Rx<List<QueryDocumentSnapshot<Map<String, dynamic>>>>([]);
  Rx<List<QueryDocumentSnapshot<Map<String, dynamic>>>> prWeight = Rx<List<QueryDocumentSnapshot<Map<String, dynamic>>>>([]);
  Rx<List<QueryDocumentSnapshot<Map<String, dynamic>>>> prTime = Rx<List<QueryDocumentSnapshot<Map<String, dynamic>>>>([]);
  Rx<List<QueryDocumentSnapshot<Map<String, dynamic>>>> prReps = Rx<List<QueryDocumentSnapshot<Map<String, dynamic>>>>([]);
  RxList open = [].obs;
  RxString prTypeText = "Weight".obs;

  @override
  void onInit() {
    // TODO: implement onInit

    prNamed.bindStream(Database().prStream(type: "Named"));
    prWeight.bindStream(Database().prStream(type: "Weight"));
    prTime.bindStream(Database().prStream(type: "Time"));
    prReps.bindStream(Database().prStream(type: "Reps"));

    super.onInit();
  }
}
