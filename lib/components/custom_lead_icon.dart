import 'package:flutter/material.dart';

import '../constants.dart';

class CustomLeadIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Ink(
        decoration: ShapeDecoration(
          color: Colors.transparent,
          shape:
              CircleBorder(side: BorderSide(color: Constants.leadBorderColor, width: 2)),
        ),
        child: IconButton(
          color: Colors.white,
          disabledColor: Colors.white,
          iconSize: 25,
          icon: Icon(
            Icons.navigate_before_rounded,
            color: Constants.iconsColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
