import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:kakao_flutter_sdk/user.dart';
import 'package:sweatbox2dot0/Controller/UserDataController.dart';
import 'package:sweatbox2dot0/Models/UserModel.dart';
import 'package:sweatbox2dot0/Services/database.dart';

class AuthController extends GetxController {
  RxBool loginState = false.obs;
  RxBool checking = false.obs;
  loginKaKao() async {
    var code = await AuthCodeClient.instance.request(clientId: "d24491249fd7de738b36837d5b44cf6d");
    AccessTokenResponse token = await AuthApi.instance.issueAccessToken(code, clientId: "d24491249fd7de738b36837d5b44cf6d");

    await AccessTokenStore.instance.toStore(token).then((value) {
      print("토큰없어?");
      print(value.accessToken);
    }).catchError((e) {
      print("씨발${e}");
    });
    await UserApi.instance.me().then((kakaoUser) async {
      var userList = await FirebaseFirestore.instance.collection("UserData").get();
      print("tlqkf");
      print(userList.docs);
      if (userList.docs.indexWhere((element) => element.id == kakaoUser.kakaoAccount!.email) == -1) {
        //var response = _showAuthDialog();
        await Database().createUserData(kakaoUser.kakaoAccount!.email, kakaoUser.kakaoAccount!.gender!.index,
            kakaoUser.kakaoAccount!.birthyear, kakaoUser.kakaoAccount!.birthday, null);
      }

      try {
        Get.put(UserController()).user.bindStream(Database().getUserData(kakaoUser.kakaoAccount!.email));
        loginState.value = true;
      } catch (e) {
        print("씨발${e}");
      }
    });

    //await UserApi.instance.me();
  }

  Future _showAuthDialog() async {}

  @override
  void onInit() {
    // UserApi.instance.logout();
    // AccessTokenStore.instance.clear();
    try {
      AccessTokenStore.instance.fromStore().then((value) async {
        print("뭐가 문젠대");
        print(value.refreshToken);
        if (value.refreshToken == null) {
          loginState.value = false;
        } else {
          print("하");

          // var response = await post(Uri.parse("https://kauth.kakao.com/oauth/token"), body: {
          //   "grant_type": "refresh_token",
          //   "client_id": "d24491249fd7de738b36837d5b44cf6d",
          //   "refresh_token": value.refreshToken!,
          //   "client_secret": "cmpimYTr8byZ1UrAI15vB1OuXO3gE68E"
          // });

          // print(response.body.split('"')[3]);
          AccessTokenResponse token = await AuthApi.instance.refreshAccessToken(value.refreshToken!);
          AccessTokenStore.instance.toStore(token);
        }
      }).then((value) async {
        await UserApi.instance.me().then((kakaoUser) async {
          var userList = await FirebaseFirestore.instance.collection("UserData").get();
          if (userList.docs.indexWhere((element) => element.id == kakaoUser.kakaoAccount!.email) == -1) {
            var response = _showAuthDialog();
            await Database().createUserData(kakaoUser.kakaoAccount!.email, kakaoUser.kakaoAccount!.gender,
                kakaoUser.kakaoAccount!.birthyear, kakaoUser.kakaoAccount!.birthday, "box");
          }

          try {
            print(kakaoUser.kakaoAccount!.email);
            Get.put(UserController()).user.bindStream(Database().getUserData(kakaoUser.kakaoAccount!.email));
            loginState.value = true;
          } catch (e) {
            print("씨발1${e}");
          }
        });
      });
      // UserApi.instance.me().catchError((e) {
      //   print("개새끼${e}");
      //   loginState.value = false;
      // });
    } catch (e) {
      print("씨발2${e}");
      loginState.value = false;
    }

    super.onInit();
  }
}
