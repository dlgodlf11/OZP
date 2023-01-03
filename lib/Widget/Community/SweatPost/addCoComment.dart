import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:sweatbox2dot0/Controller/PostController.dart';
import 'package:sweatbox2dot0/Controller/UserDataController.dart';
import 'package:sweatbox2dot0/Services/database.dart';

class AddCoComment extends StatelessWidget {
  String? heroText;
  int postIndex;
  int commentIndex;
  var postController = Get.put(PostController());
  TextEditingController cocommentText = new TextEditingController();
  var userData = Get.put(UserController());
  String cocommentTextFieldState = "add";
  int? cocommentIndex = null;
  AddCoComment({this.heroText, required this.postIndex, required this.commentIndex, this.cocommentIndex});
  FocusNode textfieldFocus = new FocusNode();
  @override
  Widget build(BuildContext context) {
    if (cocommentIndex != null) {
      cocommentTextFieldState = "update";
      cocommentIndex = cocommentIndex;
      cocommentText.text = postController.postList.value[postIndex].comments[commentIndex]['cocomment'][cocommentIndex]["text"];
      FocusScope.of(context).requestFocus(textfieldFocus);
    }
    return GestureDetector(
      onTapDown: (value) {
        FocusScope.of(context).requestFocus(FocusNode());
        SystemChrome.setEnabledSystemUIOverlays([]);
        cocommentTextFieldState = "add";
        cocommentIndex = null;
      },
      child: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          return Obx(() => Scaffold(
              appBar: AppBar(
                title: Text("댓글 달기"),
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
                padding: EdgeInsets.only(bottom: sx(80)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Hero(
                          tag: heroText!,
                          child: Material(
                            child: Container(
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
                                        postController.postList.value[postIndex].comments[commentIndex]["writernickname"],
                                        style: TextStyle(fontSize: sx(15), color: Color(0xff242424)),
                                      ),
                                      SizedBox(
                                        width: sx(30),
                                      ),
                                      Text(
                                        Database().changeTime(postController.postList.value[postIndex].comments[commentIndex]["date"]),
                                        style: TextStyle(fontSize: sx(15), color: Color(0xff242424)),
                                      ),
                                      Text(
                                        postController.postList.value[postIndex].comments[commentIndex]["updated"] ? "    (수정됨)" : "",
                                        style: TextStyle(fontSize: sx(15), color: Color(0xff242424)),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: sx(15),
                                  ),
                                  Text(
                                    postController.postList.value[postIndex].comments[commentIndex]["text"],
                                    style: TextStyle(fontSize: sx(20), fontWeight: FontWeight.w700),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                          style: TextButton.styleFrom(padding: EdgeInsets.all(0), minimumSize: Size(sx(50), sx(30))),
                                          onPressed: () {},
                                          child: Text("댓글달기", style: TextStyle(color: Color(0xff707070), fontWeight: FontWeight.w800))),
                                      Container(
                                          child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Database()
                                                  .dropComment(
                                                      postid: postController.postList.value[postIndex].id,
                                                      commentIndex: commentIndex,
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
                                                            color: postController.postList.value[postIndex].comments[commentIndex]["drops"]
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
                                                  postController.postList.value[postIndex].comments[commentIndex]["drops"].length
                                                      .toString(),
                                                  style: TextStyle(fontSize: sx(20), fontWeight: FontWeight.w300, color: Color(0xff707070)),
                                                )
                                              ],
                                            )),
                                          ),
                                        ],
                                      )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )),
                      for (int j = 0; j < postController.postList.value[postIndex].comments[commentIndex]['cocomment'].length; j++)
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
                                            postController.postList.value[postIndex].comments[commentIndex]['cocomment'][j]
                                                ["writernickname"],
                                            style: TextStyle(fontSize: sx(15), color: Color(0xff242424)),
                                          ),
                                          SizedBox(
                                            width: sx(30),
                                          ),
                                          Text(
                                            Database().changeTime(
                                                postController.postList.value[postIndex].comments[commentIndex]['cocomment'][j]['date']),
                                            style: TextStyle(fontSize: sx(15), color: Color(0xff242424)),
                                          ),
                                          Text(
                                            postController.postList.value[postIndex].comments[commentIndex]['cocomment'][j]['updated']
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
                                        postController.postList.value[postIndex].comments[commentIndex]['cocomment'][j]["text"],
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
                                                              commentIndex: commentIndex,
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
                                                                            .comments[commentIndex]['cocomment'][j]["drops"]
                                                                            .indexWhere(
                                                                                (element) => element == userData.user.value.email!) ==
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
                                                              .comments[commentIndex]['cocomment'][j]["drops"].length
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: sx(20), fontWeight: FontWeight.w300, color: Color(0xff707070)),
                                                        )
                                                      ],
                                                    )),
                                                  ),
                                                  SizedBox(
                                                    width: sx(10),
                                                  ),
                                                  postController.postList.value[postIndex].comments[commentIndex]['cocomment'][j]
                                                              ["writeremail"] ==
                                                          userData.user.value.email
                                                      ? TextButton(
                                                          style: TextButton.styleFrom(
                                                              padding: EdgeInsets.all(0), minimumSize: Size(sx(50), sx(30))),
                                                          onPressed: () {
                                                            Database().removeCoComment(
                                                                cocommentIndex: j,
                                                                postid: postController.postList.value[postIndex].id,
                                                                commentIndex: commentIndex,
                                                                allCommentData: postController.postList.value[postIndex].comments);
                                                          },
                                                          child: Text("삭제",
                                                              style: TextStyle(color: Color(0xff707070), fontWeight: FontWeight.w800)))
                                                      : SizedBox(),
                                                  postController.postList.value[postIndex].comments[commentIndex]['cocomment'][j]
                                                              ["writeremail"] ==
                                                          userData.user.value.email
                                                      ? TextButton(
                                                          style: TextButton.styleFrom(
                                                              padding: EdgeInsets.all(0), minimumSize: Size(sx(50), sx(30))),
                                                          onPressed: () {
                                                            cocommentTextFieldState = "update";
                                                            cocommentIndex = j;
                                                            FocusScope.of(context).requestFocus(textfieldFocus);
                                                            cocommentText.text = postController
                                                                .postList.value[postIndex].comments[commentIndex]['cocomment'][j]["text"];
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
                                )
                              ],
                            ))
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
                          controller: cocommentText,
                          textAlign: TextAlign.left,
                          focusNode: textfieldFocus,
                          maxLength: 100,
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
                              hintStyle: TextStyle(
                                  color: Color(0xffb4b4b4),
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "AppleSDGothicNeo",
                                  fontStyle: FontStyle.normal,
                                  fontSize: sx(15)),
                              labelStyle: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.w300, fontStyle: FontStyle.normal, fontSize: sx(20))),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          SystemChrome.setEnabledSystemUIOverlays([]);
                          if (cocommentTextFieldState == "add") {
                            if (cocommentText.text != "") {
                              Database()
                                  .addCoComent(
                                      comment: cocommentText.text,
                                      postid: postController.postList.value[postIndex].id,
                                      commentIndex: commentIndex,
                                      allCommentData: postController.postList.value[postIndex].comments)
                                  .then((value) => cocommentText.clear());
                            }
                          } else {
                            if (cocommentText.text != "") {
                              Database()
                                  .updateCoComment(
                                    cocommentText: cocommentText.text,
                                    cocommentIndex: cocommentIndex,
                                    postid: postController.postList.value[postIndex].id,
                                    commentIndex: commentIndex,
                                    allCommentData: postController.postList.value[postIndex].comments,
                                  )
                                  .then((value) => cocommentText.clear());
                              cocommentTextFieldState = "add";
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
                  ))));
        },
      ),
    );
  }
}
