import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:invest_naija/components/custom_button.dart';
import '../components/custom_lead_icon.dart';

import '../constants.dart';

class SuccessfulScreen extends StatefulWidget {

  final String header;
  final String body;
  final String buttonText;
  final Function onButtonClicked;

  const SuccessfulScreen({Key key, this.header, this.body, this.onButtonClicked, this.buttonText}) : super(key: key);

  @override
  _SuccessfulScreenState createState() => _SuccessfulScreenState();
}

class _SuccessfulScreenState extends State<SuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 31, vertical: 32),
        child: Column(
          children: [
            const SizedBox(height: 15,),
            CustomLeadIcon(),
            const SizedBox(height: 32,),
            Image.asset(
              "assets/images/flag.png",
              width: 122,
              height: 159,
            ),
            const SizedBox(height: 32,),
            Text(widget.header,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Constants.blackColor)),
            const SizedBox(height: 13,),
            Text(widget.body,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Constants.neutralColor)),
            const SizedBox(height: 25,),
            CustomButton(
              data: widget.buttonText,
              textColor: Constants.whiteColor,
              color: Constants.primaryColor,
              onPressed: ()=> widget.onButtonClicked()
            ),
            const SizedBox(height: 27,),
          ],
        ),
      ),
    );
  }
}
