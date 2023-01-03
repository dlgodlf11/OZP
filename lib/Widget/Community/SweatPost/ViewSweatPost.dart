import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:sweatbox2dot0/Controller/PostController.dart';
import 'package:sweatbox2dot0/Controller/UserDataController.dart';
import 'package:sweatbox2dot0/Services/database.dart';
import 'package:sweatbox2dot0/Widget/Community/SweatPost/SweatPostEditor.dart';
import 'package:sweatbox2dot0/Widget/Community/SweatPost/addCoComment.dart';

class ViewSweatPost extends StatelessWidget {
  int postIndex;
  var postController = Get.put(PostController());
  TextEditingController commentText = new TextEditingController();
  var userData = Get.put(UserController());
  ScrollController photoScrollController = new ScrollController();
  RxDouble scrollOffset = 0.0.obs;
  Rx<List<QueryDocumentSnapshot<Map<String, dynamic>>>> otherUsersData = Rx<List<QueryDocumentSnapshot<Map<String, dynamic>>>>([]);
  RxString profileImage = "".obs;
  ViewSweatPost({required this.postIndex}) {
    postController.postList.value.forEach((element) {
      print("씨발" + element.post);
    });

    Database().increaseView(postid: postController.postList.value[postIndex].id);
    Database().getOtherUserProfile().then((value) {
      otherUsersData.value = value;
      var writerData = otherUsersData.value.where((element) => element.id == postController.postList.value[postIndex].writer);
      if (writerData.length != 0) {
        if (writerData.first.data()["profileimage"] != null) profileImage.value = writerData.first.data()["profileimage"];
        print(writerData.first.data()["profileimage"]);
        print("쒸발");
      }
    });
  }
  FocusNode textfieldFocus = new FocusNode();
  String commentTextFieldState = "add";
  int? commentIndex = null;
  @override
  Widget build(BuildContext context) {
    //print(postController.postList.value[postIndex].images);
    // return PageView.builder(itemBuilder: (context, index) {
    //   return Container(
    //     color: Colors.grey[100 * index],
    //   );
    // });
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      photoScrollController.addListener(() {
        scrollOffset.value = photoScrollController.offset / (width * (postController.postList.value[postIndex].images!.length - 1));
      });
      return GestureDetector(
        onTapDown: (value) {
          FocusScope.of(context).requestFocus(FocusNode());
          SystemChrome.setEnabledSystemUIOverlays([]);
        },
        child: Obx(() => Scaffold(
            appBar: AppBar(
              title: Text("스웨트 포스트"),
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: SvgPicture.asset('assets/appbarIcon/btn_back.svg'),
              ),
              actions: [
                PopupMenuButton(
                    tooltip: "프로필메뉴",
                    onSelected: (value) {
                      if (value == 0) {
                        Get.to(() => SweatPostEditor(
                              postData: postController.postList.value[postIndex],
                            ));
                      } else {
                        Database()
                            .removePost(
                                postid: postController.postList.value[postIndex].id,
                                hasphoto: postController.postList.value[postIndex].images!.length == 0 ? false : true)
                            .then((value) => Get.back());
                      }
                    },
                    child: SvgPicture.asset(
                      'assets/postAsset/detail.svg',
                      width: sx(50),
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                            height: 40,
                            value: 0,
                            child: Container(
                              child: Text(
                                '수정하기',
                                style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: 15,
                                  fontFamily: 'AppleSDGothicNeo',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )),
                        PopupMenuItem(
                            height: 40,
                            value: 1,
                            child: Container(
                              child: Text(
                                '삭제하기',
                                style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: 15,
                                  fontFamily: 'AppleSDGothicNeo',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ))
                      ];
                    }),
              ],
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(bottom: sx(80)),
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    postController.postList.value[postIndex].images!.length == 0
                        ? SizedBox()
                        : Container(
                            width: width,
                            height: width,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                ListView.builder(
                                    controller: photoScrollController,
                                    scrollDirection: Axis.horizontal,
                                    physics: PageScrollPhysics(),
                                    itemCount: postController.postList.value[postIndex].images!.length,
                                    itemBuilder: (context, index) {
                                      print(
                                        postController.postList.value[postIndex].title,
                                      );
                                      print("제발..나 힘들다");
                                      return InkWell(
                                          onTap: () async {},
                                          child: Container(
                                              width: width,
                                              height: width,
                                              decoration: BoxDecoration(color: Color(0xff326aff)),
                                              child: Image(
                                                  image: FirebaseImage(
                                                postController.postList.value[postIndex].images![index],
                                              ))));
                                    }),
                                Positioned(
                                    bottom: 0,
                                    child: Container(
                                      width: width,
                                      height: sx(10),
                                      child: Obx(() => LinearProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xfffd851a)),
                                            backgroundColor: Colors.white,
                                            value: scrollOffset.value,
                                          )),
                                    ))
                              ],
                            )),
                    Container(
                      padding: EdgeInsets.all(sx(25)),
                      child: Text(
                        postController.postList.value[postIndex].title,
                        style: TextStyle(fontSize: sx(30), fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: sx(25)),
                      height: sx(70),
                      child: Row(
                        children: [
                          Obx(
                            () => CircleAvatar(
                              radius: sx(45),
                              backgroundImage: profileImage.value == "" ? null : FirebaseImage(profileImage.value),
                            ),
                          ),
                          SizedBox(
                            width: sx(20),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                postController.postList.value[postIndex].writerNickname,
                                style: TextStyle(fontSize: sx(25), fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: sx(10),
                              ),
                              Text(
                                postController.postList.value[postIndex].id.split(" ")[0].replaceAll("-", ". ") +
                                    " " +
                                    postController.postList.value[postIndex].id.split(" ")[1].split(":")[0] +
                                    ":" +
                                    postController.postList.value[postIndex].id.split(" ")[1].split(":")[1] +
                                    (postController.postList.value[postIndex].updated ? '    (수정됨)' : ''),
                                style: TextStyle(fontSize: sx(15), fontWeight: FontWeight.w300),
                              ),

                              // postController.postList.value[postIndex].writer == userData.user.value.email
                              //     ? InkWell(
                              //         onTap: () {
                              //           Get.to(() => SweatPostEditor(
                              //                 postData: postController.postList.value[postIndex],
                              //               ));
                              //         },
                              //         child: Text("수정 테스트버튼"))
                              //     : SizedBox(),
                              // postController.postList.value[postIndex].writer == userData.user.value.email
                              //     ? InkWell(
                              //         onTap: () {
                              //           Database()
                              //               .removePost(
                              //                   postid: postController.postList.value[postIndex].id,
                              //                   hasphoto: postController.postList.value[postIndex].images!.length == 0 ? false : true)
                              //               .then((value) => Get.back());
                              //         },
                              //         child: Text("삭제 테스트버튼"))
                              //     : SizedBox(),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: sx(20),
                    ),
                    Container(
                      padding: EdgeInsets.all(sx(25)),
                      child: Text(
                        postController.postList.value[postIndex].post,
                        style: TextStyle(fontSize: sx(25), fontWeight: FontWeight.w500, color: Color(0xff535353)),
                      ),
                    ),
                    postController.postList.value[postIndex].tag!.length == 0
                        ? SizedBox()
                        : Container(
                            width: width,
                            height: sx(40),
                            padding: EdgeInsets.only(bottom: sx(10), left: sx(20), right: sx(20)),
                            child: ListView.builder(
                                itemCount: postController.postList.value[postIndex].tag!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  try {
                                    return Container(
                                        margin: EdgeInsets.only(right: sx(20)),
                                        child: Text(
                                          "#" + postController.postList.value[postIndex].tag![index],
                                          style: TextStyle(color: Color(0xff0046ff), fontSize: sx(20)),
                                        ));
                                  } catch (e) {
                                    print(e);
                                    postController.postList.value.forEach((element) {
                                      print(element.id);
                                      print(element.tag);
                                    });
                                    return SizedBox();
                                  }
                                }),
                          ),
                    SizedBox(
                      height: sx(10),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: sx(20)),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Database().dropPost(postid: postController.postList.value[postIndex].id);
                              if (userData.user.value.dropedPost!
                                      .indexWhere((element) => element == postController.postList.value[postIndex].id) ==
                                  -1) {
                                postController.postlottiecontroller!.forward();
                              } else {
                                postController.postlottiecontroller!.reverse();
                              }
                            },
                            child: Container(
                                child: Row(
                              children: [
                                Container(
                                    width: sx(35),
                                    height: sx(35),
                                    child: Obx(
                                      () => Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/postAsset/drop.svg',
                                            color: postController.postList.value[postIndex].drop
                                                        .indexWhere((element) => element == userData.user.value.email!) ==
                                                    -1
                                                ? Color(0xff707070)
                                                : Color(0xff0046ff),
                                            width: sx(35),
                                          ),
                                          LottieBuilder.asset(
                                            'assets/postAsset/DSCswbx_drop.json',
                                            width: sx(25),
                                            repeat: false,
                                            controller: postController.postlottiecontroller,
                                            onLoaded: (composition) {
                                              postController.postlottiecontroller!.duration = composition.duration;
                                              postController.postlottiecontroller!.reset();
                                            },
                                          )
                                        ],
                                      ),
                                    )),
                                SizedBox(
                                  width: sx(10),
                                ),
                                Text(
                                  postController.postList.value[postIndex].drop.length.toString(),
                                  style: TextStyle(fontSize: sx(20), fontWeight: FontWeight.w300, color: Color(0xff707070)),
                                )
                              ],
                            )),
                          ),
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
                                postController.postList.value[postIndex].views.toString(),
                                style: TextStyle(fontSize: sx(20), fontWeight: FontWeight.w300, color: Color(0xff707070)),
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
                                'assets/postAsset/reply.svg',
                                width: sx(35),
                              ),
                              SizedBox(
                                width: sx(10),
                              ),
                              Text(
                                postController.postList.value[postIndex].comments.length.toString(),
                                style: TextStyle(fontSize: sx(20), fontWeight: FontWeight.w300, color: Color(0xff707070)),
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: sx(20),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        color: Colors.grey[100],
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
                    Builder(builder: (context) {
                      try {
                        return InkWell(
                          onTap: () {
                            print("object");
                            Get.back();
                            Get.to(() => ViewSweatPost(postIndex: postIndex - 1), transition: Transition.fade);
                          },
                          child: Container(
                            padding: EdgeInsets.all(sx(20)),
                            alignment: Alignment.centerLeft,
                            width: width,
                            height: sx(70),
                            color: Colors.grey[200],
                            child: Row(children: [
                              Text("다음글"),
                              SizedBox(
                                width: sx(20),
                              ),
                              Container(
                                width: sx(300),
                                child: Text(
                                  postController.postList.value[postIndex - 1].title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ]),
                          ),
                        );
                      } catch (e) {
                        return SizedBox();
                      }
                    }),
                    Builder(builder: (context) {
                      try {
                        return InkWell(
                          onTap: () {
                            Get.back();
                            Get.to(() => ViewSweatPost(postIndex: postIndex + 1), transition: Transition.fade);
                          },
                          child: Container(
                            padding: EdgeInsets.all(sx(20)),
                            alignment: Alignment.centerLeft,
                            width: width,
                            height: sx(70),
                            color: Colors.grey[200],
                            child: Row(children: [
                              Text("이전글"),
                              SizedBox(
                                width: sx(20),
                              ),
                              Container(
                                width: sx(300),
                                child: Text(
                                  postController.postList.value[postIndex + 1].title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ]),
                          ),
                        );
                      } catch (e) {
                        return SizedBox();
                      }
                    }),
                    Column(children: [
                      for (int i = 0; i < postController.postList.value[postIndex].comments.length; i++)
                        Hero(
                            tag: "comment${i}",
                            child: Material(
                                child: Column(
                              children: [
                                Builder(builder: (context) {
                                  return Container(
                                    padding: EdgeInsets.only(
                                      top: sx(20),
                                      left: sx(20),
                                      right: sx(20),
                                    ),
                                    decoration: BoxDecoration(border: Border.all(width: 0.1)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              postController.postList.value[postIndex].comments[i]["writernickname"],
                                              style: TextStyle(fontSize: sx(15), color: Color(0xff242424)),
                                            ),
                                            SizedBox(
                                              width: sx(30),
                                            ),
                                            Text(
                                              Database().changeTime(postController.postList.value[postIndex].comments[i]["date"]),
                                              style: TextStyle(fontSize: sx(15), color: Color(0xff242424)),
                                            ),
                                            Text(
                                              postController.postList.value[postIndex].comments[i]["updated"] ? "    (수정됨)" : "",
                                              style: TextStyle(fontSize: sx(15), color: Color(0xff242424)),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: sx(15),
                                        ),
                                        Text(
                                          postController.postList.value[postIndex].comments[i]["text"],
                                          style: TextStyle(fontSize: sx(20), fontWeight: FontWeight.w700),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextButton(
                                                style: TextButton.styleFrom(padding: EdgeInsets.all(0), minimumSize: Size(sx(50), sx(30))),
                                                onPressed: () {
                                                  Get.to(
                                                      () => AddCoComment(
                                                            postIndex: postIndex,
                                                            commentIndex: i,
                                                            heroText: "comment${i}",
                                                          ),
                                                      duration: Duration(seconds: 1));
                                                },
                                                child:
                                                    Text("댓글달기", style: TextStyle(color: Color(0xff707070), fontWeight: FontWeight.w800))),
                                            Container(
                                                child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Database()
                                                        .dropComment(
                                                            postid: postController.postList.value[postIndex].id,
                                                            commentIndex: i,
                                                            allCommentData: postController.postList.value[postIndex].comments)
                                                        .then((value) {
                                                      print(value);
                                                      if (value) {
                                                        postController.commentlottiecontroller!.forward();
                                                      } else {
                                                        postController.commentlottiecontroller!.reverse();
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                      child: Row(
                                                    children: [
                                                      Container(
                                                          width: sx(35),
                                                          height: sx(35),
                                                          child: Obx(
                                                            () => Stack(
                                                              alignment: Alignment.center,
                                                              children: [
                                                                SvgPicture.asset(
                                                                  'assets/postAsset/drop.svg',
                                                                  color: postController.postList.value[postIndex].comments[i]["drops"]
                                                                              .indexWhere(
                                                                                  (element) => element == userData.user.value.email!) ==
                                                                          -1
                                                                      ? Color(0xff707070)
                                                                      : Color(0xff0046ff),
                                                                  width: sx(35),
                                                                ),
                                                                LottieBuilder.asset(
                                                                  'assets/postAsset/DSCswbx_drop.json',
                                                                  width: sx(25),
                                                                  repeat: false,
                                                                  controller: postController.commentlottiecontroller,
                                                                  onLoaded: (composition) {
                                                                    postController.commentlottiecontroller!.duration = composition.duration;
                                                                    postController.commentlottiecontroller!.reset();
                                                                  },
                                                                )
                                                              ],
                                                            ),
                                                          )),
                                                      SizedBox(
                                                        width: sx(10),
                                                      ),
                                                      Text(
                                                        postController.postList.value[postIndex].comments[i]["drops"].length.toString(),
                                                        style: TextStyle(
                                                            fontSize: sx(20), fontWeight: FontWeight.w300, color: Color(0xff707070)),
                                                      )
                                                    ],
                                                  )),
                                                ),
                                                SizedBox(
                                                  width: sx(10),
                                                ),
                                                postController.postList.value[postIndex].comments[i]["writeremail"] ==
                                                        userData.user.value.email
                                                    ? TextButton(
                                                        style: TextButton.styleFrom(
                                                            padding: EdgeInsets.all(0), minimumSize: Size(sx(50), sx(30))),
                                                        onPressed: () {
                                                          Database().removeComment(
                                                              postid: postController.postList.value[postIndex].id,
                                                              commentData: postController.postList.value[postIndex].comments[i]);
                                                        },
                                                        child: Text("삭제",
                                                            style: TextStyle(color: Color(0xff707070), fontWeight: FontWeight.w800)))
                                                    : SizedBox(),
                                                postController.postList.value[postIndex].comments[i]["writeremail"] ==
                                                        userData.user.value.email
                                                    ? TextButton(
                                                        style: TextButton.styleFrom(
                                                            padding: EdgeInsets.all(0), minimumSize: Size(sx(50), sx(30))),
                                                        onPressed: () {
                                                          print("object");
                                                          commentTextFieldState = "update";
                                                          commentIndex = i;
                                                          commentText.text = postController.postList.value[postIndex].comments[i]["text"];
                                                          FocusScope.of(context).requestFocus(textfieldFocus);
                                                        },
                                                        child: Text("수정",
                                                            style: TextStyle(color: Color(0xff707070), fontWeight: FontWeight.w800)))
                                                    : SizedBox(),
                                              ],
                                            )),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                }),
                                for (int j = 0; j < postController.postList.value[postIndex].comments[i]['cocomment'].length; j++)
                                  Container(
                                      padding: EdgeInsets.only(
                                        top: sx(20),
                                        left: sx(20),
                                        right: sx(20),
                                      ),
                                      width: width,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 0.1),
                                        color: Color(0xfffafafa),
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/postAsset/re_reply.svg',
                                            width: sx(50),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      postController.postList.value[postIndex].comments[i]['cocomment'][j]
                                                          ["writernickname"],
                                                      style: TextStyle(fontSize: sx(15), color: Color(0xff242424)),
                                                    ),
                                                    SizedBox(
                                                      width: sx(30),
                                                    ),
                                                    Text(
                                                      Database().changeTime(
                                                          postController.postList.value[postIndex].comments[i]['cocomment'][j]['date']),
                                                      style: TextStyle(fontSize: sx(15), color: Color(0xff242424)),
                                                    ),
                                                    Text(
                                                      postController.postList.value[postIndex].comments[i]['cocomment'][j]['updated']
                                                          ? "   (수정됨)"
                                                          : "",
                                                      style: TextStyle(fontSize: sx(15), color: Color(0xff242424)),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: sx(15),
                                                ),
                                                Text(
                                                  postController.postList.value[postIndex].comments[i]['cocomment'][j]["text"],
                                                  style: TextStyle(fontSize: sx(20), fontWeight: FontWeight.w700),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                        padding: EdgeInsets.only(bottom: sx(20)),
                                                        child: Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                Database()
                                                                    .dropCoComment(
                                                                        postid: postController.postList.value[postIndex].id,
                                                                        commentIndex: i,
                                                                        allCommentData: postController.postList.value[postIndex].comments,
                                                                        cocommentIndex: j)
                                                                    .then((value) {
                                                                  if (value) {
                                                                    postController.cocommentlottiecontroller!.forward();
                                                                  } else {
                                                                    postController.cocommentlottiecontroller!.reverse();
                                                                  }
                                                                });
                                                              },
                                                              child: Container(
                                                                  child: Row(
                                                                children: [
                                                                  Container(
                                                                      width: sx(35),
                                                                      height: sx(35),
                                                                      child: Obx(
                                                                        () => SvgPicture.asset(
                                                                          'assets/postAsset/drop.svg',
                                                                          color: postController.postList.value[postIndex]
                                                                                      .comments[i]['cocomment'][j]["drops"]
                                                                                      .indexWhere((element) =>
                                                                                          element == userData.user.value.email!) ==
                                                                                  -1
                                                                              ? Color(0xff707070)
                                                                              : Color(0xff0046ff),
                                                                          width: sx(35),
                                                                        ),
                                                                      )),
                                                                  SizedBox(
                                                                    width: sx(10),
                                                                  ),
                                                                  Text(
                                                                    postController.postList.value[postIndex]
                                                                        .comments[i]['cocomment'][j]["drops"].length
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize: sx(20),
                                                                        fontWeight: FontWeight.w300,
                                                                        color: Color(0xff707070)),
                                                                  )
                                                                ],
                                                              )),
                                                            ),
                                                            SizedBox(
                                                              width: sx(10),
                                                            ),
                                                            postController.postList.value[postIndex].comments[i]['cocomment'][j]
                                                                        ["writeremail"] ==
                                                                    userData.user.value.email
                                                                ? TextButton(
                                                                    style: TextButton.styleFrom(
                                                                        padding: EdgeInsets.all(0), minimumSize: Size(sx(50), sx(30))),
                                                                    onPressed: () {
                                                                      Database().removeCoComment(
                                                                          cocommentIndex: j,
                                                                          postid: postController.postList.value[postIndex].id,
                                                                          commentIndex: i,
                                                                          allCommentData:
                                                                              postController.postList.value[postIndex].comments);
                                                                    },
                                                                    child: Text("삭제",
                                                                        style: TextStyle(
                                                                            color: Color(0xff707070), fontWeight: FontWeight.w800)))
                                                                : SizedBox(),
                                                            postController.postList.value[postIndex].comments[i]['cocomment'][j]
                                                                        ["writeremail"] ==
                                                                    userData.user.value.email
                                                                ? TextButton(
                                                                    style: TextButton.styleFrom(
                                                                        padding: EdgeInsets.all(0), minimumSize: Size(sx(50), sx(30))),
                                                                    onPressed: () {
                                                                      Get.to(
                                                                          () => AddCoComment(
                                                                                postIndex: postIndex,
                                                                                commentIndex: i,
                                                                                cocommentIndex: j,
                                                                                heroText: "comment${i}",
                                                                              ),
                                                                          duration: Duration(seconds: 1));
                                                                    },
                                                                    child: Text("수정",
                                                                        style: TextStyle(
                                                                            color: Color(0xff707070), fontWeight: FontWeight.w800)))
                                                                : SizedBox(),
                                                          ],
                                                        )),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ))
                                // Container(
                                //   padding: EdgeInsets.only(
                                //     top: sx(20),
                                //     left: sx(40),
                                //     right: sx(20),
                                //   ),
                                //   decoration: BoxDecoration(
                                //     border: Border.all(width: 0.1),
                                //     color: Colors.grey[300],
                                //   ),
                                //   child: Column(
                                //     crossAxisAlignment: CrossAxisAlignment.start,
                                //     children: [
                                //       Row(
                                //         children: [
                                //           Text(postController.postList.value[postIndex].comments[i]['cocomment'][j]["writernickname"]),
                                //           SizedBox(
                                //             width: sx(30),
                                //           ),
                                //           Text(Database()
                                //               .changeTime(postController.postList.value[postIndex].comments[i]['cocomment'][j]['date'])),
                                //           Text(postController.postList.value[postIndex].comments[i]['cocomment'][j]['updated']
                                //               ? "    (수정됨)"
                                //               : "")
                                //         ],
                                //       ),
                                //       SizedBox(
                                //         height: sx(30),
                                //       ),
                                //       Text(postController.postList.value[postIndex].comments[i]['cocomment'][j]["text"]),
                                //       Row(
                                //         mainAxisAlignment: MainAxisAlignment.end,
                                //         children: [
                                //           Container(
                                //               child: Row(
                                //             children: [
                                //               InkWell(
                                //                 onTap: () {
                                //                   Database().dropCoComment(
                                //                       postid: postController.postList.value[postIndex].id,
                                //                       commentIndex: i,
                                //                       allCommentData: postController.postList.value[postIndex].comments,
                                //                       cocommentIndex: j);
                                //                 },
                                //                 child: Row(
                                //                   children: [
                                //                     Icon(
                                //                       Icons.thumb_up,
                                //                       size: sx(20),
                                //                     ),
                                //                     SizedBox(
                                //                       width: sx(10),
                                //                     ),
                                //                     Text(
                                //                       postController.postList.value[postIndex].comments[i]['cocomment'][j]["drops"].length
                                //                           .toString(),
                                //                       style: TextStyle(fontSize: sx(15), fontWeight: FontWeight.w300),
                                //                     ),
                                //                   ],
                                //                 ),
                                //               ),
                                //               SizedBox(
                                //                 width: sx(10),
                                //               ),
                                //               postController.postList.value[postIndex].comments[i]['cocomment'][j]["writeremail"] ==
                                //                       userData.user.value.email
                                //                   ? TextButton(
                                //                       style: TextButton.styleFrom(
                                //                           padding: EdgeInsets.all(0), minimumSize: Size(sx(50), sx(30))),
                                //                       onPressed: () {
                                //                         Database().removeCoComment(
                                //                             cocommentIndex: j,
                                //                             postid: postController.postList.value[postIndex].id,
                                //                             commentIndex: i,
                                //                             allCommentData: postController.postList.value[postIndex].comments);
                                //                       },
                                //                       child: Text("삭제", style: TextStyle(color: Colors.black)))
                                //                   : SizedBox(),
                                //               postController.postList.value[postIndex].comments[i]['cocomment'][j]["writeremail"] ==
                                //                       userData.user.value.email
                                //                   ? TextButton(
                                //                       style: TextButton.styleFrom(
                                //                           padding: EdgeInsets.all(0), minimumSize: Size(sx(50), sx(30))),
                                //                       onPressed: () {
                                //                         Get.to(
                                //                             () => AddCoComment(
                                //                                   postIndex: postIndex,
                                //                                   commentIndex: i,
                                //                                   cocommentIndex: j,
                                //                                   heroText: "comment${i}",
                                //                                 ),
                                //                             duration: Duration(seconds: 1));
                                //                       },
                                //                       child: Text("수정", style: TextStyle(color: Colors.black)))
                                //                   : SizedBox(),
                                //             ],
                                //           )),
                                //         ],
                                //       )
                                //     ],
                                //   ),
                                // )
                              ],
                            )))
                    ])
                  ],
                ),
              ),
            ),
            bottomSheet: Container(
                width: width,
                height: sx(70),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: commentText,
                        textAlign: TextAlign.left,
                        maxLength: 100,
                        focusNode: textfieldFocus,
                        maxLines: null,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Color(0xffb4b4b4))),
                            filled: true,
                            counterText: "",
                            isDense: true,
                            fillColor: Colors.grey[200],
                            errorStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Colors.red)),
                            labelText: "  부드러운 댓글로 의견 남겨주세요!",
                            // hintStyle: TextStyle(
                            //     color: Color(0xffb4b4b4),
                            //     fontWeight: FontWeight.w300,
                            //     fontFamily: "AppleSDGothicNeo",
                            //     fontStyle: FontStyle.normal,
                            //     fontSize: sx(15)),
                            labelStyle:
                                TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal, fontSize: sx(20))),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        SystemChrome.setEnabledSystemUIOverlays([]);
                        if (commentTextFieldState == "add") {
                          if (commentText.text != "") {
                            Database()
                                .addComment(comment: commentText.text, postid: postController.postList.value[postIndex].id)
                                .then((value) => commentText.clear());
                          }
                        } else {
                          if (commentText.text != "") {
                            Database()
                                .updateComment(
                                    comment: commentText.text,
                                    postid: postController.postList.value[postIndex].id,
                                    commentIndex: commentIndex!,
                                    allCommentData: postController.postList.value[postIndex].comments)
                                .then((value) => commentText.clear());
                            commentTextFieldState = "add";
                          }
                        }
                      },
                      child: Container(
                          color: Color(0xff0046ff),
                          child: SvgPicture.asset(
                            "assets/postAsset/write.svg",
                            color: Colors.white,
                          )),
                    )
                  ],
                )))),
      );
    });
  }
}
