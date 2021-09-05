import 'package:flutter/material.dart';
import 'package:invest_naija/business_logic/data/response/bvn_response_model.dart';
import 'package:invest_naija/business_logic/data/response/nin_response_model.dart';
import 'package:invest_naija/business_logic/providers/register_provider.dart';
import 'package:invest_naija/components/custom_button.dart';
import 'package:invest_naija/components/custom_lead_icon.dart';
import 'package:invest_naija/components/custom_textfield.dart';
import 'package:invest_naija/mixins/dialog_mixin.dart';
import 'package:invest_naija/screens/set_password_screen.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class EnterBvnScreen extends StatefulWidget {
  @override
  _EnterBvnScreenState createState() => _EnterBvnScreenState();
}

class _EnterBvnScreenState extends State<EnterBvnScreen> with DialogMixins{

  TextEditingController bvnTextEditingController = TextEditingController();
  TextEditingController dobTextEditingController = TextEditingController();

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
                child: const Text("To create an account, please enter your Bank verification number.",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Constants.fontColor2)),
              ),
              const SizedBox(height: 42,),
              CustomTextField(
                label: "Bank Verification Number",
                controller: bvnTextEditingController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 25,),
              CustomTextField(
                label: "Date Of Birth",
                controller: dobTextEditingController,
                readOnly: true,
                onTap: (){
                  selectDate(context: context, onSelected: (DateTime selectedDate){
                     String month = selectedDate.month > 9 ? selectedDate.month.toString() : '0${selectedDate.month}';
                     String day = selectedDate.day > 9 ? selectedDate.day.toString() : '0${selectedDate.day}';
                     dobTextEditingController.text = '$month-$day-${selectedDate.year}';
                   });
                 },
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

                      BvnResponseModel bvnResponseModel =  await Provider.of<RegisterProvider>(context, listen: false).checkBvn(
                        bvn: bvnTextEditingController.text,
                        dob: dobTextEditingController.text,
                      );

                      if(bvnResponseModel.error == null){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SetPasswordScreen(
                            firstName: bvnResponseModel.data.firstname?.trim(),
                            lastName: bvnResponseModel.data.lastname,
                            dob: bvnResponseModel.data.birthdate,
                            email: bvnResponseModel.data.email,
                            address: bvnResponseModel.data.residentialAddress,
                            phone: bvnResponseModel.data.phone,
                            middleName: bvnResponseModel.data.middlename,
                            nin: bvnResponseModel.data.bvn,
                            gender: bvnResponseModel.data.gender,
                            bvn: bvnResponseModel.data.bvn
                        )));
                      }else{
                        showSimpleModalDialog(context: context, title: 'BVN check Error', message: bvnResponseModel.error.message);
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 27,),
              GestureDetector(
                onTap: () {
                  showWhyWeNeedYourBvnModalDialog(context: context);
                },
                child: const Text(
                  "Why we need your BVN?",
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
