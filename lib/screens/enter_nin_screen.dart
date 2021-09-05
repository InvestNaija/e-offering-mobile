import 'package:flutter/material.dart';
import 'package:invest_naija/business_logic/data/response/nin_response_model.dart';
import 'package:invest_naija/business_logic/providers/register_provider.dart';
import 'package:invest_naija/components/custom_button.dart';
import 'package:invest_naija/components/custom_lead_icon.dart';
import 'package:invest_naija/components/custom_textfield.dart';
import 'package:invest_naija/mixins/dialog_mixin.dart';
import 'package:invest_naija/screens/set_password_screen.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'forgot_password_screen.dart';

class EnterNinScreen extends StatefulWidget {
  @override
  _EnterNinScreenState createState() => _EnterNinScreenState();
}

class _EnterNinScreenState extends State<EnterNinScreen> with DialogMixins{

  TextEditingController ninTextEditingController = TextEditingController();
  TextEditingController firstNameTextEditingController = TextEditingController();
  TextEditingController lastNameTextEditingController = TextEditingController();

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
                child: const Text("Create Account",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Constants.blackColor)),
              ),
              const SizedBox(height: 13,),
              Align(
                alignment: Alignment.centerLeft,
                child: const Text("To create an account, please enter your National Identity Number.",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Constants.fontColor2)),
              ),
              const SizedBox(height: 42,),
              CustomTextField(
                label: "National Identity Number",
                controller: ninTextEditingController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 25,),
              CustomTextField(
                label: "First Name",
                controller: firstNameTextEditingController,
              ),
              const SizedBox(height: 25,),
              CustomTextField(
                label: "Last Name",
                controller: lastNameTextEditingController,
              ),
              const SizedBox(height: 25,),
              Consumer<RegisterProvider>(
                builder: (context, registerProvider, child) {
                  return  CustomButton(
                    data: "Proceed",
                    isLoading: registerProvider.isLoading,
                    textColor: Constants.whiteColor,
                    color: Constants.primaryColor,
                    onPressed: () async{

                      NinResponseModel ninResponseModel =  await Provider.of<RegisterProvider>(context, listen: false).checkNin(
                        firstName: firstNameTextEditingController.text,
                        lastName: lastNameTextEditingController.text,
                        nin: ninTextEditingController.text,
                      );

                      if(ninResponseModel.error == null){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SetPasswordScreen(
                            firstName: ninResponseModel.data.firstname,
                            lastName: ninResponseModel.data.lastname,
                            dob: ninResponseModel.data.birthdate,
                            email: ninResponseModel.data.email,
                            address: '',
                            phone: ninResponseModel.data.phone,
                            middleName: ninResponseModel.data.middlename,
                            nin: ninResponseModel.data.nin,
                            gender: ninResponseModel.data.gender,
                            bvn: ''
                        )));
                      }else{
                        showSimpleModalDialog(context: context, title: 'NIN check Error', message: ninResponseModel.error.message);
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 27,),
              GestureDetector(
                onTap: () {
                  showWhyWeNeedYourNinModalDialog(context: context);
                },
                child: const Text(
                  "Why we need your NIN?",
                  style: const TextStyle(
                      color: Constants.blackColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
