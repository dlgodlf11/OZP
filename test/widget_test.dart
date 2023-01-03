// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sweatbox2dot0/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

var aa = [
  {
    "title": "오늘은 하체를 터트리는 데이",
    "type": "리빙룸",
    "level": "상",
    "content": ["AMRAP 5", "3Rounds:", "15 Pull-ups"]
  },
  {
    "title": "오늘은 하체를 터트리는 데이2",
    "type": "게임즈",
    "level": null,
    "content": ["AMRAP 5", "3Rounds:", "15 Pull-ups"]
  },

  //level은 상:1, 중:2, 하:3 없으면 null
  //title은 와드 이름
  //content는 와드 종목 나열된것
];


//  @override
//   void initState() {
//     var wods = '''
// JT
// 21-15-9 Reps for time of:
// - Handstand Push-ups
// - Ring Dips
// - Push-ups
//  
//  
//  
//  
//  
//  
// Michael
// 3 rounds for time of:
// - 800m Run
// - 50 Back Extensions
// - 50 Sit-ups
//  
//  
//  
//  
//  
//  
// Murph
// For time:
// - 1.6km Run
// - 100 Pull-ups
// - 200 Push-ups
// - 300 Squats
// - 1.6km Run
//  
//  
//  
//  
//  
//  
// Daniel
// For time:
// - 50 Pull-ups
// - 400m Run
// - 21 Thrusters*(95lb)
// - 800m Run
// - 21 Thrusters
// - 400m Run
// - 50 Pull-ups
//  
//  
//  
//  
//  
//  
// Josh
// For time:
// - 21 Overhead Squats*(95lb)
// - 42 Pull-ups
// - 15 Overhead Squats
// - 30 Pull-ups
// - 9 Overhead Squats
// - 18 Pull-ups
//  
//  
//  
//  
//  
//  
// Jason
// For time:
// - 100 Air Squats
// - 5 Muscle-ups
// - 75 Air Squats
// - 10 Muscle-ups
// - 50 Air Squats
// - 15 Muscle-ups
// - 25 Air Squats
// - 20 Muscle-ups
//  
//  
//  
//  
//  
//  
// Badger
// Complete 3 rounds for time of:
// - 30 Squat Cleans*(95lb)
// - 30 Pull-ups
// - 800m Run
//  
//  
//  
//  
//  
//  
// Joshie
// Complete 3 rounds for time of:
// - 21 Right Arm Dumbbell Snatches*(40lb)
// - 21 L Pull-ups
// - 21 Left Arm Dumbbell Snatches*(40lb)
// - 21 L Pull-ups
//  
//  
//  
//  
//  
//  
// Nate
// Complete as many rounds in twenty minutes as you can of:
// - 2 Muscle-ups
// - 4 Handstand Push-ups
// - 8 Kettlebell Swings*(2pood)
//  
//  
//  
//  
//  
//  
// Randy
// - 75 Power Snatches*(75lb)
//  
//  
//  
//  
//  
//  
// Tommy V
// For time:
// - 21 Thrusters, 21 Reps*(155lb)
// - 12 Rope Climb(15ft)
// - 15 Thrusters, 15 Reps
// - 9 Rope Climb(15ft)
// - 9 Thrusters, 9 Reps
// - 6 Rope Climb(15ft)
//  
//  
//  
//  
//  
//  
// Griff
// For time:
// - 800m Run
// - 400m Backward Run
// - 800m Run
// - 400m Backward Run
//  
//  
//  
//  
//  
//  
// Ryan
// 5 rounds for time of:
// - 7 Muscle-ups
// - 21 Burpees
//  
//  
//  
//  
//  
//  
// Erin
// 5 rounds for time of:
// - 15 Dumbbells Split Cleans*(40lb)
//  
//  
//  
//  
//  
//  
// Mr. Joshua
// 5 rounds for time of:
// - 400m Run
// - 30 Glute-ham Sit-ups
// - 15 Deadlifts*(250lb)
//  
//  
//  
//  
//  
//  
// DT
// 5 rounds for time of:
// - 12 Deadlift*(155lb)
// - 9 Hang Power Cleans
// - 6 Push Jerks
//  
//  
//  
//  
//  
//  
// Danny
// Complete as many rounds in 20 minutes as you can of:
// - 30 Box Jumps(24/20inch)
// - 20 Push Presses*(115lb)
// - 30 Pull-ups
//  
//  
//  
//  
//  
//  
// Hansen
// 5 rounds for time of:
// - 30 Kettlebell Swings*(2pood)
// - 30 Burpees
// - 30 Glute-ham Sit-ups
//  
//  
//  
//  
//  
//  
// Tyler
// 5 rounds for time of:
// - 7 Muscle-ups
// - 21 Sumo-deadlift-high-Pulls*(95lb)
//  
//  
//  
//  
//  
//  
// Lumberjack 20
// - 20 Deadlifts*(275lb)
// - 400m Run
// - 20 KB Swings*(2pood)
// - 400m Run
// - 20 Overhead Squats*(115lb)
// - 400m Run
// - 20 Burpees
// - 400m Run
// - 20 Chest to Bar Pull-ups
// - 400m Run
// - 20 Box Jumps(24inch)
// - 400m Run
// - 20 DB Squat Cleans, each*(45lb)
// - 400m Run
//  
//  
//  
//  
//  
//  
// Stephen
// 30-25-20-15-10-5 Rep rounds of:
// - GHD Sit-up
// - Back Extension
// - Knees to Elbow
// - Stiff Legged Deadlift*(95lb)
//  
//  
//  
//  
//  
//  
// Garrett
// 3 rounds for time of:
// - 75 Squats
// - 25 Ring Handstand Push-ups
// - 25 L-Pull-ups
//  
//  
//  
//  
//  
//  
// War Frank
// 3 rounds for time of:
// - 25 Muscle-ups
// - 100 Squats
// - 35 GHD Sit-ups
//  
//  
//  
//  
//  
//  
// McGhee
// Complete as many rounds in 30 minutes as you can of:
// - 5 Deadlifts*(275lb)
// - 13 Push-ups
// - 9 Box Jumps(24inch)
//  
//  
//  
//  
//  
//  
// Paul
// 5 rounds for time of:
// - 50 Double Unders
// - 35 Knees to Elbows
// - 20 Yards Overhead Walk*(185lb)
//  
//  
//  
//  
//  
//  
// Jerry
// For time:
// - 1.6km Run
// - 2km Row
// - 1.6km Run
//  
//  
//  
//  
//  
//  
// Nutts
// For time:
// - 10 Handstand Push-ups
// - 15 Deadlifts*(250lb)
// - 25 Box Jumps(30inch)
// - 50 Pull-ups
// - 100 Wallball Shots*(20lb)
// - 200 Double Unders
// - 400m Run with Plate*(45lb)
//  
//  
//  
//  
//  
//  
// Arnie
// With a Single *(2pood) Kettlebell:
// - 21 Turkish Get-ups, Right Arm
// - 50 Swings
// - 21 Overhead Squats, LeftArm
// - 50 Swings
// - 21 Overhead Squats, Right Arm
// - 50 Swings
// - 21 Turkish Get-ups, LeftArm
//  
//  
//  
//  
//  
//  
// The Seven
// 7 rounds for time of:
// - 7 Handstand Push-ups
// - 7 Thrusters*(135lb)
// - 7 Knees to Elbows
// - 7 Deadlift*(245lb)
// - 7 Burpees
// - 7 Kettlebell Swings*(2pood)
// - 7 Pull-ups
//  
//  
//  
//  
//  
//  
// RJ
// 5 rounds for time of:
// - 800m Run
// - 5 Rope Climb(15ft)
// - 50 Push-ups
//  
//  
//  
//  
//  
//  
// Luce
// Wearing a *(20lb)vest, 3 rounds for time of:
// - 1km Run
// - 10 Muscle-ups
// - 100 Squats
//  
//  
//  
//  
//  
//  
// Johnson
// Complete as many rounds in 20 minutes as you can of:
// - 9 Deadlifts*(245lb)
// - 8 Muscle-ups
// - 9 Squat Cleans*(155lb)
//  
//  
//  
//  
//  
//  
// Roy
// 5 rounds for time of:
// - 15 Deadlifts*(225lb)
// - 20 Box Jumps(24inch)
// - 25 Pull-ups
//  
//  
//  
//  
//  
//  
// AdambRown
// 2 rounds for time of:
// - 24 Deadlifts*(295lb)
// - 24 Box Jumps(24inch)
// - 24 Wallball Shots*(20lb)
// - 24 Bench Presses*(195lb)
// - 24 Box Jumps(24inch)
// - 24 Wallball Shots*(20lb)
// - 24 Cleans*(145lb)
//  
//  
//  
//  
//  
//  
// Coe
// 5 rounds for time of:
// - 10 Thrusters*(95lb)
// - 10 Ring Push-ups
//  
//  
//  
//  
//  
//  
// Severin
// - 50 Strict Pull-ups
// - 100 Push-ups, release hands from floor at the bottom
// - 5km Run
//  
//  
//  
//  
//  
//  
// Helton
// 3 rounds for time of:
// - 800m Run
// - 30 Dumbbell Squat Cleans*(50lb)
// - 30 Burpees
//  
//  
//  
//  
//  
//  
// Jack
// Complete as many rounds as possible in 20 minutes of:
// - 10 Push Presses*(115lb)
// - 10 KB Swings*(1.5pood)
// - 10 Box Jumps(24inch)
//  
//  
//  
//  
//  
//  
// Forrest
// 3 rounds for time of:
// - 20 L-Pull-ups
// - 30 Toes to Bar
// - 40 Burpees
// - 800m Run
//  
//  
//  
//  
//  
//  
// Bulger
// 10 rounds for time of:
// - 150m Run
// - 7 Chest to Bar Pull-ups
// - 7 Front Squats*(135lb)
// - 7 Handstand Push-ups
//  
//  
//  
//  
//  
//  
// Brenton
// 5 rounds for time of:
// - Bear Crawl 100 feet
// - Standing Broad-Jump, 100 feet
//  
//  
//  
//  
//  
//  
// Blake
// 4 rounds for time of:
// - 100ft Walking OverHead Lunge with Plate*(45lb)
// - 30 Box Jumps(24inch)
// - 20 Wallball Shots*(20lb)
// - 10 Handstand Push-ups
//  
//  
//  
//  
//  
//  
// Collin
// 6 rounds for time of:
// - 400m Sandbag Carry*(50lb)
// - 12 Push Presses*(115lb)
// - 12 Box Jumps(24inch)
// - 12 Sumo Deadlift-high-Pulls*(95lb)
//  
//  
//  
//  
//  
//  
// Thompson
// 10 rounds for time of:
// - 1 Rope Climb(15ft)
// - 29 Back Squats*(95lb)
// - 10m Barbells Farmer Carry*(135lb)
//  
//  
//  
//  
//  
//  
// Whitten
// 5 rounds for time of:
// - 22 Kettlebell Swings*(2pood)
// - 22 Box Jumps(24inch)
// - 400m Run
// - 22 Burpees
// - 22 Wallball Shots*(20lb)
//  
//  
//  
//  
//  
//  
// Bull
// 2 rounds for time of:
// - 200 Double Unders
// - 50 Overhead Squats*(135lb)
// - 50 Pull-ups
// - 1.6km Run
//  
//  
//  
//  
//  
//  
// Rankel
// Complete as many rounds as possible in 20 minutes of:
// - 6 Deadlift*(225lb)
// - 7 Burpee Pull-ups
// - 10 Kettlebell Swings*(2pood)
// - 200m Run
//  
//  
//  
//  
//  
//  
// Holbrook
// 10 rounds, each for time of:
// - 5 Thrusters*(115lb)
// - 10 Pull-ups
// - 100m Sprint
// - Rest 1 minute
//  
//  
//  
//  
//  
//  
// Ledesma
// Complete as many rounds as possible in 20 minutes of:
// - 5 Parallette Handstand Push-ups
// - 10 Toes Through Rings
// - 15 Medicineball Cleans*(20lb)
//  
//  
//  
//  
//  
//  
// Wittman
// 7 rounds for time of:
// - 15 Kettlebell Swings*(1.5pood)
// - 15 Power Cleans*(95lb)
// - 15 Box Jumps(24inch)
//  
//  
//  
//  
//  
//  
// McCluskey
// 3 rounds of:
// - 9 Muscle-ups
// - 15 Burpee Pull-ups
// - 21 Pull-ups
// - 800m Run
//  
//  
//  
//  
//  
//  
// Weaver
// 4 rounds for time of:
// - 10 L-Pull-ups
// - 15 Push-ups
// - 15 Chest to Bar Pull-ups
// - 15 Push-ups
// - 20 Pull-ups
// - 15 Push-ups
//  
//  
//  
//  
//  
//  
// Abbate
// - 1.6km Run
// - 21 Clean and Jerks*(155lb)
// - 800m Run
// - 21 Clean and Jerks*(155lb)
// - 1.6km Run
//  
//  
//  
//  
//  
//  
// Hammer
// 5 rounds, each for time, of:
// - 5 Power Cleans*(135lb)
// - 10 Front Squats*(135lb)
// - 5 Jerks*(135lb)
// - 20 Pull-ups
// - Rest 90 seconds
//  
//  
//  
//  
//  
//  
// Moore
// Complete as many rounds in 20 minutes as you can of:
// - 1 Rope Climb(15ft)
// - 400m Run
// - Max Rep Handstand Push-up
//  
//  
//  
//  
//  
//  
// Wilmot
// 6 rounds for time of:
// - 50 Squats
// - 25 Ring Dips
//  
//  
//  
//  
//  
//  
// Moon
// 7 rounds for time of:
// - 10 Dumbbell Hang Split Snatches*(40lb)
// - 1 Rope Climb(15ft)
// - 10 Dumbbell Hang Split Snatches*(40lb)
// - 1 Rope Climb(15ft)
// Alternate feet in the Split Snatch sets.
//  
//  
//  
//  
//  
//  
// Small
// 3 rounds for time of:
// - 1,000m Row
// - 50 Burpees
// - 50 Box Jumps(24inch)
// - 800m Run
//  
//  
//  
//  
//  
//  
// Morrison
// 50-40-30-20 and 10 Reo rounds of:
// - Wallball Shots*(20lb)
// - Box Jumps(24inch)
// - Kettlebell Swings*(1.5pood)
//  
//  
//  
//  
//  
//  
// Manion
// 7 rounds for time of:
// - 400m Run
// - 29 Back Squats*(135lb)
//  
//  
//  
//  
//  
//  
// Gator
// 8 rounds for time of:
// - 5 Front Squats*(185lb)
// - 26 Ring Push-ups
//  
//  
//  
//  
//  
//  
// Bradley
// 10 rounds for time of:
// - Sprint 100 ms
// - 10 Pull-ups
// - Sprint 100 ms
// - 10 Burpees
// - Rest 30 seconds
//  
//  
//  
//  
//  
//  
// Meadows
// For time:
// - 20 Muscle-ups
// - 25 Lowers from an inverted Hang on the rings, slowly, with straight body and Arms
// - 30 Ring Handstand Push-ups
// - 35 Ring Rows
// - 40 Ring Push-ups
//  
//  
//  
//  
//  
//  
// Santiago
// 7 rounds for time of:
// - 18 Dumbbell Hang Squat Cleans*(35lb)
// - 18 Pull-ups
// - 10 Power Cleans*(135lb)
// - 10 Handstand Push-ups
//  
//  
//  
//  
//  
//  
// Carse
// 21-18-15-12-9-6-3 Reos for time of:
// - Squat Cleans*(95lb)
// - Double Unders
// - Deadlifts*(185lb)
// - Box Jumps(24inch)
// Begin each round with a 50 m Bear Crawl.
//  
//  
//  
//  
//  
//  
// Bradshaw
// 10 rounds for time of:
// - 3 Handstand Push-ups
// - 6 Deadlifts*(225lb)
// - 12 Pull-ups
// - 24 Double Unders
//  
//  
//  
//  
//  
//  
// White
// 5 rounds for time of:
// - 3 Rope climb(15ft)
// - 10 Toes to Bar
// - 21 Walking Lunge Steps with Plate*(45lb)
// - 400m Run
//  
//  
//  
//  
//  
//  
// Santora
// 3 rounds for Reos of:
// - 1min Squat Cleans*(155lb)
// - 20′ Shuttle Sprints (20′ forward + 20′ Backwards = 1 Reo), 1 minute
// - 1min Deadlifts*(245lb)
// - 1min Burpees
// - 1min Jerks*(155lb)
// - Rest 1 minute
//  
//  
//  
//  
//  
//  
// Wood
// 5 Rounds for time of:
// - 400m Run
// - 10 Burpee Box Jumps(24inch)
// - 10 Sumo-deadlift-high-Pull*(95lb)
// - 10 Thrusters*(95lb)
// - Rest 1 minute
//  
//  
//  
//  
//  
//  
// Hidalgo
// For time:
// - 3.2km Run
// - Rest 2 minutes
// - 20 Squat Cleans*(135lb)
// - 20 Box Jumps(24 inch)
// - 20 Walking Lunge Steps with Plate*(45lb)
// - 20 Box Jumps(24inch)
// - 20 Squat Cleans*(135lb)
// - Rest 2 minutes
// - 3.2km Run
//  
//  
//  
//  
//  
//  
// Ricky
// Complete as many rounds as possible in 20 minutes of:
// - 10 Pull-ups
// - 5 Dumbbell Deadlifts*(75lb)
// - 8 Push-Presses*(135lb)
//  
//  
//  
//  
//  
//  
// Dae Han
// 3 rounds for time of:
// - 800m Run*(45lb)
// - 3 Rope climb(15ft)
// - 12 Thrusters*(135lb)
//  
//  
//  
//  
//  
//  
// Desforges
// 5 rounds for time of:
// - 12 Deadlifts*(225lb)
// - 20 Pull-ups
// - 12 Clean and Jerk*(135lb)
// - 20 Knees to Elbows
//  
//  
//  
//  
//  
//  
// Rahoi
// Complete as many rounds as possible in 12 minutes of:
// - 12 Box Jumps(24inch)
// - 6 Thrusters*(95lb)
// - 6 Bar-facing Burpees
//  
//  
//  
//  
//  
//  
// Zimmerman
// Complete as many rounds as possible in 25 minutes of:
// - 11 Chest-to-Bar Pull-ups
// - 2 Deadlifts*(315lb)
// - 10 Handstand Push-ups
//  
//  
//  
//  
//  
//  
// Klepto
// 4 rounds for time of:
// - 27 Box Jumps(24inch)
// - 20 Burpees
// - 11 Squat Cleans*(145lb)
//  
//  
//  
//  
//  
//  
// Del
// For Time:
// - 25 Burpees
// - 400m Run with medicineball*(20lb)
// - 25 Weighted Pull-ups with DB*(20lb)
// - 400m Run with medicineball*(20lb)
// - 25 Handstand Push-ups
// - 400m Run with medicineball*(20lb)
// - 25 Chest-to-Bar Pull-ups
// - 400m Run with medicineball*(20lb)
// - 25 Burpees
//  
//  
//  
//  
//  
//  
// Pheezy
// 3 rounds for time of:
// - 5 Front Squats*(165lb)
// - 18 Pull-ups
// - 5 Deadlifts*(225lb)
// - 18 Toes-to-Bar
// - 5 Push Jerks*(165lb)
// - 18 Hand-release Push-ups
//  
//  
//  
//  
//  
//  
// J.J.
// For time:
// - 1 Squat Cleans*(185lb)
// - 10 Parallette Handstand Push-ups
// - 2 Squat Cleans*(185lb)
// - 9 Parallette Handstand Push-ups
// - 3 Squat Cleans*(185lb)
// - 8 Parallette Handstand Push-ups
// - 4 Squat Cleans*(185lb)
// - 7 Parallette Handstand Push-ups
// - 5 Squat Cleans*(185lb)
// - 6 Parallette Handstand Push-ups
// - 6 Squat Cleans*(185lb)
// - 5 Parallette Handstand Push-ups
// - 7 Squat Cleans*(185lb)
// - 4 Parallette Handstand Push-ups
// - 8 Squat Cleans*(185lb)
// - 3 Parallette Handstand Push-ups
// - 9 Squat Cleans*(185lb)
// - 2 Parallette Handstand Push-ups
// - 10 Squat Cleans*(185lb)
// - 1 Parallette Handstand Push-up
//  
//  
//  
//  
//  
//  
// Jag 28
// For time:
// - 800m Run
// - 28 Kettlebell Swings*(2pood)
// - 28 Strict Pull-ups
// - 28 Kettlebell Clean and Jerk, each side*(2pood)
// - 28 Strict Pull-ups
// - 800m Run
//  
//  
//  
//  
//  
//  
// Brian
// 3 rounds for time of:
// - 5 Rope climbs(15ft)
// - 5 Back Squats*(185lb)
//  
//  
//  
//  
//  
//  
// Nick
// 12 rounds for time of:
// - 10 Dumbbell Hang Squat Cleans*(45lb)
// - 6 Handstand Push-ups on Dumbbells
//  
//  
//  
//  
//  
//  
// Strange
// 8 rounds for time of:
// - 600m Run
// - 11 KB Weighted Pull-up*(1.5pood)
// - 11 KB Walking Lunge Steps*(1.5pood)
// - 11 KB Thrusters*(1.5pood)
//  
//  
//  
//  
//  
//  
// Tumilson
// 8 rounds for time of:
// - 200m Run
// - 11 Dumbbell Burpee Deadlifts*(60lb)
//  
//  
//  
//  
//  
//  
// Ship
// - 9 rounds for time of:
// - 7 Squat Cleans*(185lb)
// - 8 Burpee Box Jumps(36 inch)
//  
//  
//  
//  
//  
//  
// Jared
// 4 rounds for time of:
// - 800m Run
// - 40 Pull-ups
// - 70 Push-ups
//  
//  
//  
//  
//  
//  
// Tully
// 4 rounds for time of:
// - 200m Swim
// - 23 DB Squat Cleans*(40lb)
//  
//  
//  
//  
//  
//  
// Holleyman
// 30 rounds for time of:
// - 5 Wallball Shots*(20lb)
// - 3 Handstand Push-ups
// - 1 Power Cleans*(225lb)
//  
//  
//  
//  
//  
//  
// Adrian
// 7 rounds for time of:
// - 3 Forward rolls
// - 5 Wall climbs
// - 7 Toes to Bar
// - 9 Box Jumps(30 inch)
//  
//  
//  
//  
//  
//  
// Glen
// For time:
// - 30 Clean and Jerk*(135lb)
// - 1.6km Run
// - 10 Rope climbs(15ft)
// - 1.6km Run
// - 100 Burpees
//  
//  
//  
//  
//  
//  
// Tom
// Complete as many rounds in 25 minutes as you can of:
// - 7 Muscle-ups
// - 11 Thrusters*(155lb)
// - 14 Toes-to-Bar
//  
//  
//  
//  
//  
//  
// Ralph
// 4 rounds for time of:
// - 8 Deadlifts*(250lb)
// - 16 Burpees
// - 3 Rope climbs(15ft)
// - 600m Run
//  
//  
//  
//  
//  
//  
// Clovis
// For time:
// - 10mile Run
// - 150 Burpee Pull-ups
// Partition the Run and Burpee Pull-ups as needed.
//  
//  
//  
//  
//  
//  
// Weston
// 5 rounds for time of:
// - 1,000m Row
// - 200m Farmer Carry*(45lb)
// - 50m Right Arm Dumbbell Waiter Walk *(45lb)
// - 50m Left Arm Dumbbell Waiter Walk*(45lb)
//  
//  
//  
//  
//  
//  
// Loredo
// 6 rounds for time of:
// - 24 Squats
// - 24 Push-ups
// - 24 Walking Lunge Steps
// - 400m Run
//  
//  
//  
//  
//  
//  
// Sean
// 10 rounds for time of:
// - 11 Chest to Bar Pull-ups
// - 22 Front Squats*(70lb)
//  
//  
//  
//  
//  
//  
// Hortman
// Complete as many rounds as possible in 45 minutes of:
// - 800m Run
// - 80 Squats
// - 8 Muscle-ups
//  
//  
//  
//  
//  
//  
// Hamilton
// 3 rounds for time of:
// - 1,000m Row
// - 50 Push-ups
// - 1,000m Row
// - 50 Pull-ups
//  
//  
//  
//  
//  
//  
// Zeus
// 3 rounds for time of:
// - 30 Wallball Shots*(20lb)
// - 30 Sumo Deadlift-high-Pull*(75lb)
// - 30 Box Jumps(20 inch)
// - 30 Push Presses*(75lb)
// - 30cal Row
// - 30 Push-ups
// - 10 Back Squats(Body weight)
//  
//  
//  
//  
//  
//  
// Barraza
// Complete as many rounds as possible in 18 minutes of:
// - 200m Run
// - 9 Deadlifts*(275lb)
// - 6 Burpee Bar muscle-ups
//  
//  
//  
//  
//  
//  
// Cameron
// For time:
// - 50 Walking Lunge Steps
// - 25 Chest to Bar Pull-ups
// - 50 Box Jumps(24inch)
// - 25 Triple-Unders
// - 50 Back Extensions
// - 25 Ring dips
// - 50 Knees to Elbows
// - 25 Wallball Shots*(20lb)
// - 50 Sit-ups
// - 5 Rope climbs(15ft)
//  
//  
//  
//  
//  
//  
// Jorge
// For time:
// - 30 GHD Sit-ups
// - 15 Squat Cleans*(155lb)
// - 24 GHD Sit-ups
// - 12 Squat Cleans
// - 18 GHD Sit-ups
// - 9 Squat Cleans
// - 12 GHD Sit-ups
// - 6 Squat Cleans
// - 6 GHD Sit-ups
// - 3 Squat Cleans
//  
//  
//  
//  
//  
//  
// Schmalls
// - 800m Run
// Then 2 rounds of:
// - 50 Burpees
// - 40 Pull-ups
// - 30 One-Legged Squats
// - 20 Kettlebell Swings*(1.5pood)
// - 10 Handstand Push-ups
// Then,
// - 800m Run
//  
//  
//  
//  
//  
//  
// Brehm
// For time:
// - 10 Rope climbs(15ft)
// - 20 Back Squats*(225lb)
// - 30 Handstand Push-ups
// - 40cal Row
//  
//  
//  
//  
//  
//  
// Omar
// For time:
// - 10 Barbell Thrusters*(95lb)
// - 15 Bar-facing Burpees
// - 20 Barbell Thrusters
// - 25 Bar-facing Burpees
// - 20 Barbell Thrusters
// - 35 Bar-facing Burpees
//  
//  
//  
//  
//  
//  
// Gallant
// For time:
// - 1.6km Run with medicineball *(20lb)
// - 60 Burpee Pull-ups
// - 800m Run with medicineball *(20lb)
// - 30 Burpee Pull-ups
// - 400m Run with medicineball *(20lb)
// - 15 Burpee Pull-ups
//  
//  
//  
//  
//  
//  
// Bruck
// 4 rounds for time of:
// - 400m Run
// - 24 Back Squats*(185lb)
// - 24 Jerks*(135lb)
//  
// Smykowski
// For time:
// - 6km Run
// - 60 Burpee Pull-ups
//  
//  
//  
//  
//  
//  
// Falkel
// Complete as many rounds as possible in 25 minutes of:
// - 8 Handstand Push-ups
// - 8 Box Jumps(30 inch)
// - 1 Rope climb(15ft)
//  
//  
//  
//  
//  
//  
// Donny
// 21-15-9-9-15-21 Reos for time of:
// - Deadlift*(225lb)
// - Burpee
//  
//  
//  
//  
//  
//  
// Dobogai
// 7 rounds for time of:
// - 8 Muscle-ups
// - 22 yard Dumbbells Farmer Carry*(50lb)
//  
//  
//  
//  
//  
//  
// HotShots 19
// 6 rounds for time of:
// - 30 Squats
// - 19 Power Cleans*(135lb)
// - 7 Strict Pull-ups
// - 400m Run
//  
//  
//  
//  
//  
//  
// Roney
// 4 rounds for time of:
// - 200m Run
// - 11 Thrusters*(135lb)
// - Run 200 ms
// - 11 Push Presses
// - Run 200 ms
// - 11 Bench Presses
//  
//  
//  
//  
//  
//  
// The Don
// For time:
// - 66 Deadlifts*(110lb)
// - 66 Box Jumps(24 inch)
// - 66 Kettlebell Swings*(1.5pood)
// - 66 Knees to Elbows
// - 66 Sit-ups
// - 66 Pull-ups
// - 66 Thrusters*(55lb)
// - 66 Wallball Shots*(20lb)
// - 66 Burpees
// - 66 Double Unders
//  
//  
//  
//  
//  
//  
// Dragon
// For time:
// - 5km Run
// - 4 minutes to find 4 max Deadlift
// - 5km Run
// - 4 minutes to find 4 max Push Jerk
//  
//  
//  
//  
//  
//  
// Walsh
// 4 rounds for time of:
// - 22 Burpee Pull-ups
// - 22 Back Squats*(185lb)
// - 200m Run with overhead Plate*(45lb)
//  
//  
//  
//  
//  
//  
// Lee
// 5 rounds for time of:
// - 400m Run
// - 1 Deadlift*(345lb)
// - 3 Squat Cleans*(185lb)
// - 5] Push Jerks*(185lb)
// - 3 Muscle-ups
// - 1 Rope climb(15ft)
//  
//  
//  
//  
//  
//  
// Willy
// 3 rounds for time of:
// - 800m Run
// - 5 Front Squats*(225lb)
// - 200m Run
// - 11 Chest to Bar Pull-ups
// - 400m Run
// - 12 Kettlebell Swings*(2pood)
//  
//  
//  
//  
//  
//  
// Coffey
// For time:
// - 800m Run
// - 50 Back Squats*(135lb)
// - 50 Bench Presses*(135lb)
// - 800m Run
// - 35 Back Squats*(135lb)
// - 35 Bench Presses*(135lb)
// - 800m Run
// - 20 Back Squats*(135lb)
// - 20 Bench Presses*(135lb)
// - 800m Run
// - 1 Muscle-up
//  
//  
//  
//  
//  
//  
// DG
// Complete as many rounds as possible in 10 minutes of:
// - 8 Toes to Bar
// - 8 Dumbbell Thrusters*(35lb)
// - 12 Step Dumbbell Walking Lunge*(35lb)
//  
//  
//  
//  
//  
//  
// TK
// Complete as many rounds as possible in 20 minutes of:
// - 8 Strict Pull-ups
// - 8 Box Jumps(36 inch)
// - 12 Kettlebell Swings*(2pood)
//  
//  
//  
//  
//  
//  
// Taylor
// 4 rounds for time of:
// - 400m Run
// - 5 Burpee muscle-ups
// If you’ve got a *(20lb). vest or body Armor, wear it.
//  
//  
//  
//  
//  
//  
// Justin
// 30-20-10 Reos for time of:
// - Body-weight Back Squats
// - Body-weight Bench Presses
// - Strict Pull-ups
//  
//  
//  
//  
//  
//  
// Nukes
// 8 minutes to complete:
// - 1.6km Run
// - Deadlifts, max Reos*(315lb)
// Then, 10 minutes to complete:
// - 1.6km Run
// - Power Cleans, max Reos*(225lb)
// Then, 12 minutes to complete:
// - 1.6km Run
// - overhead Squats, max Reos*(135lb)
// Do not rest between rounds.
//  
//  
//  
//  
//  
//  
// Zembiec
// 5 rounds for time of:
// - 11 Back Squats*(185lb)
// - 7 Strict Burpee Pull-ups
// - 400m Run
//  
//  
//  
//  
//  
//  
// Alexander
// 5 rounds for time of:
// - 31 Back Squats*(135lb)
// - 12 Power Cleans*(185lb)
//  
//  
//  
//  
//  
//  
// Wyk
// 5 rounds for time:
// - 5 Front Squats*(225lb)
// - 5 rope climbs(15ft)
// - 400m Run with Plate*(45lb)
//  
//  
//  
//  
//  
//  
// Bell
// 3 rounds for time of:
// - 21 Deadlifts*(185lb)
// - 15 Pull-ups
// - 9 Front Squats*(185lb)
//  
//  
//  
//  
//  
//  
// JBo
// Complete as many rounds as possible in 28 minutes of:
// - 9 overhead Squats*(115lb)
// - 1 legless rope climb(15ft)
// - 12 Bench Presses*(115lb)
//  
//  
//  
//  
//  
//  
// Kevin
// 3 rounds for time of:
// - 32 Deadlifts*(185lb)
// - 32 Hanging hip touches, 
// - DB alternating Arms 800m Running fArmer Carry*(15lb)
//  
//  
//  
//  
//  
//  
// Rocket
// Complete as many rounds as possible in 30 minutes of:
// - 50 yard swim
// - 10 Push-ups
// - 15 Squats
//  
//  
//  
//  
//  
//  
// Riley
// For time:
// - 2.4km Run 
// - 150 Burpees
// - 2.4km Run 
// If you’ve got a weight vest or body Armor, wear it.
//  
//  
//  
//  
//  
//  
// Feeks
// For time:
// - 2 x 100-m Shuttle Sprint
// - 2 DB Squat Clean Thrusters*(65lb)
// - 4 x 100-m Shuttle Sprint
// - 4 DB Squat Clean Thrusters
// - 6 x 100-m Shuttle Sprint
// - 6 DB Squat Clean Thrusters
// - 8 x 100-m Shuttle Sprint
// - 8 DB Squat Clean Thrusters
// - 10 x 100-m Shuttle Sprint
// - 10 DB Squat Clean Thrusters
// - 12 x 100-m Shuttle Sprint
// - 12 DB Squat Clean Thrusters
// - 14 x 100-m Shuttle Sprint
// - 14 DB Squat Clean Thrusters
// - 16 x 100-m Shuttle Sprint
// - 16 DB Squat Clean Thrusters
//  
//  
//  
//  
//  
//  
// Ned
// 7 rounds for time of:
// - 11 Body-weight Back Squats
// - 1,000m Row
//  
//  
//  
//  
//  
//  
// Sham
// 7 rounds for time of:
// - 11 body-weight Deadlifts
// - 100m Sprint
//  
//  
//  
//  
//  
//  
// Ozzy
// 7 rounds for time of:
// - 11 deficit Handstand Push-ups
// - 1,000m Run
//  
//  
//  
//  
//  
//  
// Jenny
// Complete as many rounds as possible in 20 minutes of:
// - 20 overhead Squats*(45lb)
// - 20 Back Squats*(45lb)
// - 400m Run
//  
//  
//  
//  
//  
//  
// Spehar
// For time:
// - 100 Thrusters*(135lb)
// - 100 Chest-to-Bar Pull-ups
// - 9.6km Run
// Partition the Thrusters, Pull-ups and Run as needed.
//  
//  
//  
//  
//  
//  
// Luke
// For time:
// - 400m Run
// - 15 Clean and Jerks*(155lb)
// - 400m Run
// - 30 Toes-to-Bars
// - 400m Run
// - 45 Wallball Shots*(20lb)
// - 400m Run
// - 45 Kettlebell Swings*(1.5pood)
// - 400m Run
// - 30 ring dips
// - 400m Run
// - 15 Step weighted Lunges*(155lb)
// - 400m Run
//  
//  
//  
//  
//  
//  
// Robbie
// Complete as many rounds as possible in 25 minutes of:
// - 8 Freestanding Handstand Push-ups
// - 1 L-sit rope climb(15ft)
//  
//  
//  
//  
//  
//  
// Shawn
// For time:
// - 8km Run
// - Run in 5-minute intervals, stopping after each to perform 50 Squats and 50 Push-ups before beginning the next 5-minute Run interval.
//  
//  
//  
//  
//  
//  
// Foo
// - 13 Bench Presses*(170lb)
// Then, complete as many rounds as possible in 20 minutes of:
// - 7 Chest-to-Bar Pull-ups
// - 77 Double-Unders
// - 2 Squat Clean Thrusters*(170lb)
// - 28 Sit-ups
//  
//  
//  
//  
//  
//  
// Bowen
// 3 rounds for time of:
// - 800m Run
// - 7 Deadlifts*(275lb)
// - 10 Burpee Pull-ups
// - 14 Single Arm Kettlebell Thrusters*(53lb)
// - 20 Box Jumps(24inch)
//  
//  
//  
//  
//  
//  
// Gaza
// 5 rounds for time of:
// - 35 Kettlebell Swings*(1.5pood)
// - 30 Push-ups
// - 25 Pull-ups
// - 20 Box Jumps(30inch)
// - 1.6km Run
//  
//  
//  
//  
//  
//  
// Crain
// 2 rounds for time of:
// - 34 Push-ups
// - 50-yard Sprint
// - 34 Deadlifts*(135lb)
// - 50-yard Sprint
// - 34 Box Jumps(24inch)
// - 50-yard Sprint
// - 34 Clean and Jerks*(95lb)
// - 50-yard Sprint
// - 34 Burpees
// - 50-yard Sprint
// - 34 Wallball Shots*(20lb)
// - 50-yard Sprint
// - 34 Pull-ups
// - 50-yard Sprint
//  
//  
//  
//  
//  
//  
// Capoot
// For time:
// - 100 Push-ups
// - 800m Run
// - 75 Push-ups
// - 1,200m Run
// - 50 Push-ups
// - 1,600m Run
// - 25 Push-ups
// - 2,000m Run
//  
//  
//  
//  
//  
//  
// Hall
// 5 rounds for time of:
// - 3 Cleans*(225lb)
// - 200m Sprint
// - 20 Kettlebell Snatches*(1.5pood)
// - Rest 2 minutes
//  
//  
//  
//  
//  
//  
// Servais
// For time:
// - 2.4km Run
// Then, 8 rounds of:
// - 19 Pull-ups
// - 19 Push-ups
// - 19 Burpees
// Then,
// - 400m Sandbag Carry(heavy)
// - 1.6km DB Farmers Carry*(45lb)
//  
//  
//  
//  
//  
//  
// PK
// 5 rounds for time of:
// - 10 Back Squats*(225lb)
// - 10 Deadlifts*(275lb)
// - 400m Sprint
// - Rest 2 minutes
//  
//  
//  
//  
//  
//  
// Marco
// 3 rounds for time of:
// - 21 Pull-ups
// - 15 Handstand Push-ups
// - 9 Thrusters*(135lb)
//  
//  
//  
//  
//  
//  
// René
// 7 rounds for time of:
// - Run 400 ms
// - 21 WalkingLunges
// - 15 Pull-ups
// - 9 Burpees
// If you have a *(20lb). weight vest or body Armor, wear it.
//  
//  
//  
//  
//  
//  
// Pike
// 5 rounds for time of:
// - 20 Thrusters*(75lb)
// - 10 Strict ring dips
// - 20 Push-ups
// - 10 Strict Handstand Push-ups
// - 50m Bear Crawl
//  
//  
//  
//  
//  
//  
// Kutschbach
// 7 rounds for time of:
// - 11 Back Squats*(185lb)
// - 10 Jerks*(135lb)
//  
//  
//  
//  
//  
//  
// Jennifer
// Complete as many rounds as possible in 26 minutes of:
// - 10 Pull-ups
// - 15 Kettlebell Swings*(1.5pood)
// - 20 Box Jumps(24inch)
//  
//  
//  
//  
//  
//  
// Horton
// 9 rounds for time with a partner of:
// - 9 Bar muscle-ups
// - 11 Clean and Jerks*(155lb)
// - 50 yard buddy Carry
// Share the work with your partner however you choose with only one person working at a time. If you can’t find a partner, perform 5 Reos of each exercise per round and find a heavy sandbag to Carry.
//  
//  
//  
//  
//  
//  
// Scooter
// On a 35-minute clock with a partner:
// Complete as many rounds as possible in 30 minutes of:
// - 30 Double-Unders
// - 15 Pull-ups
// - 15 Push-ups
// - 100-m Sprint
// - Then, 5 minutes to find a 1-Reo-max partner Deadlift
// For the AMRAP, have one partner work while the other rests, switching after a full round is completed. If you’re performing without a partner, rest 60 seconds between each round, and find a regular 1-Reo-max Deadlift.
//  
//  
//  
//  
//  
//  
// Matt 16
// For time:
// - 16 Deadlifts*(275lb)
// - 16 Hang Power Cleans*(185lb)
// - 16 Push Presses*(135lb)
// - 800m Run
// - 16 Deadlifts*(275lb)
// - 16 Hang Power Cleans*(185lb)
// - 16 Push Presses*(135lb)
// - 800m Run
// - 16 Deadlifts*(275lb)
// - 16 Hang Power Cleans*(185lb)
// - 16 Push Presses*(135lb)
//  
//  
//  
//  
//  
//  
// T.U.P.
// 15-12-9-6-3 Reos for time of:
// - Power Cleans*(135lb)
// - Pull-ups
// - Front Squats*(135lb)
// - Pull-ups
//  
//  
//  
//  
//  
//  
// Harper
// Complete as many rounds as possible in 23 minutes of:
// - 9 Chest-to-Bar Pull-ups
// - 15 Power Cleans*(135lb)
// - 21 Squats
// - 400m Run with Plate*(45lb)
//  
//  
//  
//  
//  
//  
// Sisson
// Complete as many rounds as possible in 20 minutes of:
// - 1 rope climb(15ft)
// - 5 Burpees
// - 200m Run
// If you’ve got a *(20lb). vest or body Armor, wear it.
//  
//  
//  
//  
//  
//  
// Terry
// For time:
// - 1.6km Run
// - 100 Push-ups
// - 100m Bear Crawl
// - 1.6km Run
// - 100m Bear Crawl
// - 100 Push-ups
// - 1.6km Run
//  
//  
//  
//  
//  
//  
// Big Sexy
// - 5 rounds for time of:
// - 6 Deadlifts*(315lb)
// - 6 Burpees
// - 5 Cleans*(225lb)
// - 5 Chest-to-Bar Pull-ups
// - 4 Thrusters*(155lb)
// - 4 muscle-ups
//  
//  
//  
//  
//  
//  
// Woehlke
// 3 rounds, each for time of:
// - 4 Jerks*(185lb)
// - 5 Front Squats*(185lb)
// - 6 Power Cleans*(185lb)
// - 40 Pull-ups
// - 50 Push-ups
// - 60 Sit-ups
// Rest 3 minutes between rounds.
//  
//  
//  
//  
//  
//  
// Maupin
// 4 rounds for time of:
// - 800m Run
// - 49 Push-ups
// - 49 Sit-ups
// - 49 Squats
//  
//  
//  
//  
//  
//  
// Hildy
// - 100cal Row
// - 75 Thrusters*(45lb)
// - 50 Pull-ups
// - 75 Wallball Shots*(20lb)
// - 100cal Row
// If you’ve got a *(20lb). vest or body Armor, wear it.
//  
//  
//  
//  
//  
//  
// T.J.
// For time:
// - 10 Bench Presses*(185lb)
// - 10 Strict Pull-ups
// - Thrusters, max set*(135lb)
// Repeat the triplet until you have completed 100 Reos of the Thruster.
//  
//  
//  
//  
//  
//  
// Monti
// 5 rounds for time of:
// - 50 step-ups, 20inch*(45lb)
// - 15 Cleans*(135lb)
// - 50 step-ups, 20inch*(45lb)
// - 10 Snatches*(135lb)
//  
//  
//  
//  
//  
//  
// DVB
// For time:
// - 1.6km Run with medicineball*(20lb)
// Then, 8 rounds of:
// - 10 Wallball Shots
// - 1 rope ascent
// - 800m Run with medicineball*(20lb)
// Then, 4 rounds of:
// - 10 Wallball Shots
// - 1 rope ascent
// - 400m Run with medicineball*(20lb)
// Then, 2 rounds of:
// - 10 Wallball Shots
// - 1 rope ascent
//  
//  
//  
//  
//  
//  
// Nickman
// With a *(55lb) and *(35lb) Dumbbell, 10 rounds for time of:
// - 200m fArmers Carry*(55/35lb)
// - 10 weighted Pull-ups*(35lb)
// - 20 Dumbbell Power Snatches*(55lb)
//  
//  
//  
//  
//  
//  
// Marston
// Complete as many rounds as possible in 20 minutes of:
// - 1 Deadlift*(405lb)
// - 10 Toes-to-Bars
// - 15 Bar-facing Burpees
//  
//  
//  
//  
//  
//  
// Artie
// Complete as many rounds as possible in 20 minutes of:
// - 5 Pull-ups
// - 10 Push-ups
// - 15 Squats
// - 5 Pull-ups
// - 10 Thrusters*(95lb)
//  
//  
//  
//  
//  
//  
// Hollywood
// For time:
// - 2km Run
// - 22 Wallball Shots*(30lb)
// - 22 muscle-ups
// - 22 Wallball Shots
// - 22 Power Cleans*(185lb)
// - 22 Wallball Shots
// - 2km Run
//  
//  
//  
//  
//  
//  
// Manuel
// 5 rounds of:
// - 3 minutes of rope climbs
// - 2 minutes of Squats
// - 2 minutes of Push-ups
// - 3 minutes to 400m Run
// Wear a weight vest or body Armor. After the Run, rest for the remainder of the 3 minutes before beginning the next round.
//  
//  
//  
//  
//  
//  
// Tiff
// On a 25-minute clock,
// - 2.4km Run
// Then perform as many rounds as possible of:
// - 11 Chest-to-Bar Pull-ups
// - 7 Hang Squat Cleans*(155lb)
// - 7 Push Presses*(155lb)
//  
//  
//  
//  
//  
//  
// Paul Pena
// 7 rounds, each for time of:
// - 100m Sprint
// - 19 Kettlebell Swings*(2pood)
// - 10 Burpee Box Jumps(24inch)
// - Rest 3 minutes
//  
//  
//  
//  
//  
//  
// Yeti
// For time:
// - 25 Pull-ups
// - 10 muscle-ups
// - 2.4km Run
// - 10 muscle-ups
// - 25 Pull-ups
//  
//  
//  
//  
//  
//  
// Liam
// For time:
// - 800m Run with Plate*(45lb)
// - 100 Toes-to-Bars
// - 50 Front Squats*(155lb)
// - 10 rope climbs(15ft))
// - 800m Run with Plate*(45lb)
// Partition the Toes-to-Bars, Front Squats and rope climbs as needed. Start and finish with the Run.
//  
//  
//  
//  
//  
//  
// Wes
// For time:
// - 800m Run with Plate*(25lb)
// Then, 14 rounds of:
// - 5 Strict Pull-ups
// - 4 Burpee Box Jumps(24inch)
// - 3 Cleans*(185lb)
// - Then, 800m Run with Plate*(25lb)
//  
//  
//  
//  
//  
//  
// Miron
// 5 rounds for time of:
// - 800m Run
// - 23 Back Squats, ¾ body weight
// - 13 Deadlifts, 1 ½ body weight
//  
//  
//  
//  
//  
//  
// Pat
// Wearing a *(20lb). vest, 6 rounds for time:
// - 25 Pull-ups
// - 50ft. Front-rack Lunge*(75lb)
// - 25 Push-ups
// - 50ft. Front-rack Lunge*(75lb)
//  
//  
//  
//  
//  
//  
// Scotty
// Complete as many rounds as possible in 11 minutes of:
// - 5 Deadlifts*(315lb)
// - 18 Wallball Shots*(20lb)
// - 17 Burpees over the Bar
//  
//  
//  
//  
//  
//  
// Rich
// For time:
// - 13 Squat Snatches*(155lb)
// Then, 10 rounds of:
// - 10 Pull-ups
// - 100m Sprint
// Then, 13 Squat Cleans*(155lb)
//  
//  
//  
//  
//  
//  
// Dallas 5
// 5 minutes of:
// - Burpees
// Then, 5 minutes of:
// - 7 Deadlifts*(155lb)
// - 7 Box Jumps(24inch)
// Then, 5 minutes of:
// - Turkish Get-ups*(40lb)
// Then, 5 minutes of:
// - 7 Snatches*(75lb)
// - 7 Push-ups
// Then, 5 minutes of:
// - Rowing (calories)
// Complete as many Reos as possible at each 5-minute station. Rest 1 minute between stations.
//  
//  
//  
//  
//  
//  
// Dunn
// Complete as many rounds as possible in 19 minutes of:
// - 3 muscle-ups
// - 1 Shuttle Sprint(5 yards, 10 yards, 15 yards)
// - 6 Burpee Box Jump-overs(20 inch)
// On the Burpees, Jump over the Box without touching it.
//  
//  
//  
//  
//  
//  
// Kev
// With a partner, complete as many rounds as possible in 26 minutes of:
// - 6 Deadlifts*(315lb)
// - 9 Bar-facing Burpees, synchronized
// - 9 Bar muscle-ups, each
// - 55ft. partner Barbell Carry*(315lb)
//  
//  
//  
//  
//  
//  
// Emily
// 10 rounds for time of:
// - 30 Double-Unders
// - 15 Pull-ups
// - 30 Squats
// - 100m Sprint
// - Rest 2 minutes
//  
//  
//  
//  
//  
//  
// Andy
// For time, wearing a *(20lb) vest:
// - 25 Thrusters*(115lb)
// - 50 Box Jumps(24 inch)
// - 75 Deadlifts*(115lb)
// - 2.4km Run
// - 75 Deadlifts*(115lb)
// - 50 Box Jumps(24 inch)
// - 25 Thrusters*(115lb)
//  
//  
//  
//  
//  
//  
// Viola
// Complete as many rounds as possible in 20 minutes of:
// - 400m Run
// - 11 Power Snatches*(95lb)
// - 17 Pull-ups
// - 13 Power Cleans*(95lb)
//  
//  
//  
//  
//  
//  
// Coffland
// Hang from a Pull-up Bar for 6 minutes
// Each time you drop from the Bar, perform:
// - 800m Run
// - 30 Push-ups
//  
//  
//  
//  
//  
//  
// The Lyon
// 5 rounds, each for time of:
// - 7 Squat Cleans*(165lb)
// - 7 Shoulder-to-overheads*(165lb)
// - 7 Burpee Chest-to-Bar Pull-ups
// Rest 2 minutes between rounds.
// Ideally, use a Pull-up Bar that is 6 inches above your max reach when standing.
//  
//  
//  
//  
//  
//  
// T
// 5 rounds for time of:
// - 100m Sprint
// - 10 Squat Clean Thrusters*(115/75lb)
// - 15 Kettlebell Swings*(2/1.5pood)
// - 100m Sprint
// - Rest 2 minutes
//  
//  
//  
//  
//  
//  
// Havana
// Complete as many rounds as possible in 25 minutes of:
// - 150 Double Unders
// - 50 Push-ups
// - 15 Power Cleans*(185/125lb)
//  
//  
//  
//  
//  
//  
// Tama
// For time:
// - 800m Single-Arm Barbell fArmers Carry*(45/35lb)
// - 31 Toes-to-Bars
// - 31 Push-ups
// - 31 Front Squats*(95/65lb)
// - 400m Single-Arm Barbell fArmers Carry*(95/65lb)
// - 31 Toes-to-Bars
// - 31 Push-ups
// - 31 Hang Power Cleans*(135/95lb)
// - 200m Single-Arm Barbell fArmers Carry*(135/95lb)
//  
//  
//  
//  
//  
//  
// Otis
// Complete as many Reos as possible in 15 minutes of:
// - 1 Back Squat, 1 Shoulder Press, 1 Deadlift
// - 2 Back Squats, 2 Shoulder Presses, 2 Deadlifts
// - 3 Back Squats, 3 Shoulder Presses, 3 Deadlifts
// Etc.
// Use 1½ body weight for the Squats and Deadlifts and ¾ body weight for the Presses.
//  
//  
//  
//  
//  
//  
// Josie
// For time, wearing a *(20lb) vest:
// - 1.6km Run
// Then, 3 rounds of:
// - 30 Burpees
// - 4 Power Cleans*(155/105lb)
// - 6 Front Squats*(155/105lb)
// Then, 1.6km Run
//  
//  
//  
//  
//  
//  
// Dork
// 6 rounds for time of:
// - 60 Double-Unders
// - 30 Kettlebell Swings*(1.5/1pood)
// - 15 Burpees
//  
//  
//  
//  
//  
//  
// Bert
// For time:
// - 50 Burpees
// - 400m Run
// - 100 Push-ups
// - 400m Run
// - 150 Walking Lunges
// - 400m Run
// - 200 Squats
// - 400m Run
// - 150 Walking Lunges
// - 400m Run
// - 100 Push-ups
// - 400m Run
// - 50 Burpees
//  
//  
//  
//  
//  
//  
// Wade
// For time, wearing a *(20lb) vest or body Armor:
// - 1,200m Run
// Then, 4 rounds of:
// - 12 Strict Pull-ups
// - 9 Strict dips
// - 6 Strict Handstand Push-ups
// Then, 1,200m Run
//  
//  
//  
//  
//  
//  
// Fournier
// For time:
// - 50 Shoulder-to-overheads*(115/75lb)
// - 50ft. Arm-over-Arm Sled Pull
// - 40 Burpees
// - 50ft. Arm-over-Arm Sled Pull
// - 30 Sumo Deadlift-high Pulls*(85/55lb)
// - 50ft. Arm-over-Arm Sled Pull
// For the Sled Pull, use a load that is challenging but doesn’t require extended rest periods.
//  
//  
//  
//  
//  
//  
// Larry
// 21-18-15-12-9-6-3 Reos for time of:
// - Front Squats*(115/75lb)
// - Bar-facing Burpees
// 200m sandbag Carry after each round*(80/50lb)
//  
//  
//  
//  
//  
//  
// Kelly BRown
// 5 rounds for time of:
// - 440m Row
// - 10 Box Jumps(30/24inch)
// - 10 Deadlifts*(275/185lb)
// - 10 Wallball Shots*(30/20lb)
//  
//  
//  
//  
//  
//  
// Kerrie
// Wearing a weight vest, 10 rounds for time of:
// - 100m Sprint
// - 5 Burpees
// - 20 Sit-ups
// - 15 Push-ups
// - 100m Sprint
// - Rest 2 minutes
//  
//  
//  
//  
//  
//  
// Martin
// For time, with a partner:
// - 2,000m Row
// - 100 Bodyweight Deadlifts
// - 50 Thrusters*(95/65lb)
// - 1,000m Row
// - 100 Hand-release Push-ups
// - 50 Pull-ups
// - 500m Row
// - 100 Sit-ups
// - 100 Wallball Shots*(20/14lb)
//  
//  
//  
//  
//  
//  
// Laura
// With a partner, complete as many rounds as possible in 21 minutes of:
// - 30cal Row
// - 20 Burpees over the Rower
// - 10 Power Cleans*(155/105lb)
//  
//  
//  
//  
//  
//  
// Lorenzo
// For time:
// - 1,000m Run
// Then,
// 5 rounds of:
// - 15 Push-ups
// - 20 Med-ball Cleans
// - 21 Burpees
// Then,
// - 1,000m Run
// ''';

