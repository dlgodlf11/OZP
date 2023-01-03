import 'dart:io';

import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:sweatbox2dot0/Controller/StatusStateController.dart';
import 'package:sweatbox2dot0/Controller/UserDataController.dart';
import 'package:sweatbox2dot0/Controller/ViewMainStateController.dart';
import 'package:sweatbox2dot0/Widget/Community/PhysicalData.dart';
import 'package:sweatbox2dot0/Widget/StatusWidget/Ablity.dart';
import 'package:sweatbox2dot0/Widget/StatusWidget/Badge.dart';
import 'package:sweatbox2dot0/Widget/StatusWidget/Diary.dart';
import 'package:sweatbox2dot0/Widget/StatusWidget/PersonalRecord.dart';

class StatausPage extends StatelessWidget {
  var userData = Get.put(UserController());

  var statusStateController = Get.put(StatusStateController());

  changeCurrentPage(index) {
    statusStateController.pageIndex.value = index;
  }

  onStretch() {
    print("object");
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: DefaultTabController(
            initialIndex: statusStateController.pageIndex.value,
            length: 4,
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(sx(25)),
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: sx(130),
                          height: sx(130),
                          child: Stack(
                            children: [
                              Container(
                                width: sx(130),
                                height: sx(130),
                                decoration: BoxDecoration(
                                    color: userData.user.value.profileImage == "" ? Colors.blue : Colors.black,
                                    // image:DecorationImage(image: ),
                                    image: userData.user.value.profileImage == ""
                                        ? null
                                        : userData.user.value.profileImage!.contains("/data/user")
                                            ? DecorationImage(image: FileImage(File(userData.user.value.profileImage!)))
                                            : DecorationImage(image: FirebaseImage(userData.user.value.profileImage!)),
                                    borderRadius: BorderRadius.all(Radius.circular(900))),
                              ),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(PhysicalData());
                                    },
                                    child: CircleAvatar(
                                      radius: sx(20),
                                      backgroundColor: Color(0xffd6e4ff),
                                      child: SvgPicture.asset(
                                        "assets/StatusIcon/profile.svg",
                                        color: Color(0xff707070),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          width: sx(20),
                        ),
                        Container(
                          height: sx(110),
                          color: Colors.white,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  userData.user.value.nickName!,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: sx(30)),
                                ),
                                Text(
                                  "${DateTime.now().year - userData.user.value.birth!.year + 1}세   ${userData.user.value.tall}cm   ${userData.user.value.weight}lb",
                                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: sx(20)),
                                ),
                                Text(
                                  "${userData.user.value.box}",
                                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: sx(20), color: Colors.blue),
                                ),
                              ]),
                        )
                      ],
                    )),
                TabBar(
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.black.withOpacity(0.2),
                  isScrollable: true,
                  labelPadding: EdgeInsets.symmetric(
                    horizontal: sx(30),
                  ),
                  indicatorColor: Colors.blue,
                  indicatorWeight: 4,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelStyle: TextStyle(fontSize: sx(20), fontWeight: FontWeight.bold),
                  unselectedLabelStyle: TextStyle(fontSize: sx(20), fontWeight: FontWeight.bold),
                  onTap: (index) {
                    changeCurrentPage(index);
                  },
                  tabs: [
                    Tab(text: "스웨트빌리티"),
                    Tab(text: "다이어리"),
                    Tab(text: "퍼스널레코드"),
                    Tab(text: "뱃지"),
                  ],
                ),
                Expanded(child: Obx(() => bodyView(statusStateController.pageIndex.value)))
              ],
            )

            // NestedScrollView(
            //     controller: statusStateController.statusScrollController,
            //     physics: NeverScrollableScrollPhysics(),
            //     headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            //       return <Widget>[
            //         SliverAppBar(
            //           onStretchTrigger: () {
            //             return onStretch();
            //           },
            //           elevation: 0,
            //           pinned: true,
            //           automaticallyImplyLeading: false,
            //           expandedHeight: sx(300),
            //           backgroundColor: Colors.white,
            //           bottom: TabBar(
            //             labelColor: Colors.blue,
            //             unselectedLabelColor: Colors.black.withOpacity(0.2),
            //             isScrollable: true,
            //             labelPadding: EdgeInsets.symmetric(
            //               horizontal: sx(30),
            //             ),
            //             indicatorColor: Colors.blue,
            //             indicatorWeight: 4,
            //             indicatorSize: TabBarIndicatorSize.label,
            //             labelStyle: TextStyle(fontSize: sx(20), fontWeight: FontWeight.bold),
            //             unselectedLabelStyle: TextStyle(fontSize: sx(20), fontWeight: FontWeight.bold),
            //             onTap: (index) {
            //               changeCurrentPage(index);
            //             },
            //             tabs: [
            //               Tab(text: "스웨트빌리티"),
            //               Tab(text: "다이어리"),
            //               Tab(text: "퍼스널레코드"),
            //               Tab(text: "뱃지"),
            //             ],
            //           ),
            //           title: Obx(() => AnimatedOpacity(
            //                 opacity: statusStateController.shortInfoOn.value ? 1 : 0,
            //                 duration: Duration(milliseconds: 200),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     Container(
            //                       width: sx(30),
            //                       height: sx(30),
            //                       decoration: BoxDecoration(
            //                           color: userData.user.value.profileImage == "" ? Colors.blue : Colors.black,
            //                           // image:DecorationImage(image: ),
            //                           image: userData.user.value.profileImage == ""
            //                               ? null
            //                               : userData.user.value.profileImage!.contains("/data/user")
            //                                   ? DecorationImage(image: FileImage(File(userData.user.value.profileImage!)))
            //                                   : DecorationImage(image: FirebaseImage(userData.user.value.profileImage!)),
            //                           borderRadius: BorderRadius.all(Radius.circular(900))),
            //                     ),
            //                     SizedBox(
            //                       width: sx(10),
            //                     ),
            //                     Text(
            //                       userData.user.value.nickName!,
            //                       style: TextStyle(fontSize: sx(20), fontWeight: FontWeight.w400),
            //                     )
            //                   ],
            //                 ),
            //               )),
            //           flexibleSpace: FlexibleSpaceBar(
            //             background: Container(
            //                 padding: EdgeInsets.all(sx(25)),
            //                 alignment: Alignment.center,
            //                 child: Row(
            //                   crossAxisAlignment: CrossAxisAlignment.center,
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   children: [
            //                     Container(
            //                       width: sx(130),
            //                       height: sx(130),
            //                       child: Stack(
            //                         children: [
            //                           Container(
            //                             width: sx(130),
            //                             height: sx(130),
            //                             decoration: BoxDecoration(
            //                                 color: userData.user.value.profileImage == "" ? Colors.blue : Colors.black,
            //                                 // image:DecorationImage(image: ),
            //                                 image: userData.user.value.profileImage == ""
            //                                     ? null
            //                                     : userData.user.value.profileImage!.contains("/data/user")
            //                                         ? DecorationImage(image: FileImage(File(userData.user.value.profileImage!)))
            //                                         : DecorationImage(image: FirebaseImage(userData.user.value.profileImage!)),
            //                                 borderRadius: BorderRadius.all(Radius.circular(900))),
            //                           ),
            //                           Positioned(
            //                               bottom: 0,
            //                               right: 0,
            //                               child: InkWell(
            //                                 onTap: () {
            //                                   Get.to(PhysicalData());
            //                                 },
            //                                 child: CircleAvatar(
            //                                   radius: sx(20),
            //                                   backgroundColor: Color(0xffd6e4ff),
            //                                   child: SvgPicture.asset(
            //                                     "assets/StatusIcon/profile.svg",
            //                                     color: Color(0xff707070),
            //                                   ),
            //                                 ),
            //                               ))
            //                         ],
            //                       ),
            //                     ),
            //                     SizedBox(
            //                       width: sx(20),
            //                     ),
            //                     Container(
            //                       height: sx(110),
            //                       color: Colors.white,
            //                       child: Column(
            //                           crossAxisAlignment: CrossAxisAlignment.start,
            //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                           children: [
            //                             Text(
            //                               userData.user.value.nickName!,
            //                               style: TextStyle(fontWeight: FontWeight.bold, fontSize: sx(30)),
            //                             ),
            //                             Text(
            //                               "${DateTime.now().year - userData.user.value.birth!.year + 1}세   ${userData.user.value.tall}cm   ${userData.user.value.weight}lb",
            //                               style: TextStyle(fontWeight: FontWeight.normal, fontSize: sx(20)),
            //                             ),
            //                             Text(
            //                               "${userData.user.value.box}",
            //                               style: TextStyle(fontWeight: FontWeight.normal, fontSize: sx(20), color: Colors.blue),
            //                             ),
            //                           ]),
            //                     )
            //                   ],
            //                 )),
            //           ),
            //         ),
            //       ];
            //     },
            //     body: Obx(
            //       () => Container(width: width, child: bodyView(statusStateController.pageIndex.value)),
            //     )),
            ),
      );
      // return Scaffold(
      //     body: DefaultTabController(
      //       length: ,
      //       child: Container(
      //         padding: EdgeInsets.only(
      //           top: sx(70),
      //         ),
      //         child: CustomScrollView(
      //           controller: statusScrollController,
      //           slivers: [
      //             SliverAppBar(
      //               elevation: 0,
      //               pinned: true,
      //               automaticallyImplyLeading: false,
      //               expandedHeight: sx(200),
      //               backgroundColor: Colors.white,
      //               flexibleSpace: FlexibleSpaceBar(
      //                 titlePadding: EdgeInsets.all(0),
      //                 centerTitle: true,
      //                 title: Obx(() => AnimatedOpacity(
      //                       opacity: shortInfoOn.value ? 1 : 0,
      //                       duration: Duration(milliseconds: 200),
      //                       child: Row(
      //                         mainAxisAlignment: MainAxisAlignment.center,
      //                         children: [
      //                           Container(
      //                             margin: EdgeInsets.all(10),
      //                             width: 30,
      //                             height: 30,
      //                             decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(300))),
      //                           ),
      //                           Text("asdlfjlka")
      //                         ],
      //                       ),
      //                     )),
      //                 background: Container(
      //                     padding: EdgeInsets.all(sx(25)),
      //                     alignment: Alignment.center,
      //                     child: Row(
      //                       crossAxisAlignment: CrossAxisAlignment.center,
      //                       mainAxisAlignment: MainAxisAlignment.start,
      //                       children: [
      //                         CircleAvatar(
      //                           radius: 50,
      //                           backgroundColor: Colors.red,
      //                         ),
      //                         SizedBox(
      //                           width: sx(20),
      //                         ),
      //                         Container(
      //                           height: 100,
      //                           color: Colors.black,
      //                           child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("현정환 Nick max 8words"), Text("현정환 Nick max 8words"), Text("현정환 Nick max 8words")]),
      //                         )
      //                       ],
      //                     )),
      //               ),
      //             ),
      //             SliverList(
      //               delegate: SliverChildBuilderDelegate(
      //                 (BuildContext context, int index) {
      //                   return Container(
      //                     color: index.isOdd ? Colors.white : Colors.black12,
      //                     height: 100.0,
      //                     child: Center(
      //                       child: Text('$index', textScaleFactor: 5),
      //                     ),
      //                   );
      //                 },
      //                 childCount: 20,
      //               ),
      //             ),
      //           ],
      //         )),));
    });
  }

  bodyView(currentTab) {
    List<Widget> tabView = [];
    //Current Tabs in Home Screen...
    switch (currentTab) {
      case 0:
        //Dashboard Page
        tabView = [AblityWidget()];
        break;
      case 1:
        //Search Page
        tabView = [DiaryWidget()];
        break;
      case 2:
        //Profile Page
        tabView = [PRWidget()];
        break;
      case 3:
        //Setting Page
        tabView = [BadgeWidget()];
        break;
    }
    return PageView(controller: statusStateController.pageController, children: tabView);
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
