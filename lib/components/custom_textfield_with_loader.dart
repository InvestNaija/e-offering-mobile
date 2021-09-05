import 'package:flutter/material.dart';

import '../constants.dart';
import 'dual_ring_spinner.dart';

class CustomTextFieldWithLoader extends StatelessWidget {

  final String label;
  final bool shouldLoad;
  final TextEditingController controller;
  final Key key;
  final Function onTap;
  final bool readOnly;
  final regexPattern;
  final regexHint;

  CustomTextFieldWithLoader({this.label = "", this.controller, this.key, this.onTap, this.readOnly = false, this.regexPattern, this.regexHint, this.shouldLoad = false});

  @override
  Widget build(BuildContext context) {
    FocusNode myFocusNode = new FocusNode();
    return Container(
      child: TextFormField(
        focusNode: myFocusNode,
        readOnly: this.readOnly,
        onTap: () => this.onTap == null ? null : this.onTap(),
        style: TextStyle(color: Constants.leadColor),
        validator: (value){
          if (value.isEmpty) {
            return '$label cannot be empty';
          }
          if(regexPattern != null){
            RegExp regExp = new RegExp(regexPattern);
            if (!regExp.hasMatch(value.trim()) ) {
              return regexHint;
            }
          }
          return null;
        },
        obscureText: this.label != null && this.label.toLowerCase().contains("password") ? true : false,
        controller: this.controller,
        cursorColor: Constants.secondaryColor,
        decoration: new InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 14, color: myFocusNode.hasFocus? Constants.neutralColor : Constants.neutralColor, fontWeight: FontWeight.w600),
          suffixIcon: shouldLoad ? Transform.translate(offset: Offset(-10, 0), child: DualRingSpinner(color: Constants.primaryColor, size: 15, lineWidth: 3,)) : null,
          suffixIconConstraints: BoxConstraints(maxWidth: 20, minWidth: 20, maxHeight: 16, minHeight: 16),
          fillColor: Constants.textFieldFillColor,
          filled: true,
          contentPadding: EdgeInsets.only(left: 22),
          border: new OutlineInputBorder(
            borderSide: const BorderSide(color: Constants.textFieldBorderColor, width: 1.5),
            borderRadius: BorderRadius.circular(4.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Constants.errorAlertColor, width: 1.0),
            borderRadius: BorderRadius.circular(4.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Constants.textFieldBorderColor, width: 1.5),
            borderRadius: BorderRadius.circular(4.0),
          ),
          errorStyle: TextStyle(color: Constants.errorAlertColor),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Constants.textFieldBorderColor, width: 1.5),
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    );
  }
}