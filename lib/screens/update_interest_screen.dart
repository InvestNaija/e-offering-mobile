import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invest_naija/business_logic/data/response/express_interest_response_model.dart';
import 'package:invest_naija/business_logic/data/response/payment_url_response.dart';
import 'package:invest_naija/business_logic/data/response/shares_response_model.dart';
import 'package:invest_naija/business_logic/data/response/transaction_response_model.dart';
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

class UpdateInterestScreen extends StatefulWidget {

  final TransactionResponseModel transaction;

  const UpdateInterestScreen({Key key, this.transaction}) : super(key: key);

  @override
  _UpdateInterestScreenState createState() => _UpdateInterestScreenState();
}

class _UpdateInterestScreenState extends State<UpdateInterestScreen> with DialogMixins, ApplicationMixin{
  TextEditingController unitQuantityTextEditingController = TextEditingController();
  TextEditingController amountTextEditingController;

  bool makeSpecifiedUnitReadOnly = false;
  bool makeEstimatedAmountReadOnly = false;
  GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    makeSpecifiedUnitReadOnly = widget.transaction.asset.sharePrice == 0;
    makeEstimatedAmountReadOnly = widget.transaction.asset.sharePrice != 0;
    unitQuantityTextEditingController.text = '0' ;
    amountTextEditingController = TextEditingController(text: widget.transaction.amount.toString());
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
                  child: const Text("Update your transaction details",
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
                  controller: TextEditingController(text: widget.transaction.asset.type == 'ipo' ? 'Public offer' : widget.transaction.asset.type),
                ),
                const  SizedBox(height: 25,),
                CustomTextField(
                  readOnly: true,
                  label: "Purchase Price",
                  controller: TextEditingController(text: widget.transaction.asset.sharePrice == 0 ? 'Pending price discovery' : widget.transaction.asset.sharePrice.toString()),
                ),
                const SizedBox(height: 25,),
                CustomTextField(
                  readOnly: makeSpecifiedUnitReadOnly,
                  label: "Specified Units",
                  controller: unitQuantityTextEditingController,
                  keyboardType : TextInputType.number,
                  onChange: (value){
                      var digit = value.isEmpty ? 0 : int.parse(value);
                      amountTextEditingController.text = (digit * widget.transaction.asset.sharePrice).toString();
                  },
                ),
                const SizedBox(height: 25,),
                CustomTextField(
                  readOnly: makeEstimatedAmountReadOnly,
                  label: "Amount",
                  controller: amountTextEditingController,
                  keyboardType: TextInputType.number,
                  onChange: (value){
                     if(widget.transaction.asset.sharePrice != 0.0){
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
                      data: "Update",
                      isLoading: assetsProvider.isMakingReservation || paymentProvider.isFetchingPaymentLink,
                      textColor: Constants.whiteColor,
                      color: Constants.primaryColor,
                      onPressed: () async{
                        if(!formKey.currentState.validate()) return;
                        int unit = int.parse(unitQuantityTextEditingController.text);
                        double amount = double.parse(amountTextEditingController.text);
                        var response = await assetsProvider.updateReservation(
                            reservationId : widget.transaction.id,
                            units : unit,
                            amount: amount,
                        );
                        if(response.error != null){
                          showSnackBar('Unable to express interest', response.error.message);
                        }else{
                          showSnackBar('Update', response.message);
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
