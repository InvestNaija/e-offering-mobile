import 'package:flutter/material.dart';

import '../constants.dart';

class OtpInputField extends StatelessWidget {
  final TextEditingController textEditingController;
  final FocusNode focusNode;

  const OtpInputField({Key key, this.textEditingController, this.focusNode}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Constants.bleachSilkColor,
          borderRadius: BorderRadius.circular(8)
      ),
      height: 54,
      width: 46,
      child: TextField(
          focusNode: focusNode,
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          controller: textEditingController,
          maxLength: 1,
          cursorColor: Constants.primaryColor,
          decoration: InputDecoration(
              counterText: "",
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)
          )
      ),
    );
  }
}
