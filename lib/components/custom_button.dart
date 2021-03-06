import 'package:flutter/material.dart';

import '../constants.dart';
import 'dual_ring_spinner.dart';

class CustomButton extends StatelessWidget {
  final String data;
  final Color color;
  final Color textColor;
  final Function onPressed;
  final String icon;
  final bool isLoading;
  final Color disabledColor;
  final FocusNode focusNode;

  CustomButton(
      {this.data,
      this.color,
      this.textColor,
      this.onPressed,
      this.icon,
      this.isLoading = false,
      this.disabledColor,
      this.focusNode
      }
  );

  @override
  Widget build(BuildContext context) {
    return TextButton(
      focusNode: this.focusNode ?? FocusNode(),
        style: TextButton.styleFrom(
          backgroundColor: this.color,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0)),
        ),
        onPressed: this.onPressed == null || this.isLoading ? null : () => onPressed(),
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            constraints: BoxConstraints(maxHeight: 45, minHeight: 45),
            width: double.infinity,
            child: this.isLoading
                ? Center(
                  child: SizedBox(
                   height: 25,
                  width: 25,
                  child: CircularProgressIndicator()),
                )
                : Center(
                        child: Text(
                        this.data,
                        style: TextStyle(fontSize: 14, color: this.textColor, fontWeight: FontWeight.bold),
                      ))));
  }
}
