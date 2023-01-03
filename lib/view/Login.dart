import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:sweatbox2dot0/Controller/AuthController.dart';

class LoginPage extends StatelessWidget {
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            SystemChrome.setEnabledSystemUIOverlays([]);
          },
          child: Scaffold(
              backgroundColor: Color(0xff404040),
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: sy(20), vertical: sx(30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "UNITED FOR\nSTREGTH",
                          style: TextStyle(fontSize: sx(60), color: Colors.white, fontWeight: FontWeight.w900),
                        )),
                    SizedBox(
                      height: sx(30),
                    ),
                    // Container(
                    //   color: Color(0xff606060),
                    //   child: TextField(
                    //     obscureText: true,
                    //     decoration: InputDecoration(
                    //         enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Color(0xffb4b4b4))),
                    //         isDense: true,
                    //         fillColor: Colors.red,
                    //         errorStyle: TextStyle(color: Colors.white),
                    //         border: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Colors.red)),
                    //         labelText: "아이디를 입력해주세요",
                    //         hintText: 'ex)united@for.com',
                    //         hintStyle: TextStyle(color: Color(0xffb4b4b4), fontWeight: FontWeight.w300, fontFamily: "AppleSDGothicNeo", fontStyle: FontStyle.normal, fontSize: sx(20)),
                    //         labelStyle: TextStyle(color: Color(0xffb4b4b4), fontWeight: FontWeight.w300, fontFamily: "AppleSDGothicNeo", fontStyle: FontStyle.normal, fontSize: sx(20))),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: sx(30),
                    // ),
                    // Container(
                    //   color: Color(0xff606060),
                    //   child: TextField(
                    //     obscureText: true,
                    //     decoration: InputDecoration(
                    //         enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Color(0xffb4b4b4))),
                    //         isDense: true,
                    //         fillColor: Colors.red,
                    //         errorStyle: TextStyle(color: Colors.white),
                    //         border: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Colors.red)),
                    //         labelText: "비밀번호를 입력해주세요",
                    //         hintText: '한,영,숫자조합 8자 이상',
                    //         hintStyle: TextStyle(color: Color(0xffb4b4b4), fontWeight: FontWeight.w300, fontFamily: "AppleSDGothicNeo", fontStyle: FontStyle.normal, fontSize: sx(20)),
                    //         labelStyle: TextStyle(color: Color(0xffb4b4b4), fontWeight: FontWeight.w300, fontFamily: "AppleSDGothicNeo", fontStyle: FontStyle.normal, fontSize: sx(20))),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: sx(30),
                    // ),
                    // ElevatedButton(
                    //     style: ElevatedButton.styleFrom(primary: Color(0xff0046ff)),
                    //     onPressed: () {
                    //       authController.loginState.value = true;
                    //     },
                    //     child: Container(
                    //       alignment: Alignment.center,
                    //       width: width,
                    //       height: sx(70),
                    //       child: Text(
                    //         "로그인",
                    //         style: TextStyle(color: Colors.white, fontSize: sx(20), fontWeight: FontWeight.bold),
                    //       ),
                    //     )),
                    // SizedBox(
                    //   height: sx(30),
                    // ),

                    Expanded(
                        child: Container(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xffdf635a),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      //print(aa.split("\n"));
                                    },
                                    child: Container(
                                      width: width,
                                      height: sx(70),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.local_activity,
                                          ),
                                          SizedBox(
                                            width: sx(15),
                                          ),
                                          Text(
                                            "구글 계정으로 로그인하기",
                                            style: TextStyle(color: Colors.white),
                                          )
                                        ],
                                      ),
                                    )),
                                SizedBox(
                                  height: sx(30),
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xfffae300),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      authController.loginKaKao();
                                    },
                                    child: Container(
                                      width: width,
                                      height: sx(70),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.local_activity,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            width: sx(15),
                                          ),
                                          Text(
                                            "카카오 계정으로 로그인하기",
                                            style: TextStyle(color: Colors.black),
                                          )
                                        ],
                                      ),
                                    )),
                                SizedBox(
                                  height: sx(30),
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Container(
                                      width: width,
                                      height: sx(70),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.local_activity,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            width: sx(15),
                                          ),
                                          Text(
                                            "Apple로 로그인하기",
                                            style: TextStyle(color: Colors.black),
                                          )
                                        ],
                                      ),
                                    )),
                                SizedBox(
                                  height: sx(30),
                                ),
                                Text(
                                  "SWBX ⓒ COPY RIGHT RESERVED",
                                  style: TextStyle(color: Colors.white, fontSize: sx(13)),
                                ),
                              ],
                            )))
                  ],
                ),
              )),
        );
      },
    );
  }
}
