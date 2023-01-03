import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:sweatbox2dot0/Controller/PostController.dart';
import 'package:sweatbox2dot0/Controller/UserDataController.dart';
import 'package:sweatbox2dot0/Controller/ViewMainStateController.dart';
import 'package:sweatbox2dot0/Services/database.dart';
import 'package:sweatbox2dot0/Widget/Community/PhysicalData.dart';
import 'package:sweatbox2dot0/Widget/Community/SweatPost/SweatPost.dart';
import 'package:sweatbox2dot0/Widget/Community/SweatPost/ViewSweatPost.dart';

class CommunityPage extends StatelessWidget {
  ScrollController commuScrollController = new ScrollController();
  var postController = Get.put(PostController());
  var viewMainStateController = Get.put(ViewMainStateController());
  var userData = Get.put(UserController());
  CommunityPage() {
    commuScrollController.addListener(() {
      //print(homeScrollController.offset);

      if (commuScrollController.position.userScrollDirection != ScrollDirection.forward) {
        viewMainStateController.showBars.value = false;
      } else {
        viewMainStateController.showBars.value = true;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            padding: EdgeInsets.only(top: viewMainStateController.showBars.value ? sx(70) : 0),
            child: SingleChildScrollView(
              controller: commuScrollController,
              child: Column(
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
                                "공지제목 들어갑니다.",
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
                  Container(
                    padding: EdgeInsets.all(sx(20)),
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "스웨트 매거진",
                              style: TextStyle(fontSize: sx(45), fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "바로가기 >",
                                  style: TextStyle(fontSize: sx(20), fontWeight: FontWeight.bold, color: Colors.black),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: sx(20),
                        ),
                        Container(
                          width: width,
                          height: width * 0.62222222,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: PageScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  width: width - (sx(20) * 2),
                                  height: (width - (sx(20) * 2)) * 0.62222222,
                                  decoration: BoxDecoration(color: Color(0xfface8aa), borderRadius: BorderRadius.all(Radius.circular(20))),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(sx(20)),
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "스웨트 포스트",
                              style: TextStyle(fontSize: sx(45), fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.to(() => SweatPost(), transition: Transition.zoom);
                                },
                                child: Text(
                                  "바로가기 >",
                                  style: TextStyle(fontSize: sx(20), fontWeight: FontWeight.bold, color: Colors.black),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: sx(30),
                        ),
                        Text(
                          "종합 베스트글",
                          style: TextStyle(color: Color(0xff0046bff), fontSize: sx(25), fontWeight: FontWeight.w500),
                        ),
                        Obx(() => Container(
                              width: width - (sx(20) * 2),
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
                              child: Column(
                                children: [
                                  sweatPostRank(width: width, sx: sx, rank: 0),
                                  sweatPostRank(width: width, sx: sx, rank: 1),
                                  sweatPostRank(width: width, sx: sx, rank: 2)
                                ],
                              ),
                            )),
                        Divider(
                          height: sx(30),
                          thickness: sx(10),
                        ),
                        SizedBox(
                          height: sx(20),
                        ),
                        Text(
                          "최신글",
                          style: TextStyle(color: Color(0xff0046bff), fontSize: sx(25), fontWeight: FontWeight.w500),
                        ),
                        Obx(() => Container(
                              width: width - (sx(20) * 2),
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
                              child: Column(
                                children: [
                                  for (int i = 0; i < postController.posts.length; i++)
                                    sweatPostView(width: width, sx: sx, index: postController.posts.length - 1 - i)
                                ],
                              ),
                            )),

                        // Container(
                        //   width: width,
                        //   height: width * 0.62222222,
                        //   child: ListView.builder(
                        //       scrollDirection: Axis.horizontal,
                        //       physics: PageScrollPhysics(),
                        //       itemBuilder: (context, index) {
                        //         return Container(
                        //           width: width - (sx(20) * 2),
                        //           height: (width - (sx(20) * 2)) * 0.62222222,
                        //           decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(20))),
                        //         );
                        //       }),
                        // )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));
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
                    postController.posts[index].title,
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
              postController.posts[index].post,
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
                  "${postController.posts[index].writerNickname}  ${Database().changeTime(postController.posts[index].id)}   ${postController.posts[index].updated ? '(수정됨)' : ''}",
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
                          postController.posts[index].drop.length.toString(),
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
                          postController.posts[index].views.toString(),
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

  sweatPostRank({required double width, required double Function(double) sx, required int rank}) {
    var rankPost = postController.postList.value.toList();
    rankPost.sort((a, b) => b.drop.length.compareTo(a.drop.length));
    print(postController.postList.value.indexWhere((element) => element.id == rankPost[rank].id));
    return InkWell(
      onTap: () {
        Get.to(() => ViewSweatPost(postIndex: postController.postList.value.indexWhere((element) => element.id == rankPost[rank].id)),
            transition: Transition.fade);
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: sx(25), vertical: sx(10)),
          width: width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "${rank + 1}",
                    style: TextStyle(color: Color(0xff0046ff), fontSize: sx(25), fontWeight: FontWeight.w700),
                  ),
                  SizedBox(width: sx(20)),
                  Text(
                    rankPost[rank].title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xff707070),
                      fontSize: sx(25),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        rankPost[rank].writerNickname,
                        style: TextStyle(
                          color: Color(0xffa0a0a0),
                          fontSize: sx(20),
                        ),
                      ),
                      SizedBox(
                        width: sx(15),
                      ),
                      Text(
                        Database().changeTime(rankPost[rank].id),
                        style: TextStyle(
                          color: Color(0xffa0a0a0),
                          fontSize: sx(20),
                        ),
                      ),
                    ],
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
                            rankPost[rank].drop.length.toString(),
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
                            rankPost[rank].views.toString(),
                            style: TextStyle(color: Color(0xff707070), fontSize: sx(20)),
                          )
                        ],
                      ))
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}
