import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:slide_to_act/slide_to_act.dart';

class TapTimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
          body: Center(
        child: SlideAction(
          outerColor: Color(0xff707070),
          innerColor: Colors.blue,
          submittedIcon: Icon(
            Icons.check,
            color: Colors.white,
          ),
          onSubmit: () {
            Get.back();
          },
          alignment: Alignment.center,
          child: Text(
            '밀어서 타이머 종료',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          sliderButtonIcon: Icon(
            Icons.arrow_forward_rounded,
            color: Colors.white,
          ),
        ),
      ));
    });
  }
}
