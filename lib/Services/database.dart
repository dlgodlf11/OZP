import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:sweatbox2dot0/Controller/UserDataController.dart';
import 'package:sweatbox2dot0/Models/PostModel.dart';
import 'package:sweatbox2dot0/Models/UserModel.dart';
import 'dart:math';

class Database {
  var userData = Get.put(UserController());
  Future<bool> createUserData(email, gender, birthYear, birthDay, box) async {
    try {
      print("asdfadsfdsfasdfadsflkwjaelfjakwejfklawejklfjaklwe");
      await FirebaseFirestore.instance.collection("UserData").doc(email).set({
        "email": email,
        "tall": null,
        "weight": null,
        "box": box,
        "gender": gender,
        "nickname": null,
        "birthYear": birthYear,
        "birthDay": birthDay,
        "writedPost": [],
        "writedComment": [],
        "dropedPost": [],
        "timerHistory": [],
        "wodProof": [],
        "diary": [],
        "pr": [],
        "prupgradecount": 0,
        "profileimage": null,
        "randomwoduse": 0,
        "classlisten": 0,
        "badges": [],
        "wodfilter": [],
        "savedwod": [],
        "rm": [],
        "randomwodcount": 10,
        "createdAt": DateTime.now().toString()
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<UserModel> getUserData(email) {
    return FirebaseFirestore.instance.collection("UserData").doc(email).snapshots().map((query) {
      Map<String, dynamic>? ref = query.data();
      return UserModel.fromDocumentSnapshot(documentSnapshot: query);
    });

    // try {
    //   DocumentSnapshot _docu = await FirebaseFirestore.instance.collection("UserData").doc(email).get();
    //   return UserModel.fromDocumentSnapshot(documentSnapshot: _docu);
    // } catch (e) {
    //   rethrow;
    // }
  }

  Future<bool> saveTimerRecord(timerType, runtime, isGiveUp, rounds, rest, workout) async {
    try {
      await FirebaseFirestore.instance.collection("UserData").doc(userData.user.value.email).update({
        "timerHistory": FieldValue.arrayUnion([
          {
            "date": DateTime.now().toString(),
            "runtime": runtime,
            "timerType": timerType,
            "isGiveUp": isGiveUp,
            "rounds": rounds,
            "rest": rest,
            "workout": workout
          }
        ])
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<List<PostModel>> postStream() {
    return FirebaseFirestore.instance.collection("SweatBox2dot0").doc("Community").collection("SweatPost").snapshots().map((query) {
      List<PostModel> retVal = [
        for (int i = 0; i < query.docs.length; i++) PostModel.fromDocumentSnapshot(documentSnapshot: query.docs[i])
      ];
      retVal.forEach((element) {
        print(element.post);
      });
      // query.docs.forEach((element) {
      //   print(element.data()["post"]);
      //   retVal.add(PostModel.fromDocumentSnapshot(documentSnapshot: element));
      // });
      // retVal.forEach((element) {
      //   print("씨발 개같은것들아");
      //   print(DateTime(
      //           int.parse(element.id.split(" ")[0].split("-")[0]),
      //           int.parse(element.id.split(" ")[0].split("-")[1]),
      //           int.parse(element.id.split(" ")[0].split("-")[2]),
      //           int.parse(element.id.split(" ")[1].split(":")[0]),
      //           int.parse(element.id.split(" ")[1].split(":")[1]),
      //           int.parse(element.id.split(" ")[1].split(":")[2].split(".")[0]),
      //           int.parse(element.id.split(" ")[1].split(":")[2].split(".")[1]))
      //       .toString());
      // });

      // retVal.sort((a, b) => DateTime(
      //         int.parse(a.id.split(" ")[0].split("-")[0]),
      //         int.parse(a.id.split(" ")[0].split("-")[1]),
      //         int.parse(a.id.split(" ")[0].split("-")[2]),
      //         int.parse(a.id.split(" ")[1].split(":")[0]),
      //         int.parse(a.id.split(" ")[1].split(":")[1]),
      //         int.parse(a.id.split(" ")[1].split(":")[2].split(".")[0]),
      //         int.parse(a.id.split(" ")[1].split(":")[2].split(".")[1]))
      //     .compareTo(DateTime(
      //         int.parse(b.id.split(" ")[0].split("-")[0]),
      //         int.parse(b.id.split(" ")[0].split("-")[1]),
      //         int.parse(b.id.split(" ")[0].split("-")[2]),
      //         int.parse(b.id.split(" ")[1].split(":")[0]),
      //         int.parse(b.id.split(" ")[1].split(":")[1]),
      //         int.parse(b.id.split(" ")[1].split(":")[2].split(".")[0]),
      //         int.parse(b.id.split(" ")[1].split(":")[2].split(".")[1]))));
      // retVal.forEach((element) {
      //   print(element.id);
      // });
      return retVal;
    });
  }

  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> prStream({required String type}) {
    return FirebaseFirestore.instance.collection("PersonalRecord_${type}").snapshots().map((query) {
      return query.docs;
    });
  }

  Future<void> createPost({required title, taglist, images, required post}) async {
    var now = DateTime.now().toString();
    int fileIndex = 1;
    RxList imageUrlList = RxList();
    var tagref = FirebaseFirestore.instance.collection("SweatBox2dot0").doc("Tags");

    await tagref.get().then((value) {
      taglist.forEach((tag) {
        if (value.data()![tag] == null) {
          tagref.set({tag: 1}, SetOptions(merge: true));
        } else {
          tagref.update({tag: FieldValue.increment(1)});
        }
      });
    });

    if (images.length != 0) {
      images.forEach((element) async {
        fileIndex++;
        await FirebaseStorage.instance
            .ref("SweatBox2dot0/Community/${now}/images/image${fileIndex}.png")
            .putFile(element)
            .then((res) async {
          await res.ref.getDownloadURL().then((value) async {
            // imageUrlList.add(value);
            //gs://moti-demo.appspot.com/SweatBox2dot0/Community/2021-07-19 15:30:06.877322/images/image2.png
            String bucketPath = "gs://${res.ref.bucket}/SweatBox2dot0/Community/${now}/images/${res.ref.name}";

            imageUrlList.add(bucketPath);
            if (imageUrlList.length == images.length) {
              await FirebaseFirestore.instance.collection("SweatBox2dot0").doc("Community").collection("SweatPost").doc(now).set({
                "title": title,
                "tag": taglist,
                "images": imageUrlList,
                "post": post,
                "writer": userData.user.value.email,
                "comment": [],
                "writernickname": userData.user.value.nickName!,
                "drop": [],
                "view": 0,
                "updated": false
              }, SetOptions(merge: true)).then((value) async {});

              print(imageUrlList);
            }
          });
        });
      });
    } else {
      await FirebaseFirestore.instance.collection("SweatBox2dot0").doc("Community").collection("SweatPost").doc(now).set({
        "title": title,
        "tag": taglist,
        "images": [],
        "post": post,
        "writer": userData.user.value.email,
        "comment": [],
        "writernickname": userData.user.value.nickName!,
        "drop": [],
        "view": 0,
        "updated": false
      }, SetOptions(merge: true)).then((value) async {});
    }
    await FirebaseFirestore.instance.collection("UserData").doc(userData.user.value.email).update({
      "writedPost": FieldValue.arrayUnion([now])
    });
    // await FirebaseFirestore.instance.collection("SweatBox2.0").doc("Community").collection("SweatPost").doc(DateTime.now().toString()).set({
    //   "title": title,
    //   "tag": tag,
    //   "images": images,
    //   "post": post,
    //   "writer": userData.user.value.email,
    // });
  }

  Future<dynamic> getOtherUserProfile() async {
    var otherUserData = await FirebaseFirestore.instance.collection("UserData").get();
    return otherUserData.docs;
  }

  Future<void> updatePost({required postid, title, taglist, images, required post}) async {
    int fileIndex = 1;
    RxList imageUrlList = RxList();
    var tagref = FirebaseFirestore.instance.collection("SweatBox2dot0").doc("Tags");

    await tagref.get().then((value) {
      taglist.forEach((tag) {
        if (value.data()![tag] == null) {
          tagref.set({tag: 1}, SetOptions(merge: true));
        } else {
          tagref.update({tag: FieldValue.increment(1)});
        }
      });
    });

    if (images.length != 0) {
      images.forEach((element) async {
        fileIndex++;
        await FirebaseStorage.instance
            .ref("SweatBox2dot0/Community/${postid}/images/image${fileIndex}.png")
            .putFile(element)
            .then((res) async {
          await res.ref.getDownloadURL().then((value) async {
            // imageUrlList.add(value);
            //gs://moti-demo.appspot.com/SweatBox2dot0/Community/2021-07-19 15:30:06.877322/images/image2.png
            String bucketPath = "gs://${res.ref.bucket}/SweatBox2dot0/Community/${postid}/images/${res.ref.name}";

            imageUrlList.add(bucketPath);
            if (imageUrlList.length == images.length) {
              await FirebaseFirestore.instance.collection("SweatBox2dot0").doc("Community").collection("SweatPost").doc(postid).update({
                "title": title,
                "tag": taglist,
                //"images": imageUrlList,
                "post": post,
                "writer": userData.user.value.email,
                //"comment": [],
                "writernickname": userData.user.value.nickName!,
                //"drop": [],
                //"view": 0,
                "updated": true
              }).then((value) async {});

              print(imageUrlList);
            }
          });
        });
      });
    } else {
      await FirebaseFirestore.instance.collection("SweatBox2dot0").doc("Community").collection("SweatPost").doc(postid).update({
        "title": title,
        "tag": taglist,
        //"images": [],
        "post": post,
        "writer": userData.user.value.email,
        //"comment": [],
        "writernickname": userData.user.value.nickName!,
        //"drop": [],
        //"view": 0,
        "updated": true
      }).then((value) async {});
    }
  }

  Future<void> increaseView({required String postid}) async {
    await FirebaseFirestore.instance
        .collection("SweatBox2dot0")
        .doc("Community")
        .collection("SweatPost")
        .doc(postid)
        .update({"view": FieldValue.increment(1)});
  }

  Future<void> dropPost({required String postid}) async {
    print(userData.user.value.dropedPost!);
    if (userData.user.value.dropedPost!.indexWhere((element) => element == postid) == -1) {
      print("objects");
      await FirebaseFirestore.instance.collection("SweatBox2dot0").doc("Community").collection("SweatPost").doc(postid).update({
        "drop": FieldValue.arrayUnion([userData.user.value.email])
      });

      await FirebaseFirestore.instance.collection("UserData").doc(userData.user.value.email).update({
        "dropedPost": FieldValue.arrayUnion([postid])
      });
      userData.user.value.dropedPost!.add(postid);
    } else {
      print("object");
      await FirebaseFirestore.instance.collection("SweatBox2dot0").doc("Community").collection("SweatPost").doc(postid).update({
        "drop": FieldValue.arrayRemove([userData.user.value.email])
      });

      await FirebaseFirestore.instance.collection("UserData").doc(userData.user.value.email).update({
        "dropedPost": FieldValue.arrayRemove([postid])
      });
      userData.user.value.dropedPost!.removeWhere((element) => element == postid);
    }
  }

  Future<void> removePost({required String postid, required hasphoto}) async {
    if (hasphoto) {
      await FirebaseStorage.instance.ref('/SweatBox2dot0/Community/$postid/images/').listAll().then((value) async {
        value.items.forEach((element) async {
          print(element.fullPath);
          await FirebaseStorage.instance.ref(element.fullPath).delete();
        });
      });
    }
    await FirebaseFirestore.instance.collection("SweatBox2dot0").doc("Community").collection("SweatPost").doc(postid).delete();
    await FirebaseFirestore.instance.collection("UserData").doc(userData.user.value.email).update({
      "writedPost": FieldValue.arrayRemove([postid])
    });
  }

  Future<void> addComment({required String comment, required String postid}) async {
    await FirebaseFirestore.instance.collection("SweatBox2dot0").doc("Community").collection("SweatPost").doc(postid).update({
      "comment": FieldValue.arrayUnion([
        {
          "cocomment": [],
          "date": DateTime.now().toString(),
          "drops": [],
          "text": comment,
          "writeremail": userData.user.value.email,
          "writernickname": userData.user.value.nickName!,
          "updated": false
        }
      ])
    });
    await FirebaseFirestore.instance.collection("UserData").doc(userData.user.value.email).update({
      "writedComment": FieldValue.arrayUnion([
        {"postid": postid, "text": comment}
      ])
    });
  }

  Future<void> removeComment({required String postid, required commentData}) async {
    await FirebaseFirestore.instance.collection("SweatBox2dot0").doc("Community").collection("SweatPost").doc(postid).update({
      "comment": FieldValue.arrayRemove([commentData])
    });
    print(postid);
    print(commentData["text"]);
    await FirebaseFirestore.instance.collection("UserData").doc(userData.user.value.email).update({
      "writedComment": FieldValue.arrayRemove([
        {"postid": postid, "text": commentData["text"]}
      ])
    });
  }

  Future<void> addCoComent({required String comment, required String postid, required int commentIndex, required allCommentData}) async {
    var copyCommentData = allCommentData;

    copyCommentData[commentIndex]["cocomment"].add({
      "date": DateTime.now().toString(),
      "drops": [],
      "text": comment,
      "writeremail": userData.user.value.email,
      "writernickname": userData.user.value.nickName!,
      "updated": false
    });
    await FirebaseFirestore.instance
        .collection("SweatBox2dot0")
        .doc("Community")
        .collection("SweatPost")
        .doc(postid)
        .update({"comment": copyCommentData});
  }

  Future<void> updateComment({required String comment, required String postid, required int commentIndex, required allCommentData}) async {
    var copyCommentData = allCommentData;
    copyCommentData[commentIndex]["text"] = comment;
    copyCommentData[commentIndex]["date"] = DateTime.now().toString();
    copyCommentData[commentIndex]["updated"] = true;

    await FirebaseFirestore.instance
        .collection("SweatBox2dot0")
        .doc("Community")
        .collection("SweatPost")
        .doc(postid)
        .update({"comment": copyCommentData});
  }

  Future<bool> dropComment({required String postid, required int commentIndex, required allCommentData}) async {
    var copyCommentData = allCommentData;
    var isadd = false;
    var result;
    if (copyCommentData[commentIndex]["drops"].indexWhere((element) => element == userData.user.value.email) == -1) {
      copyCommentData[commentIndex]['drops'].add(userData.user.value.email);
      isadd = true;
    } else {
      copyCommentData[commentIndex]['drops'].removeWhere((element) => element == userData.user.value.email);
      isadd = false;
    }
    await FirebaseFirestore.instance
        .collection("SweatBox2dot0")
        .doc("Community")
        .collection("SweatPost")
        .doc(postid)
        .update({"comment": copyCommentData});
    result = isadd;
    return result;
  }

  Future<void> removeCoComment(
      {required cocommentIndex, required String postid, required int commentIndex, required allCommentData}) async {
    var copyCommentData = allCommentData;
    copyCommentData[commentIndex]["cocomment"].removeAt(cocommentIndex);
    await FirebaseFirestore.instance
        .collection("SweatBox2dot0")
        .doc("Community")
        .collection("SweatPost")
        .doc(postid)
        .update({"comment": copyCommentData});
  }

  Future<void> updateCoComment(
      {required cocommentText, required cocommentIndex, required String postid, required int commentIndex, required allCommentData}) async {
    var copyCommentData = allCommentData;
    copyCommentData[commentIndex]["cocomment"][cocommentIndex]["text"] = cocommentText;
    copyCommentData[commentIndex]["cocomment"][cocommentIndex]["date"] = DateTime.now().toString();
    copyCommentData[commentIndex]["cocomment"][cocommentIndex]["updated"] = true;
    await FirebaseFirestore.instance
        .collection("SweatBox2dot0")
        .doc("Community")
        .collection("SweatPost")
        .doc(postid)
        .update({"comment": copyCommentData});
  }

  Future<bool> dropCoComment({
    required String postid,
    required int commentIndex,
    required allCommentData,
    required cocommentIndex,
  }) async {
    var isadd = false;
    var result;
    var copyCommentData = allCommentData;
    if (copyCommentData[commentIndex]["cocomment"][cocommentIndex]["drops"].indexWhere((element) => element == userData.user.value.email) ==
        -1) {
      copyCommentData[commentIndex]["cocomment"][cocommentIndex]['drops'].add(userData.user.value.email);
      isadd = true;
    } else {
      copyCommentData[commentIndex]["cocomment"][cocommentIndex]['drops'].removeWhere((element) => element == userData.user.value.email);
      isadd = false;
    }
    await FirebaseFirestore.instance
        .collection("SweatBox2dot0")
        .doc("Community")
        .collection("SweatPost")
        .doc(postid)
        .update({"comment": copyCommentData});
    result = isadd;
    return result;
  }

  Future<void> saveWod({required wodData}) async {
    try {
      await FirebaseFirestore.instance.collection("UserData").doc(userData.user.value.email).update({
        "savedwod": FieldValue.arrayUnion([wodData])
      });
      return;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeWod({required List<dynamic> removeIndex}) async {
    try {
      var temp = userData.user.value.savedwod;
      removeIndex.forEach((element) {
        temp!.removeAt(element);
      });
      await FirebaseFirestore.instance.collection("UserData").doc(userData.user.value.email).update({"savedwod": temp});
      return;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addWodFilter({required filterText}) async {
    try {
      await FirebaseFirestore.instance.collection("UserData").doc(userData.user.value.email).update({
        "wodfilter": FieldValue.arrayUnion([filterText])
      });
      return;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addDiary({required diaryData}) async {
    try {
      await FirebaseFirestore.instance.collection("UserData").doc(userData.user.value.email).update({
        "diary": FieldValue.arrayUnion([diaryData])
      });
      return;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addRestDiary({required diaryData}) async {
    try {
      await FirebaseFirestore.instance.collection("UserData").doc(userData.user.value.email).update({
        "diary": FieldValue.arrayUnion([diaryData])
      });
      return;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateDiary({required beforeDiaryData, required afterDiaryData}) async {
    try {
      userData.user.value.diary.removeWhere((element) =>
          element["content"] == beforeDiaryData["content"] &&
          element["round"] == beforeDiaryData["round"] &&
          element["date"] == beforeDiaryData["date"] &&
          element["simplecomment"] == beforeDiaryData["simplecomment"] &&
          element["text"] == beforeDiaryData["text"]);
      userData.user.value.diary.add(afterDiaryData);
      // await FirebaseFirestore.instance.collection("UserData").doc(userData.user.value.email).update({
      //   "diary": FieldValue.arrayRemove([beforeDiaryData])
      // });
      await FirebaseFirestore.instance.collection("UserData").doc(userData.user.value.email).update({"diary": userData.user.value.diary});
      return;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeDiary({required diaryData}) async {
    try {
      print(diaryData);
      await FirebaseFirestore.instance.collection("UserData").doc(userData.user.value.email).update({
        "diary": FieldValue.arrayRemove([diaryData])
      });

      return;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeWodFilter({required filterText}) async {
    try {
      await FirebaseFirestore.instance.collection("UserData").doc(userData.user.value.email).update({
        "wodfilter": FieldValue.arrayRemove([filterText])
      });
      return;
    } catch (e) {
      rethrow;
    }
  }

  useRandomCoin() {
    FirebaseFirestore.instance
        .collection("UserData")
        .doc(userData.user.value.email)
        .update({"randomwodcount": FieldValue.increment(-1), "randomwodUse": FieldValue.increment(1)});
  }

  changeLbKg({required List<dynamic> weight, required type}) {
    print(weight);
    print(type);
    var result = "(";
    if (userData.user.value.showKg.value) {
      if (type == "lb") {
        for (int i = 0; i < weight.length; i++) {
          weight[i] = weight[i].replaceAll("s", "");
          result += (double.parse(weight[i]) * (1 / 2.2046226218)).toStringAsFixed(1);
          if (i != weight.length - 1) {
            result += "/";
          }
        }
        result += ")kg";
      } else {
        for (int i = 0; i < weight.length; i++) {
          result += (4 * (double.parse(weight[i]) / 0.25)).toStringAsFixed(0);
          if (i != weight.length - 1) {
            result += "/";
          }
        }
        result += ")kg";
      }
    } else {
      for (int i = 0; i < weight.length; i++) {
        result += weight[i];
        if (i != weight.length - 1) {
          result += "/";
        }
      }
      result += ")lb";
    }
    print(result);
    return result;
  }

  changeEasyLbKg({required value}) {
    if (userData.user.value.showKg.value) {
      return value;
    } else {
      value = ((double.parse(value) / (1 / 2.2046226218))).toStringAsFixed(0);
      return value;
    }
  }

  Future<void> setPR(
      {required String type,
      required String prName,
      required String record,
      required Rx<List<QueryDocumentSnapshot<Map<String, dynamic>>>> pr}) async {
    var prdocument = pr.value.where((element) => element.data().keys.toList().indexWhere((element) => element == prName) != -1);
    var records = prdocument.first.data()[prName];
    var result = records.where((element) => element.toString().contains(userData.user.value.email!));
    var insertRecord;
    if (type == "Weight" && !userData.user.value.showKg.value) {
      record = (double.parse(record) * (1 / 2.2046226218)).toStringAsFixed(1);
    }
    switch (type) {
      case ("Weight"):
        insertRecord = "${record}kg/${userData.user.value.email}/${DateTime.now()}";
        break;
      case ("Time"):
        insertRecord = "${record}/${userData.user.value.email}/${DateTime.now()}";
        break;
      case ("Reps"):
        insertRecord = "${record}/${userData.user.value.email}/${DateTime.now()}";
        break;
      case ("Named"):
        insertRecord = "${record}/${userData.user.value.email}/${DateTime.now()}";
        break;
      default:
    }
    print(result);
    print(record);

    print(record);
    if (result.length == 0) {
      await FirebaseFirestore.instance.collection("PersonalRecord_${type}").doc(prdocument.first.id).update({
        prName: FieldValue.arrayUnion([insertRecord])
      });
    } else {
      print(result.first);
      var ref = FirebaseFirestore.instance.collection("PersonalRecord_${type}").doc(prdocument.first.id);

      await ref.update({
        prName: FieldValue.arrayUnion([insertRecord])
      });
      await ref.update({
        prName: FieldValue.arrayRemove([result.first])
      });
    }
  }

  Future<void> updateRm({required weight, required reps}) async {
    try {
      await FirebaseFirestore.instance.collection("UserData").doc(userData.user.value.email).update({
        "rm": FieldValue.arrayUnion([
          {"date": DateTime.now().toString(), "weight": weight, "reps": reps}
        ])
      });
      return;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> getBoxList() async {
    var ref = await FirebaseFirestore.instance.collection("SweatBox2dot0").doc("Boxes").get();
    return ref.get("boxes");
  }

  Future<List<dynamic>> getWodCategoryList() async {
    var ref = await FirebaseFirestore.instance.collection("SweatBox2dot0").doc("WorkoutCategory").get();
    return ref.get("category");
  }

  List<List<dynamic>> checkKoreanString({required String text}) {
    List<List<dynamic>> result = [];
    text.runes.forEach((input) {
      if (input <= 12622) {
        result.add([choSungSearch(choSung: input), 0, 0]);
      } else {
        var cho = ((input - 0xAC00) / 28) / 21;
        var jung = ((input - 0xAC00) / 28) % 21;
        var jong = ((input - 0xAC00) % 28);
        result.add([cho.ceil(), jung.ceil(), jong.ceil()]);
      }
    });
    //print(result);
    return result;
  }

  Future<void> updatePhysicalData(
      {required String nickName,
      required String tall,
      required String weight,
      required String box,
      required int gender,
      required String image}) async {
    var bucket = "";

    if (!image.contains("gs://moti")) {
      await FirebaseStorage.instance
          .ref("SweatBox2dot0/UserData/${userData.user.value.email!}/profileimage.png")
          .putFile(File(image))
          .then((res) async {
        await res.ref.getDownloadURL().then((value) async {
          // imageUrlList.add(value);
          //gs://moti-demo.appspot.com/SweatBox2dot0/Community/2021-07-19 15:30:06.877322/images/image2.png
          String bucketPath = "gs://${res.ref.bucket}/SweatBox2dot0//UserData/${userData.user.value.email!}/profileimage.png";

          bucket = bucketPath;
        });
      });
    } else {
      bucket = image;
    }
    await FirebaseFirestore.instance.collection("UserData").doc(userData.user.value.email!).update({
      "tall": double.parse(tall),
      "nickname": nickName,
      "weight": double.parse(weight),
      "box": box,
      "gender": gender,
      "profileimage": bucket
    });
  }

  measureAbility() {
    int commu = (userData.user.value.writedPost!.length * 60) +
        (userData.user.value.writedComment!.length * 4) +
        (userData.user.value.dropedPost!.length * 3);
    int kkunKey = (userData.user.value.diary.length * 4);
    int trybility = (userData.user.value.wodProof!.length * 15) +
        (userData.user.value.timerHistory!.length * 10) +
        (userData.user.value.rm.length * 1) +
        (userData.user.value.usedRandoWod.value * 6);
    int strength = 1;
    int honor = 1;
    int enthusiasm = 1;

    commu = ((commu / userData.user.value.abilityCommu) * 100).floor();
    kkunKey = ((kkunKey / userData.user.value.abilityKkunKey) * 100).floor();
    trybility = ((trybility / userData.user.value.abilityTrybility) * 100).floor();

    if (commu < 10)
      commu = 1;
    else if (commu >= 10 && commu < 30)
      commu = 2;
    else if (commu >= 30 && commu < 60)
      commu = 3;
    else if (commu >= 60 && commu < 100)
      commu = 4;
    else if (commu >= 100) commu = 5;

    if (kkunKey < 10)
      kkunKey = 1;
    else if (kkunKey >= 10 && kkunKey < 30)
      kkunKey = 2;
    else if (kkunKey >= 30 && kkunKey < 60)
      kkunKey = 3;
    else if (kkunKey >= 60 && kkunKey < 100)
      kkunKey = 4;
    else if (kkunKey >= 100) kkunKey = 5;

    if (trybility < 10)
      trybility = 1;
    else if (trybility >= 10 && trybility < 30)
      trybility = 2;
    else if (trybility >= 30 && trybility < 60)
      kkunKey = 3;
    else if (trybility >= 60 && trybility < 100)
      kkunKey = 4;
    else if (trybility >= 100) trybility = 5;

    return [commu, kkunKey, trybility, strength, honor, enthusiasm];
  }

  isKorean({required String text}) {
    return text.codeUnits[0] >= 12593 && text.codeUnits[0] <= 12643
        ? true
        : text.codeUnits[0] >= 44032 && text.codeUnits[0] <= 55203
            ? true
            : false;
  }

  choSungSearch({required int choSung}) {
    switch (choSung) {
      case (12593):
        return 1;
      case (12596):
        return 3;
      case (12599):
        return 4;
      case (12601):
        return 6;
      case (12609):
        return 7;
      case (12610):
        return 8;
      case (12613):
        return 10;
      case (12615):
        return 12;
      case (12616):
        return 13;
      case (12618):
        return 15;
      case (12619):
        return 16;
      case (12620):
        return 17;
      case (12621):
        return 18;
      case (12622):
        return 19;

      default:
    }
  }

  changeTime(String time) {
    var splitTime = time.split(" ");
    var date = splitTime[0];
    var daytime = splitTime[1];

    var year = int.parse(date.split("-")[0]);
    var month = int.parse(date.split("-")[1]);
    var day = int.parse(date.split("-")[2]);
    var hour = int.parse(daytime.split(":")[0]);
    var min = int.parse(daytime.split(":")[1]);
    var sec = int.parse(daytime.split(":")[2].split(".")[0]);
    var milisec = int.parse(daytime.split(":")[2].split(".")[1]);
    var now = DateTime.now();
    var writedTime = DateTime(year, month, day, hour, min, sec);

    var timegap = now.difference(writedTime);
    print(time);
    print(writedTime);
    if (timegap.inSeconds < 5) {
      return '방금';
    } else if (timegap.inSeconds <= 60) {
      return '${timegap.inSeconds}초 전';
    } else if (timegap.inMinutes <= 1) {
      return '1분 전';
    } else if (timegap.inMinutes <= 60) {
      return '${timegap.inMinutes}분 전';
    } else if (timegap.inHours <= 1) {
      return '1시간 전';
    } else if (timegap.inHours <= 60) {
      return '${timegap.inHours}시간 전';
    } else if (timegap.inDays <= 1) {
      return '1일 전';
    } else if (timegap.inDays <= 6) {
      return '${timegap.inDays}일 전';
    } else if ((timegap.inDays / 7).ceil() <= 1) {
      return '1주 전';
    } else if ((timegap.inDays / 7).ceil() <= 4) {
      return '${(timegap.inDays / 7).ceil()}주 전';
    } else if ((timegap.inDays / 30).ceil() <= 1) {
      return '1개월 전';
    } else if ((timegap.inDays / 30).ceil() <= 30) {
      return '${(timegap.inDays / 30).ceil()}달 전';
    } else if ((timegap.inDays / 365).ceil() <= 1) {
      return '1년(와..이렇게 오래?) 전';
    }
    return '${(timegap.inDays / 365).floor()}년 전';
  }
}
