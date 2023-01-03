import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:sweatbox2dot0/Controller/AuthController.dart';
import 'package:sweatbox2dot0/view/ViewMain.dart';
import 'package:sweatbox2dot0/view/Login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wakelock/wakelock.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  KakaoContext.clientId = "d24491249fd7de738b36837d5b44cf6d";
  KakaoContext.javascriptClientId = "16609ff34d46b934597f2eecf1624d7c";

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SWEAT BOX',
      theme: ThemeData(
        fontFamily: "Apple",
        primaryColor: Color(0xffb4b4b4),
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      builder: (context, child) => MediaQuery(
        child: child!,
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
//     String workout_category = '''Barbell Shoulder Press
// Barbell Behind Shoulder Press
// Barbell Bench Press
// Barbell Incline Bench Press
// Barbell Row
// Barbell Pendlay Row
// Barbell Shrug
// Barbell Upright Row
// Barbell Back Squat
// Barbell Front Squat
// Barbell Zercher Squat
// Barbell Overhead Squat
// Barbell Overhead Lunge
// Barbell Backrack Lunge
// Barbell Frontrack Lunge
// Barbell Deadlift
// Barbell Stiff Leg Deadlift
// Barbell Clean Deadlift
// Barbell Snatch Deadlift
// Barbell Deficit Clean Deadlift
// Barbell Deficit Snatch Deadlift
// Barbell Muscle Clean
// Barbell Power Clean
// Barbell Squat Clean
// Barbell Hang Muscle Clean
// Barbell Hang Power Clean
// Barbell Hang Squat Clean
// Barbell Push Press
// Barbell Push Jerk
// Barbell Squat Jerk
// Barbell Split Jerk
// Barbell Muscle Snatch
// Barbell Power Snatch
// Barbell Squat Snatch
// Barbell Hang Muslce Snatch
// Barbell Hang Power Snatch
// Barbell Hang Squat Snatch
// Barbell Snatch Balance
// Barbell Drop Snatch
// Barbell Thruster
// Barbell Cluster
// Barbell Bicep Curl
// Barbell Tricep Extension
// Barbell Skull Crusher
// Barbell Good Morning
// Barbell Sumo Dead High Pull
// Dumbbell Shoulder Press
// Dumbbell Behind Shoulder Press
// Dumbbell Bench Press
// Dumbbell Incline Bench Press
// Dumbbell Row
// Dumbbell Pendlay Row
// Dumbbell Shrug
// Dumbbell Upright Row
// Dumbbell Goblet Squat
// Dumbbell Overhead Squat
// Dumbbell Deadlift
// Dumbbell Stiff Leg Deadlift
// Dumbbell Overhead Lunge
// Dumbbell Frontrack Lunge
// Dumbbell Muscle Clean
// Dumbbell Power Clean
// Dumbbell Squat Clean
// Dumbbell Muscle Clean
// Dumbbell Power Clean
// Dumbbell Squat Clean
// Dumbbell Hang Muscle Clean
// Dumbbell Hang Power Clean
// Dumbbell Hang Squat Clean
// Dumbbell Push Press
// Dumbbell Push Jerk
// Dumbbell Squat Jerk
// Dumbbell Hang Muscle Snatch
// Dumbbell Hang Power Snatch
// Dumbbell Hang Squat Snatch
// Dumbbell Muscle Snatch
// Dumbbell Power Snatch
// Dumbbell Squat Snatch
// Dumbbell Thruster
// Dumbbell Cluster
// Dumbbell Bicep Curl
// Dumbbell Tricep Extension
// 5. Dumbbell Farmers Carry
// 5. Dumbbell Suitcase Carry
// 4. Dumbbell Farmers Hold
// 4. Dumbbell Suitcase Hold
// 5. Dumbbell Overhead Carry
// 4. Dumbbell Overhead Hold
// KB Shoulder Press
// KB Row
// KB Pendlay Row
// KB Shrug
// KB Upright Row
// KB Goblet Squat
// KB Overhead Squat
// KB Deadlift
// KB Stiff Leg Deadlift
// KB Overhead Lunge
// KB Frontrack Lunge
// Russian KB Swing
// American KB Swing
// KB Snatch
// KB Push Press
// KB Push Jerk
// KB Cluster
// KB Thruster
// 5. KB Farmers Carry
// 5. KB Suitcase Carry
// 4. KB Farmers Hold
// 4. KB Suitcase Hold
// 5. KB Overhead Carry
// 4. KB Overhead Hold
// KB Turkish Get-up
// Medicine Ball Push-ups
// Medicine Ball Burpee
// 4. Medicine Ball Hold
// Medicine Ball Clean
// Medicine Ball Clean Jerk
// Medicine Ball Sit-up
// Wallball Shot
// Sandbag Clean
// 4. Sandbag Hold
// 5. Sandbag Carry
// 2. Burpee
// 2. Revers Burpee
// 2. Push-up
// 2. Pike Push-up
// 3. Strict HSPU
// 3. Kipping HSPU
// 3. Deficit HSPU
// 3. Deficit Strict HSPU
// 2. Wall Walk
// 4. Handstand Hold
// 5. Handstand Walk
// 2. Hand release Push-up
// 2. Pull-up
// 2. Chin-up
// 2. Strict Pull-up
// 2. Strict Chin-up
// 2. C2B
// 2. Strict C2B
// 2. Muscle Up
// 2. Bar Muscle Up
// 2. Strict Muscle Up
// 2. Strcit Bar Muscle Up
// 2. T2B
// 2. Strict T2B
// 2. Hanging Legraise
// 2. Hanging Knee to Elbow
// 2. Bar Dips
// 2. Ring Dips
// 2. Bar Facing Burpee
// 2. Bar Lateral Burpee
// 2. Air Squat
// 2. Pistol
// Sit-up
// GHD Sit-up
// Hip Extension
// Back Extension
// 4. L-sit
// Hollow Rock
// 4. Hollow Hold
// V-up
// Alternate V-up
// Crunch
// Russian Twist
// Front Lunge
// Back Lunge
// 5. Walking Lunge
// Double Under
// Single Under
// Triple Under
// Heavy Rope SU
// Heavy Rope DU
// Heavy Rope TU
// 3. Rope Climb
// 3. Legless Rope Climb
// 2. Rope Pull-up
// 6. Run
// 6. Rowng
// 6. Ski
// 6. Echo Bike
// 6. Assault bike
// 3. Box Jump
// 3. Box Jump Over
// 3. Box Step up
// 3. Box Step Over
// 3. Burpee Box Jump
// 3. Burpee Box Jump Over
// 5. Sled Push
// 5. Sled Pull
// ''';

//     var splitedtext = workout_category.split("\n");
//     var result = [];
//     splitedtext.forEach((element) {
//       var aa = element.split(". ");
//       if (aa.length == 2) {
//         if (aa[0] == "2") {
//           result.add({"type": "bw/reps", "content": aa[1]});
//         } else if (aa[0] == "3") {
//           result.add({"type": "bw/reps/ft", "content": aa[1]});
//         } else if (aa[0] == "4") {
//           result.add({"type": "weight/time", "content": aa[1]});
//         } else if (aa[0] == "5") {
//           result.add({"type": "weight/meter", "content": aa[1]});
//         } else if (aa[0] == "6") {
//           result.add({"type": "kcal/meter/time", "content": aa[1]});
//         }
//       } else {
//         result.add({"type": "weight/reps", "content": aa[0]});
//       }
//     });
//     FirebaseFirestore.instance.collection("SweatBox2dot0").doc("WorkoutCategory").set({"category": result});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      // DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    Wakelock.enable();
    return Obx(() => authController.loginState.value ? MainView() : LoginPage());
  }
}
