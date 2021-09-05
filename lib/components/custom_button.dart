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

  CustomButton(
      {this.data,
      this.color,
      this.textColor,
      this.onPressed,
      this.icon,
      this.isLoading = false,
      this.disabledColor});

  @override
  Widget build(BuildContext context) {
    return TextButton(
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
                ? DualRingSpinner()
                : Center(
                        child: Text(
                        this.data,
                        style: TextStyle(fontSize: 14, color: this.textColor, fontWeight: FontWeight.bold),
                      ))));
  }
}
