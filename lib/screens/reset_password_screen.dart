import 'package:flutter/material.dart';
import 'package:invest_naija/components/custom_button.dart';
import 'package:invest_naija/components/custom_textfield.dart';
import 'package:invest_naija/screens/otp_screen.dart';

import '../constants.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 31),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Reset Password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Constants.blackColor)),
              ),
              SizedBox(
                height: 13,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    "Please setup a new password, we will require you to\nenter a new password and confirm your password",
                    textAlign: TextAlign.left,
                    style:
                    TextStyle(fontSize: 12, color: Constants.neutralColor)),
              ),
              SizedBox(
                height: 28,
              ),
              CustomTextField(
                label: "New password",
              ),
              SizedBox(
                height: 25,
              ),
              CustomTextField(
                label: "Confirm new password",
              ),
              SizedBox(
                height: 32,
              ),
              CustomButton(
                data: "Setup New Password",
                textColor: Constants.whiteColor,
                color: Constants.primaryColor,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => OtpScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