//     var wodlist = wods.split('''
//  
//  
//  
//  
//  
//  
// ''');
//     wodlist.forEach((element) {
//       var elementwod = element.split('''\n''');
//       print(elementwod.length);

//       var title = elementwod[0];
//       var wodparticle = [];
//       elementwod.removeAt(0);
//       elementwod.forEach((wod) {
//         var weight = wod.split("*");
//         if (weight.length == 2) {
//           //print("무게 있음${weight[1]}");
//           if (weight[1].contains("pood")) {
//             //print("케틀벨");
//             var fixedweight = weight[1].replaceAll("(", "").replaceAll(")", "").replaceAll("pood", "").split("/");
//             //print(fixedweight);
//             wodparticle.add({"name": weight[0], "weight": fixedweight, "type": "pood"});
//           } else if (weight[1].contains("lb")) {
//             //print("파운드");
//             var fixedweight = weight[1].replaceAll("(", "").replaceAll(")", "").replaceAll("lb", "").split("/");
//             //print(fixedweight);
//             wodparticle.add({"name": weight[0], "weight": fixedweight, "type": "lb"});
//           }
//         } else {
//           wodparticle.add({"name": wod, "weight": null, "type": null});

//           //print(wod);
//         }
//       });
//       var result = {"title": title, "wods": wodparticle};
//       print(result);
//       FirebaseFirestore.instance.collection("Wods").doc("Hero").set({title: wodparticle}, SetOptions(merge: true));
//     });

//     super.initState();
//   }