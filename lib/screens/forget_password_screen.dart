import 'package:flutter/material.dart';
import 'package:invest_naija/business_logic/data/response/login_response_model.dart';
import 'package:invest_naija/business_logic/providers/login_provider.dart';
import 'package:invest_naija/components/custom_button.dart';
import 'package:invest_naija/components/custom_lead_icon.dart';
import 'package:invest_naija/components/custom_textfield.dart';
import 'package:invest_naija/mixins/dialog_mixin.dart';
import 'package:invest_naija/screens/dashboard_screen.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'enter_nin_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> with DialogMixins {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 31, vertical: 32),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 15,),
                CustomLeadIcon(),
                const SizedBox(height: 32,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Forgotten your password?",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Constants.fontColor2)),
                ),
                const SizedBox(height: 3,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Enter your email to recover your password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Constants.blackColor)),
                ),
                const SizedBox(height: 44,),
                CustomTextField(
                  label: "Email",
                  controller: emailController,
                  regexPattern: r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$",
                  regexHint: 'Enter a valid email address',
                ),
                const SizedBox(height: 32,),
                Consumer<LoginProvider>(
                  builder: (context, loginProvider, child) {
                    return  CustomButton(
                      data: "Recover",
                      isLoading: loginProvider.isLoading,
                      textColor: Constants.whiteColor,
                      color: Constants.primaryColor,
                      onPressed: () async{
                        if(!_formKey.currentState.validate()) return;
                        LoginResponseModel loginResponse = await Provider.of<LoginProvider>(context, listen: false).login(
                            email : emailController.text,
                            password: passwordController.text
                        );
                        if(loginResponse.error == null){
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => DashboardScreen()));
                        }else{
                          showSimpleModalDialog(context: context, title: 'Login Error', message: loginResponse.error.message);
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 27,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
