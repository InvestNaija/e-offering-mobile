import 'package:flutter/material.dart';
import 'package:invest_naija/business_logic/data/response/response_model.dart';
import 'package:invest_naija/business_logic/providers/login_provider.dart';
import 'package:invest_naija/components/custom_button.dart';
import 'package:invest_naija/components/custom_lead_icon.dart';
import 'package:invest_naija/components/custom_textfield.dart';
import 'package:invest_naija/mixins/dialog_mixin.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> with DialogMixins{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

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
                const Align(
                  alignment: Alignment.centerLeft,
                  child: const Text("Forget Password",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Constants.blackColor)),
                ),
                const SizedBox(height: 13,),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                      "Please enter your registered email address, to receive a 5- digit code to reset your password ",
                      textAlign: TextAlign.left,
                      style:
                      const TextStyle(fontSize: 12, color: Constants.neutralColor)),
                ),
                const SizedBox(height: 28,),
                CustomTextField(
                  label: "Email",
                  controller: emailController,
                  regexPattern: r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$",
                  regexHint: 'Enter a valid email address',
                ),
                const SizedBox(height: 32,),
                Consumer<LoginProvider>(
                  builder: (context, loginProvider, widget){
                    return CustomButton(
                      data: "Reset Password",
                      isLoading: loginProvider.isResettingPassword,
                      textColor: Constants.whiteColor,
                      color: Constants.primaryColor,
                      onPressed: () async{
                        if(!_formKey.currentState.validate()) return;
                        ResponseModel response = await Provider.of<LoginProvider>(context, listen: false).resetPassword(email: emailController.text);
                        if(response.error == null){
                          showSimpleModalDialog(context: context, title: "Success", message: response.message);
                        }else{
                          showSimpleModalDialog(context: context, title: "Reset password error", message: response.error.message);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
