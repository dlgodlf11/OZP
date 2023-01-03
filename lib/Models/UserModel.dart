import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';

class UserModel extends GetxController {
  String? email = "";
  double? tall = 0.0;
  double? weight = 0.0;
  String? box = "";
  int? gender = -1;
  String? nickName = "";
  DateTime? birth = DateTime.now();
  RxList rm = [].obs;
  List? wodProof = [];
  List? timerHistory = [];
  List? writedPost = [];
  List? dropedPost = [];
  List? writedComment = [];
  RxInt at = 1.obs;
  List? savedwod = [];
  List? wodfilter = [];
  RxInt randomwodCount = 0.obs;
  RxInt usedRandoWod = 0.obs;
  String? profileImage;
  RxBool showKg = false.obs;
  String createDate = "";
  List diary = [];
  List<String> wodFilters = [
    "Bodyweight AMRAP",
    "Bodyweight Death by Reps",
    "Bodyweight EMOM",
    "Bodyweight ForTime",
    "Bodyweight RFT",
    "Crossfit.com",
    "Games",
    "Girls Name",
    "Hero",
    "Home Training",
    "Open",
    "Regionals"
  ];
  int abilityCommu = 657000;
  int abilityKkunKey = 5940;
  int abilityTrybility = 87600;

  UserModel(
      // {this.email,
      // this.tall,
      // this.weight,
      // this.box,
      // this.gender,
      // required this.nickName,
      // this.birth,
      // this.rm,
      // this.timerHistory,
      // this.wodProof,
      // this.writedComment,
      // this.writedPost}
      ) {}

  UserModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    email = documentSnapshot.id;
    box = documentSnapshot.get("box");
    tall = documentSnapshot.get("tall");
    weight = documentSnapshot.get("weight");
    gender = documentSnapshot.get("gender");
    nickName = documentSnapshot.get("nickname");
    //birth = DateTime(documentSnapshot.get("birthYear"), documentSnapshot.get("birthDay"));

    // birth = DateTime(documentSnapshot.get("birthYear"), int.parse(documentSnapshot.get("birthDay").split(".")[0]),
    //     int.parse(documentSnapshot.get("birthDay").split(".")[1]));
    writedComment = documentSnapshot.get("writedComment");
    writedPost = documentSnapshot.get("writedPost");
    dropedPost = documentSnapshot.get("dropedPost");
    wodfilter = documentSnapshot.get("wodfilter");
    savedwod = documentSnapshot.get("savedwod");
    rm.value = documentSnapshot.get("rm");
    randomwodCount.value = documentSnapshot.get("randomwodcount");
    createDate = documentSnapshot.get("createdAt");
    profileImage = documentSnapshot.get("profileimage");
    usedRandoWod.value = documentSnapshot.get("randomwoduse");
    print(documentSnapshot.get("diary"));
    diary = documentSnapshot.get("diary");
  }

  @override
  void onInit() {
    // TODO: implement onInit

    ever(at, (ase) {
      print("object");
    });
    super.onInit();
  }
}
