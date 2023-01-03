import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:sweatbox2dot0/Models/PostModel.dart';
import 'package:sweatbox2dot0/Services/database.dart';

class PostController extends GetxController with SingleGetTickerProviderMixin {
  Rx<List<PostModel>> postList = Rx<List<PostModel>>([]);
  List<PostModel> get posts => postList.value;
  AnimationController? postlottiecontroller;
  AnimationController? commentlottiecontroller;
  AnimationController? cocommentlottiecontroller;

  @override
  void onClose() {
    postlottiecontroller!.dispose();
    commentlottiecontroller!.dispose();
    cocommentlottiecontroller!.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    print("씨발 초기화");
    postlottiecontroller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    commentlottiecontroller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    cocommentlottiecontroller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    postList.bindStream(Database().postStream());

    super.onInit();
  }

  increasePostView() {}
}
