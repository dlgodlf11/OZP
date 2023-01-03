import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

class BadgeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
        body: Center(
          child: Text("뱃지"),
        ),
      );
    });
  }
}
