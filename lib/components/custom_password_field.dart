import 'package:flutter/material.dart';

import '../constants.dart';

class CustomPasswordField extends StatefulWidget {

  final String label;
  final TextEditingController controller;
  final Key key;
  final Function onTap;
  final Function(String) onChange;
  final bool readOnly;
  final suffixIcon;
  final regexPattern;
  final regexHint;
  final FocusNode focusNode;
  final String matcher;
  final VoidCallback onEditingComplete;

  CustomPasswordField({
    this.label = "",
    this.controller,
    this.key,
    this.onTap,
    this.readOnly = false,
    this.suffixIcon,
    this.regexPattern,
    this.regexHint,
    this.matcher,
    this.onChange,
    this.focusNode,
    this.onEditingComplete
  });


  @override
  _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        focusNode: widget.focusNode,
        readOnly: widget.readOnly,
        onChanged: (value){
          if(widget.onChange != null) {
            widget.onChange(value);
          }
        },
        onEditingComplete: (){

        },
        onTap: () => widget.onTap == null ? null : widget.onTap(),
        style: TextStyle(color: Constants.leadColor),
        validator:(value){
          if (value.isEmpty) {
            return '${widget.label} cannot be empty';
          }
          if(widget.matcher != null){
            if(value != widget.matcher){
              return 'Password do not match';
            }
          }
          if(widget.regexPattern != null){
            RegExp regExp = new RegExp(widget.regexPattern);
            if (!regExp.hasMatch(value.trim()) ) {
              return widget.regexHint;
            }
          }
          return null;
        },
        obscureText: hidePassword,
        controller: widget.controller,
        cursorColor: Constants.primaryColor,
        decoration: new InputDecoration(
          labelText: widget.label,
         labelStyle: TextStyle(fontSize: 14, color: widget.focusNode.hasFocus? Constants.neutralColor : Constants.neutralColor, fontWeight: FontWeight.w600),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() => hidePassword = !hidePassword);},
            child: Transform.translate(offset: Offset(-10.0, 0.0),
                child: Icon(hidePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Constants.neutralColor,)),
          ),
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

  @override
  void dispose() {
    super.dispose();
    widget.controller.clear();
  }
}