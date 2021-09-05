import 'package:flutter/material.dart';
import 'package:invest_naija/business_logic/data/response/nin_response_model.dart';
import 'package:invest_naija/business_logic/data/response/response_model.dart';
import 'package:invest_naija/business_logic/providers/assets_provider.dart';
import 'package:invest_naija/business_logic/providers/customer_provider.dart';
import 'package:invest_naija/business_logic/providers/register_provider.dart';
import 'package:invest_naija/components/custom_button.dart';
import 'package:invest_naija/components/custom_dropdown_textfield.dart';
import 'package:invest_naija/components/custom_lead_icon.dart';
import 'package:invest_naija/components/custom_textfield.dart';
import 'package:invest_naija/mixins/dialog_mixin.dart';
import 'package:invest_naija/screens/successful_screen.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class CreateCscsAccountScreen extends StatefulWidget {
  final User user;
  const CreateCscsAccountScreen({Key key, this.user}) : super(key: key);
  @override
  _CreateCscsAccountScreenState createState() => _CreateCscsAccountScreenState();
}

class _CreateCscsAccountScreenState extends State<CreateCscsAccountScreen> with DialogMixins{

  TextEditingController fullNameTextEditController = TextEditingController(text: "");
  TextEditingController maidenNameTextEditController = TextEditingController(text: "");
  TextEditingController countryTextEditController = TextEditingController(text: "Nigeria");
  TextEditingController cityTextEditController = TextEditingController(text: "");
  TextEditingController postalCodeTextEditController = TextEditingController(text: "");
  TextEditingController nationalityTextEditController = TextEditingController(text: "Nigerian");
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 31, vertical: 32),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 15,),
                CustomLeadIcon(),
                const SizedBox(height: 32,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Create CSCS Account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Constants.blackColor)),
                ),
                const SizedBox(height: 13,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Please complete the form below to create an account",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Constants.neutralColor)),
                ),
                const SizedBox(height: 30,),
                Consumer<CustomerProvider>(
                  builder: (BuildContext context, customerProvider, Widget child) {
                    return CustomTextField(
                      label: "Your Full name",
                      readOnly: true,
                      controller: fullNameTextEditController..text = '${customerProvider.user.lastName} ${customerProvider.user.firstName} ${customerProvider.user.middleName}',
                    );
                  },
                ),
                const SizedBox(height: 25,),
                Consumer<CustomerProvider>(
                  builder: (BuildContext context, customerProvider, Widget child) {
                    return CustomTextField(
                      label: "Maiden Name",
                      readOnly: true,
                      controller: maidenNameTextEditController..text = customerProvider.user.mothersMaidenName,
                    );
                  },
                ),
                const SizedBox(height: 25,),
                CustomTextField(
                  label: "City",
                  controller: cityTextEditController,
                ),
                const SizedBox(height: 25,),
                CustomDropdownTextField(
                  label: "Country",
                  items: ["Nigeria"],
                  value: "Nigeria",
                  onChanged: (value){
                    countryTextEditController..text = value;
                  },
                  controller: postalCodeTextEditController,
                ),
                const SizedBox(height: 25,),
                CustomDropdownTextField(
                  label: "Nationality",
                  items: ["Nigerian"],
                  value: "Nigerian",
                  onChanged: (value){
                    nationalityTextEditController..text = value;
                  },
                ),
                const SizedBox(height: 25,),
                CustomTextField(
                  label: "Postal Code",
                  controller: postalCodeTextEditController,
                ),
                const SizedBox(height: 32,),
                Consumer<AssetsProvider>(
                  builder: (context, assetProvider, child) {
                    return  CustomButton(
                      data: "Create Cscs account",
                      isLoading: assetProvider.isCreatingCscs,
                      textColor: Constants.whiteColor,
                      color: Constants.primaryColor,
                      onPressed: assetProvider.isCreatingCscs? null : () async {
                        if(!formKey.currentState.validate()) return;

                        bool hasNuban = await Provider.of<CustomerProvider>(context, listen: false).hasNuban();
                        if(!hasNuban){
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Update Bank Details'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: const <Widget>[
                                      Text('Your bank information is needed to proceed'),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Update Bank Detail', style: TextStyle(color: Constants.blackColor),),
                                    onPressed: () {
                                      Navigator.popAndPushNamed(context, '/enter-bank-detail', arguments: true);
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Cancel', style: TextStyle(color: Constants.blackColor)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                          return;
                        }

                        ResponseModel responseModel = await Provider.of<AssetsProvider>(context, listen: false).createCscsAccount(
                            citizen: nationalityTextEditController.text,
                            city : cityTextEditController.text,
                            country: countryTextEditController.text,
                            maidenName: maidenNameTextEditController.text,
                        );
                        if(responseModel.error == null ){
                          Provider.of<CustomerProvider>(context, listen: false).getCustomerDetailsSilently();
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SuccessfulScreen(
                              header : 'Congratulations',
                              body : responseModel.message,
                              buttonText : 'Go back',
                              onButtonClicked : (){
                                Navigator.of(context).pop();
                              }
                          )));
                        }else{
                          showSimpleModalDialog(context: context, title: 'Registration error', message: responseModel.error.message);
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
