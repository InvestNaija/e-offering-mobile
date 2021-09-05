import 'package:flutter/material.dart';
import 'package:invest_naija/business_logic/data/response/response_model.dart';
import 'package:invest_naija/business_logic/providers/assets_provider.dart';
import 'package:invest_naija/components/custom_button.dart';
import 'package:invest_naija/components/custom_lead_icon.dart';
import 'package:invest_naija/components/custom_textfield.dart';
import 'package:invest_naija/mixins/dialog_mixin.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class EnterCscsNumber extends StatefulWidget {
  final bool navigateBack;
  const EnterCscsNumber({Key key, this.navigateBack = false}) : super(key: key);
  @override
  _EnterCscsNumberState createState() => _EnterCscsNumberState();
}

class _EnterCscsNumberState extends State<EnterCscsNumber> with DialogMixins {

  TextEditingController _cscsNumberTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.dashboardBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: Transform.translate(
          offset: Offset(0, 20),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            leading: Transform.translate(offset: Offset(22,0), child: CustomLeadIcon(),),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          children: [
            const SizedBox(height: 50,),
            Align(
              alignment: Alignment.centerLeft,
              child: const Text("Enter CSCS Number",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Constants.blackColor)),
            ),
            const SizedBox(height: 9,),
            Align(
              alignment: Alignment.centerLeft,
              child: const Text("Please enter your CSCS Number to continue",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Constants.neutralColor)),
            ),
            const SizedBox(height: 35,),
            Consumer<AssetsProvider>(
              builder: (BuildContext context, assetProvider, Widget child) {
                return CustomTextField(
                  label: "CSCS Number",
                  controller: _cscsNumberTextEditingController,
                  counterText: assetProvider.verifiedName,
                  onChange: (value) async{
                    await assetProvider.verifyCscs(cscsNo: _cscsNumberTextEditingController.text);
                  },
                );
              },
            ),
            const SizedBox(height: 40,),
            Consumer<AssetsProvider>(builder: (context, assetProvider, widget) {
             return  CustomButton(
               data: "Update Cscs",
               isLoading: assetProvider.isLoading,
               textColor: Constants.whiteColor,
               color: Constants.primaryColor,
               onPressed: () async{
                 if(!assetProvider.cscsVerified){
                   final snackBar = SnackBar(content: Text('Please enter a valid cscs number'));
                   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                   return;
                 }
                 ResponseModel responseModel = await assetProvider.uploadCscs(cscsNo: _cscsNumberTextEditingController.text);
                 if(responseModel.error != null){
                   showSimpleModalDialog(context: context, title: 'Update Cscs error', message: responseModel.error.message);
                 }else{
                   _cscsNumberTextEditingController.clear();
                   showSimpleModalDialog(
                       context: context,
                       title: 'Update Cscs info',
                       message: responseModel.message,
                       onClose: (){
                         Navigator.pop(context);
                       }
                   );
                 }
               },
             );
           })
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _cscsNumberTextEditingController.dispose();
    Provider.of<AssetsProvider>(context).verifiedName = '';
    Provider.of<AssetsProvider>(context).cscsVerified = false;
  }
}
