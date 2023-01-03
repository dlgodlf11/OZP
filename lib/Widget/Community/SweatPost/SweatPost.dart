import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:sweatbox2dot0/Controller/PostController.dart';
import 'package:sweatbox2dot0/Controller/UserDataController.dart';
import 'package:sweatbox2dot0/Services/database.dart';
import 'package:sweatbox2dot0/Widget/Community/SweatPost/SweatPostEditor.dart';
import 'package:sweatbox2dot0/Widget/Community/SweatPost/ViewSweatPost.dart';

class SweatPost extends StatelessWidget {
  var postController = Get.put(PostController());
  var userData = Get.put(UserController());
  SweatPost() {}
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
        appBar: AppBar(
          title: Text("스웨트 포스트"),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset('assets/appbarIcon/btn_back.svg'),
          ),
        ),
        body: Column(
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(sx(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: sx(30),
                    ),
                    SizedBox(
                      width: sx(20),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "광고배너 들어갑니다.",
                          style: TextStyle(fontSize: sx(20), fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: sx(10),
                        ),
                        Text(
                          "바로가기 >",
                          style: TextStyle(fontSize: sx(13), fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: Obx(() => ListView.builder(
                    itemCount: postController.postList.value.length,
                    itemBuilder: (context, index) {
                      return sweatPostView(width: width, sx: sx, index: postController.posts.length - 1 - index);
                    })))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "edit",
          backgroundColor: Color(0xff0046ff),
          child: SvgPicture.asset(
            'assets/postAsset/edit.svg',
            color: Colors.white,
          ),
          onPressed: () {
            Get.to(() => SweatPostEditor());
          },
        ),
      );
    });
  }

  sweatPostView({required double width, required double Function(double) sx, required int index}) {
    return InkWell(
      onTap: () {
        Get.to(() => ViewSweatPost(postIndex: index), transition: Transition.fade);
      },
      child: Container(
        width: width,
        padding: EdgeInsets.all(sx(20)),
        decoration: BoxDecoration(color: index % 2 == 0 ? Colors.white : Color(0xfff7f7f7)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: sx(300),
                  child: Text(
                    postController.postList.value[index].title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: sx(22), fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: sx(10),
            ),
            Text(
              postController.postList.value[index].post,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: sx(18), fontWeight: FontWeight.w300, color: Color(0xff707070)),
            ),
            SizedBox(
              height: sx(10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${postController.postList.value[index].writerNickname}  ${Database().changeTime(postController.postList.value[index].id)}   ${postController.postList.value[index].updated ? '(수정됨)' : ''}",
                  style: TextStyle(fontSize: sx(18), fontWeight: FontWeight.w300, color: Color(0xff707070)),
                ),
                Row(
                  children: [
                    Container(
                        child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/postAsset/drop.svg',
                          width: sx(35),
                        ),
                        SizedBox(
                          width: sx(10),
                        ),
                        Text(
                          postController.postList.value[index].drop.length.toString(),
                          style: TextStyle(color: Color(0xff707070), fontSize: sx(20)),
                        )
                      ],
                    )),
                    SizedBox(
                      width: sx(20),
                    ),
                    Container(
                        child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/postAsset/view.svg',
                          width: sx(35),
                        ),
                        SizedBox(
                          width: sx(10),
                        ),
                        Text(
                          postController.postList.value[index].views.toString(),
                          style: TextStyle(color: Color(0xff707070), fontSize: sx(20)),
                        )
                      ],
                    ))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
