import 'package:flutter/material.dart';
import 'package:invest_naija/business_logic/data/response/nin_response_model.dart';
import 'package:invest_naija/business_logic/data/response/response_model.dart';
import 'package:invest_naija/business_logic/providers/bank_provider.dart';
import 'package:invest_naija/components/custom_button.dart';
import 'package:invest_naija/components/custom_dropdown_textfield.dart';
import 'package:invest_naija/components/custom_lead_icon.dart';
import 'package:invest_naija/components/custom_textfield.dart';
import 'package:invest_naija/components/custom_textfield_with_loader.dart';
import 'package:invest_naija/mixins/dialog_mixin.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class EnterBankInformationScreen extends StatefulWidget {
  final User user;
  const EnterBankInformationScreen({Key key, this.user}) : super(key: key);
  @override
  _EnterBankInformationScreenState createState() => _EnterBankInformationScreenState();
}

class _EnterBankInformationScreenState extends State<EnterBankInformationScreen> with DialogMixins{

  TextEditingController accountNameTextEditController = TextEditingController(text: "");
  TextEditingController accountNumberTextEditController = TextEditingController(text: "");
  TextEditingController passwordTextEditController = TextEditingController(text: "");
  BankProvider bankProvider;

  @override
  void initState() {
    super.initState();
    bankProvider = Provider.of<BankProvider>(context, listen: false);
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
                child: const Text("Enter Bank Information",
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
                    "Please complete the form below to create an account",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Constants.neutralColor)),
              ),
              const SizedBox(height: 30,),
              Consumer<BankProvider>(builder: (context, bankProvider, widget){
                List<String> banks = bankProvider.banks.map((bank) => bank.name).toList();
                return Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: CustomDropdownTextField(
                      label: "Bank Name",
                      items: banks,
                      value: bankProvider.bankName.isEmpty ?  banks[0] : bankProvider.bankName,
                      onChanged: (newValue)=>bankProvider.getSelectedBank(bankName: newValue),
                  ),
                );
              }),
              const SizedBox(height: 25,),
              CustomTextField(
                label: "Account Number",
                controller: accountNumberTextEditController..text = bankProvider.nuban,
                keyboardType: TextInputType.number,
                onChange: (value){
                  if(value.length == 10 &&
                      bankProvider.selectedBank != null &&
                      bankProvider.selectedBank.code != null){
                      bankProvider.verifyBankAccount(
                        bankCode: bankProvider.selectedBank.code,
                        nuban: value
                      );
                  }
                },
              ),
              const SizedBox(height: 25,),
              Consumer<BankProvider>(builder: (context, bankProvider, widget){
                return CustomTextFieldWithLoader(
                  label: "Account Name",
                  controller: accountNameTextEditController..text = bankProvider.verifiedAccountName,
                  shouldLoad: bankProvider.verifyingBankAccount,
                );
              }),
              const SizedBox(height: 25,),
              CustomTextField(
                label: "Password",
                controller: passwordTextEditController,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 32,),
              Consumer<BankProvider>(
                builder: (context, bankProvider, child) {
                  return  CustomButton(
                    data: "Update Account",
                    isLoading: bankProvider.isUpdatingBankDetail,
                    textColor: Constants.whiteColor,
                    color: Constants.primaryColor,
                    onPressed: () async {
                      ResponseModel responseModel = await bankProvider.updateBankDetail(
                        bankAccountName: accountNameTextEditController.text,
                        bankCode: bankProvider.selectedBank.code,
                        bankName: bankProvider.selectedBank.name,
                        password: passwordTextEditController.text,
                        nuban: accountNumberTextEditController.text
                      );

                      if(responseModel.error == null){
                        showSimpleModalDialog(
                            context: context,
                            title: "Success",
                            message: responseModel.message,
                            onClose: (){
                              Navigator.pop(context);
                            }
                        );
                      }else{
                        showSimpleModalDialog(
                            context: context,
                            title: "Error",
                            message: responseModel.error.message);
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
