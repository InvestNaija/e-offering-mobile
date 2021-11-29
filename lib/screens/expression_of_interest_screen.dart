import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invest_naija/business_logic/data/response/express_interest_response_model.dart';
import 'package:invest_naija/business_logic/data/response/payment_url_response.dart';
import 'package:invest_naija/business_logic/data/response/shares_response_model.dart';
import 'package:invest_naija/business_logic/providers/assets_provider.dart';
import 'package:invest_naija/business_logic/providers/customer_provider.dart';
import 'package:invest_naija/business_logic/providers/payment_provider.dart';
import 'package:invest_naija/components/custom_button.dart';
import 'package:invest_naija/components/custom_checkbox.dart';
import 'package:invest_naija/components/custom_lead_icon.dart';
import 'package:invest_naija/components/custom_textfield.dart';
import 'package:invest_naija/mixins/application_mixin.dart';
import 'package:invest_naija/mixins/dialog_mixin.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
  TextEditingController amountTextEditingController = TextEditingController();

  bool makeSpecifiedUnitReadOnly = false;
  bool makeEstimatedAmountReadOnly = false;
  GlobalKey<FormState> formKey;
  bool hasAcceptedTermsAndConditions = false;

  @override
  void initState() {
    super.initState();
    print(widget.asset.openingDate);
    print(widget.asset.closingDate);
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
                          color: Constants.blackColor,
                      ),
                  ),
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
                  readOnly: false,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'[.]'))
                  ],
                  label: "Specified Units",
                  controller: unitQuantityTextEditingController,
                  keyboardType : TextInputType.number,
                  onChange: (value){
                      var digit = value.isEmpty ? 0 : int.parse(value);
                      amountTextEditingController.text = (digit * widget.asset.sharePrice).toString();
                  },
                ),
                const SizedBox(height: 25,),
                CustomTextField(
                  readOnly: true,
                  label: "Amount",
                  controller: amountTextEditingController,
                  keyboardType: TextInputType.number,
                  onChange: (value){
                     if(widget.asset.sharePrice != 0.0){
                       var digit = int.parse(value);
                       var digitTwo = int.parse(unitQuantityTextEditingController.text);
                       unitQuantityTextEditingController.text = (digit * digitTwo).toString();
                     }
                  },
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomCheckbox(
                      onTap: (value){
                        setState(() => hasAcceptedTermsAndConditions = value);
                      },
                      hasAcceptedTermsAndConditions: hasAcceptedTermsAndConditions,
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(children: <TextSpan>[
                          const TextSpan(
                            text:
                            'I have read and accept the purchase conditions, and understand the ',
                            style: const TextStyle(
                                color: Constants.neutralColor, fontSize: 12),
                          ),
                          TextSpan(
                              text: 'Shelf prospectus, ',
                              style: const TextStyle(
                                  color: Constants.primaryColor, fontSize: 12),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async{
                                  await launch('https://drive.google.com/file/d/1pJ5PK4x6k4CqL0Ey8XO2BMdwL6wULiS7/view');
                                  //Navigator.pushNamed(context, '/payment-web', arguments: PaymentWebScreenArguments('', widget.asset));
                                }),
                          TextSpan(
                              text: 'Pricing supplement',
                              style: const TextStyle(
                                  color: Constants.primaryColor, fontSize: 12),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async{
                                  await launch('https://drive.google.com/file/d/1b-i2lNQCjsuMKMZy6bfUZ3iVjapLLnU3/view?usp=sharing');
                                  //Navigator.pushNamed(context, '/payment-web', arguments: PaymentWebScreenArguments('', widget.asset));
                                }),
                          TextSpan(
                              text: ' and Term sheet',
                              style: const TextStyle(
                                  color: Constants.primaryColor, fontSize: 12),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async{
                                  await launch('https://drive.google.com/file/d/1nO-dAlpwrb3N_uDjJwbGJC5qellqMkQm/view');
                                  //Navigator.pushNamed(context, '/payment-web', arguments: PaymentWebScreenArguments('', widget.asset));
                                })
                        ]),
                      ),
                    ),
                    const SizedBox(width: 5,),
                  ],
                ),
                const SizedBox(height: 40,),
                Consumer3<AssetsProvider, CustomerProvider, PaymentProvider>(
                  builder: (context, assetsProvider, customerProvider, paymentProvider, child) {
                    return CustomButton(
                      data: "Pay Now",
                      isLoading: assetsProvider.isMakingReservation || paymentProvider.isFetchingPaymentLink,
                      textColor: Constants.whiteColor,
                      color: Constants.primaryColor,
                      onPressed: () async{
                        if(!hasAcceptedTermsAndConditions){
                          showSnackBar('Info', 'Condition not read/accepted');
                          return;
                        }
                        if(!formKey.currentState.validate()) return;
                        print(unitQuantityTextEditingController.text);
                        if(num.parse(unitQuantityTextEditingController.text) < widget.asset.minimumNoOfUnits){
                          showSnackBar('Info', 'The minimum order is ${widget.asset.minimumNoOfUnits}');
                          return;
                        }

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
                        double amount = double.parse(amountTextEditingController.text);
                        var expressInterestResponse = await assetsProvider.payNow(assetId : assetId, units : unit, amount: amount);
                        if(expressInterestResponse.error != null){
                          showSnackBar('Unable to express interest', expressInterestResponse.error.message);
                          return;
                        }
                        var response = await paymentProvider.getPaymentUrl(
                            reservationId: expressInterestResponse.data.reservation.id,
                            gateway: 'flutterwave',
                            currency: widget.asset.currency
                        );
                        if(response.error != null){
                          showSnackBar('Payment Error', response.error.message);
                          return;
                        }
                        print('response.data.authorizationUrl ===> ${response.data.authorizationUrl}');

                        bool isSuccessful = await Navigator.pushNamed(context, '/payment-web', arguments: PaymentWebScreenArguments(response.data.authorizationUrl, widget.asset)) as bool;
                        if(isSuccessful == true){
                          Navigator.popUntil(context, ModalRoute.withName('/dashboard'),);
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 20,),
                // Consumer<AssetsProvider>(
                //   builder: (context, assetsProvider, child) {
                //     return Tooltip(
                //       message: 'This would save the record in your transactions \n as pending so you can pay later',
                //       child: CustomButton(
                //         data: "Pay Later",
                //         isLoading: assetsProvider.isSavingReservation,
                //         textColor: Constants.whiteColor,
                //         color: Constants.innerBorderColor,
                //         onPressed: () async{
                //           if(!formKey.currentState.validate()){
                //             return;
                //           }
                //           double amount = double.parse(amountTextEditingController.text);
                //           ExpressInterestResponseModel response = await Provider.of<AssetsProvider>(context, listen: false).payLater(
                //             assetId : widget.asset.id,
                //             units :  int.parse(unitQuantityTextEditingController.text),
                //             amount : amount
                //           );
                //           if(response.error == null){
                //             showSimpleModalDialog(
                //                 context: context,
                //                 title: 'Transaction saved',
                //                 message: 'You can make payment in your transactions page later.',
                //                 onClose: (){
                //                   changePage(context,2);
                //                   Navigator.pushNamed(context,'/dashboard');
                //                 }
                //             );
                //           }
                //         },
                //       ),
                //     );,
                //   },
                // ),
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
  void showSnackBar(String title, String msg){
    final snackBar = SnackBar(
      content: Container(
        height: 70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
            SizedBox(height: 15,),
            Text(msg),
          ],
        ),
      ),);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
