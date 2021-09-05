import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invest_naija/business_logic/data/response/express_interest_response_model.dart';
import 'package:invest_naija/business_logic/data/response/payment_url_response.dart';
import 'package:invest_naija/business_logic/data/response/shares_response_model.dart';
import 'package:invest_naija/business_logic/providers/assets_provider.dart';
import 'package:invest_naija/business_logic/providers/customer_provider.dart';
import 'package:invest_naija/business_logic/providers/payment_provider.dart';
import 'package:invest_naija/components/custom_button.dart';
import 'package:invest_naija/components/custom_lead_icon.dart';
import 'package:invest_naija/components/custom_textfield.dart';
import 'package:invest_naija/mixins/application_mixin.dart';
import 'package:invest_naija/mixins/dialog_mixin.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'payment_web_screen.dart';

class ExpressionOfInterestScreen extends StatefulWidget {

  final SharesResponseModel asset;

  const ExpressionOfInterestScreen({Key key, this.asset}) : super(key: key);

  @override
  _ExpressionOfInterestScreenState createState() => _ExpressionOfInterestScreenState();
}

class _ExpressionOfInterestScreenState extends State<ExpressionOfInterestScreen> with DialogMixins, ApplicationMixin{
  TextEditingController unitQuantityTextEditingController = TextEditingController();
  TextEditingController estimatedAmountTextEditingController = TextEditingController();

  bool makeSpecifiedUnitReadOnly = false;
  bool makeEstimatedAmountReadOnly = false;
  GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    makeSpecifiedUnitReadOnly = widget.asset.sharePrice == 0;
    makeEstimatedAmountReadOnly = widget.asset.sharePrice != 0;
    unitQuantityTextEditingController.text = '0' ;
    Provider.of<CustomerProvider>(context, listen: false).getCustomerDetailsSilently();
  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 50,),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: const Text("Enter your transaction details",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Constants.blackColor)),
                ),
                const SizedBox(height: 35,),
                CustomTextField(
                  readOnly: true,
                  label: "Offering Type",
                  controller: TextEditingController(text: widget.asset.type == 'ipo' ? 'Public offer' : widget.asset.type),
                ),
                const  SizedBox(height: 25,),
                CustomTextField(
                  readOnly: true,
                  label: "Purchase Price",
                  controller: TextEditingController(text: widget.asset.sharePrice == 0 ? 'Pending price discovery' : widget.asset.sharePrice.toString()),
                ),
                const SizedBox(height: 25,),
                CustomTextField(
                  readOnly: makeSpecifiedUnitReadOnly,
                  label: "Specified Units",
                  controller: unitQuantityTextEditingController,
                  keyboardType : TextInputType.number,
                  onChange: (value){
                      var digit = value.isEmpty ? 0 : int.parse(value);
                      estimatedAmountTextEditingController.text = (digit * widget.asset.sharePrice).toString();
                  },
                ),
                const SizedBox(height: 25,),
                CustomTextField(
                  readOnly: makeEstimatedAmountReadOnly,
                  label: "Estimated Amount",
                  controller: estimatedAmountTextEditingController,
                  keyboardType: TextInputType.number,
                  onChange: (value){
                     if(widget.asset.sharePrice != 0.0){
                       var digit = int.parse(value);
                       var digitTwo = int.parse(unitQuantityTextEditingController.text);
                       unitQuantityTextEditingController.text = (digit * digitTwo).toString();
                     }
                  },
                ),
                const SizedBox(height: 40,),
                Consumer3<AssetsProvider, CustomerProvider, PaymentProvider>(
                  builder: (context, assetsProvider, customerProvider, paymentProvider, child) {
                    return CustomButton(
                      data: "Proceed to make payment",
                      isLoading: assetsProvider.isMakingReservation  ,
                      textColor: Constants.whiteColor,
                      color: Constants.primaryColor,
                      onPressed: () async{
                        if(!formKey.currentState.validate()) return;

                        bool hasCscs = await customerProvider.hasCscs();
                        if(!hasCscs){
                          showCscsDialog();
                          return;
                        }
                        bool hasNuban = await customerProvider.hasNuban();
                        if(!hasNuban){
                          showBankDetailDialog();
                          return;
                        }
                        String assetId = widget.asset.id;
                        int unit = int.parse(unitQuantityTextEditingController.text);
                        double amount = double.parse(estimatedAmountTextEditingController.text);
                        var expressInterestResponse = await Provider.of<AssetsProvider>(context, listen: false).payNow(assetId : assetId, units : unit, amount: amount);
                        var response = await paymentProvider.getPaymentUrl(reservationId: expressInterestResponse.data.reservation.id, gateway: 'flutterwave');
                        if(response.error == null){
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                            return PaymentWebScreen(response.data.authorizationUrl);
                          }
                          ));
                        }else{
                          final snackBar = SnackBar(
                            content: Container(
                              height: 70,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Payment Error', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
                                  SizedBox(height: 15,),
                                  Text(response.error.message),
                                ],
                              ),
                            ),);
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        // showCssBottomSheet(context);
                      },
                    );
                  },
                ),
                const SizedBox(height: 20,),
                Consumer<AssetsProvider>(
                  builder: (context, assetsProvider, child) {
                    return CustomButton(
                      data: "Pay Later",
                      isLoading: assetsProvider.isSavingReservation,
                      textColor: Constants.whiteColor,
                      color: Constants.innerBorderColor,
                      onPressed: () async{
                        if(!formKey.currentState.validate()){
                          return;
                        }
                        ExpressInterestResponseModel response = await Provider.of<AssetsProvider>(context, listen: false).payLater(
                          assetId : widget.asset.id,
                          units :  int.parse(unitQuantityTextEditingController.text),
                        );
                        if(response.error == null){
                          showSimpleModalDialog(
                              context: context,
                              title: 'Transaction saved',
                              message: 'You can make payment in your transactions page later.',
                              onClose: (){
                                changePage(context,2);
                                Navigator.pushNamed(context,'/dashboard');
                              }
                          );
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

  void showCreateCscsModal(){
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('A CSCS account number would be created for you', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Your CSCS number is mandatory/required to complete your application', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Proceed', style: TextStyle(color: Constants.blackColor),),
              onPressed: () {
                Navigator.popAndPushNamed(context, '/create-cscs', arguments: true);
              },
            ),
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: Constants.yellowColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showCscsDialog(){
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cscs Information', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('To make payment for this asset, you should have a CSCS Number. Do you have a CSCS Number?', style: TextStyle(fontSize: 14,)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes', style: TextStyle(color: Constants.blackColor),),
              onPressed: () {
                Navigator.popAndPushNamed(context, '/enter-cscs', arguments: true);
              },
            ),
            TextButton(
              child: const Text('No, I don\'t', style: TextStyle(color: Constants.yellowColor)),
              onPressed: () {
                Navigator.of(context).pop();
                showCreateCscsModal();
              },
            ),
          ],
        );
      },
    );
  }

  void showBankDetailDialog(){
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bank Information'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Please update your Bank detail to continue'),
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
  }
}
