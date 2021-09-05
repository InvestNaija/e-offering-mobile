import 'package:flutter/material.dart';

import '../constants.dart';

class CustomTextField extends StatelessWidget {

  final String label;
  final TextEditingController controller;
  final Key key;
  final String counterText;
  final Function onTap;
  final bool readOnly;
  final suffixIcon;
  final regexPattern;
  final regexHint;
  final TextInputType keyboardType;
  final Function(String value) onChange;
  final VoidCallback onEditingComplete;
  final FocusNode focusNode;

  CustomTextField({
    this.label = "",
    this.controller,
    this.key,
    this.onTap,
    this.readOnly = false,
    this.suffixIcon,
    this.regexPattern,
    this.regexHint,
    this.keyboardType = TextInputType.name,
    this.onChange,
    this.counterText = '',
    this.onEditingComplete,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        keyboardType: this.keyboardType,
        focusNode: focusNode,
        readOnly: this.readOnly,
        onTap: () => this.onTap == null ? null : this.onTap(),
        style: TextStyle(color: Constants.leadColor),
        onEditingComplete: (){
           onEditingComplete();
        },
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
        onChanged: (value){
          if(this.onChange != null){
             this.onChange(value);
          }
        },
        obscureText: this.label != null && this.label.toLowerCase().contains("password") ? true : false,
        controller: this.controller,
        cursorColor: Constants.primaryColor,
        decoration: new InputDecoration(
          labelText: label,
          counterText: counterText,
          labelStyle: TextStyle(fontSize: 14, color: Constants.neutralColor, fontWeight: FontWeight.w600),
          suffixIcon: suffixIcon != null? Padding(
            padding: const EdgeInsets.only(right:8.0),
            child: Image.asset(suffixIcon, width: 20, height: 20, ),
          ) : label.toLowerCase() == "password" ? GestureDetector(
            onTap: () {},
            child: Transform.translate(offset: Offset(-10.0, 0.0),
            child: Icon(Icons.visibility_off_outlined)),
          ) : null,
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