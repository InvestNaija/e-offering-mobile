import 'package:flutter/material.dart';
import 'package:invest_naija/business_logic/data/response/response_model.dart';
import 'package:invest_naija/business_logic/providers/customer_provider.dart';
import 'package:invest_naija/components/custom_button.dart';
import 'package:invest_naija/components/custom_lead_icon.dart';
import 'package:invest_naija/components/custom_password_field.dart';
import 'package:invest_naija/mixins/dialog_mixin.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> with DialogMixins{
  TextEditingController oldPasswordTextEditController = TextEditingController(text: "");
  TextEditingController newPasswordTextEditController = TextEditingController(text: "");
  TextEditingController confirmPasswordTextEditController = TextEditingController(text: "");
  CustomerProvider customerProvider;
  FocusNode oldPasswordFocusNode;
  FocusNode newPasswordFocusNode;
  FocusNode confirmPasswordFocusNode;

  @override
  void initState() {
    super.initState();
    oldPasswordFocusNode = FocusNode();
    newPasswordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
    customerProvider = Provider.of<CustomerProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 31, vertical: 32),
          child: Column(
            children: [
              const SizedBox(height: 15,),
              CustomLeadIcon(),
              const SizedBox(height: 32,),
              Align(
                alignment: Alignment.centerLeft,
                child: const Text("Change Password",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Constants.blackColor)),
              ),
              const SizedBox(height: 13,),
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                    "Please complete the form below to update your password.",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Constants.neutralColor)),
              ),
              const SizedBox(height: 30,),
              CustomPasswordField(
                label: "Old Password",
                controller: oldPasswordTextEditController,
                focusNode: oldPasswordFocusNode,
                onEditingComplete: (){},
              ),
              const SizedBox(height: 25,),
              CustomPasswordField(
                label: "New Password",
                focusNode: newPasswordFocusNode,
                controller: newPasswordTextEditController,
                onEditingComplete: (){},
              ),
              const SizedBox(height: 25,),
              CustomPasswordField(
                label: "Confirm Password",
                focusNode: confirmPasswordFocusNode,
                controller: confirmPasswordTextEditController,
                onEditingComplete: (){},
              ),
              const SizedBox(height: 32,),
              Consumer<CustomerProvider>(
                builder: (context, customerProvider, child) {
                  return  CustomButton(
                    data: "Update Password",
                    isLoading: customerProvider.isChangingPassword,
                    textColor: Constants.whiteColor,
                    color: Constants.primaryColor,
                    onPressed: () async {
                     if(newPasswordTextEditController.text != confirmPasswordTextEditController.text){
                       showSimpleModalDialog(
                           context: context,
                           title: "Password mismatch",
                           message: "Confirmation password does not match new password"
                       );
                       return;
                     }

                     ResponseModel responseModel =  await customerProvider.changePassword(
                          oldPassword: oldPasswordTextEditController.text,
                          newPassword: newPasswordTextEditController.text,
                          confirmNewPassword: confirmPasswordTextEditController.text
                      );
                     if(responseModel.error == null) {
                       showSimpleModalDialog(context: context, title: "Success", message: responseModel.message);
                     }else{
                       showSimpleModalDialog(context: context, title: "Update password error", message: responseModel.error.message);
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
    );
  }
}
