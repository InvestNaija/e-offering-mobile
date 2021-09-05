import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invest_naija/business_logic/data/response/payment_url_response.dart';
import 'package:invest_naija/business_logic/data/response/transaction_response_model.dart';
import 'package:invest_naija/business_logic/providers/customer_provider.dart';
import 'package:invest_naija/business_logic/providers/payment_provider.dart';
import 'package:invest_naija/components/custom_button.dart';
import 'package:invest_naija/components/custom_lead_icon.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'payment_web_screen.dart';

class TransactionSummaryScreen extends StatefulWidget {
  final TransactionResponseModel transaction;

  const TransactionSummaryScreen({Key key, this.transaction}) : super(key: key);
  @override
  _TransactionSummaryScreenState createState() => _TransactionSummaryScreenState();
}

class _TransactionSummaryScreenState extends State<TransactionSummaryScreen> {
  String amount;
  String totalPrice;
  String estimatedUnits;

  @override
  void initState() {
    super.initState();
    NumberFormat formatCurrency = NumberFormat.simpleCurrency(locale: Platform.localeName, name: widget.transaction.asset.currency);
    amount = widget.transaction.asset.sharePrice == 0 ? 'Pending price discovery' : formatCurrency.format(widget.transaction.asset.sharePrice);
    int calcNumber = widget.transaction.asset.sharePrice == 0 ? 1 : widget.transaction.asset.sharePrice;
    totalPrice =  formatCurrency.format(widget.transaction.unitsExpressed * calcNumber);
    estimatedUnits = widget.transaction.asset.sharePrice == 0 ? 'Pending price discovery' :  formatCurrency.format(widget.transaction.amount/widget.transaction.asset.sharePrice);
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40,),
              Text(
                "Summary",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Constants.blackColor),
              ),
              SizedBox(height: 5,),
              const Text(
                "Please take a look at your order summary before making payment",
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Constants.neutralColor),
              ),
              SizedBox(height: 21,),
              Card(child: ClipPath(
                clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3))),
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: Constants.successColor, width: 5))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment : CrossAxisAlignment.start,
                            children: [
                              Align(child: Text("Transaction Ref.", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Constants.neutralColor),)),
                              Text(widget.transaction.id, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Constants.blackColor),),
                            ],
                          ),
                          Image.network(widget.transaction.asset.image, width: 24, height: 24,)
                        ],
                      ),
                      SizedBox(height: 7,),
                      Divider(),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Price Per Share", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Constants.neutralColor),),
                          Text(amount ?? '', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Constants.blackColor),),
                        ],
                      ),
                      SizedBox(height: 14,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Estimated Units", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Constants.neutralColor),),
                          Text(estimatedUnits, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Constants.blackColor),),
                        ],
                      ),
                      const SizedBox(height: 14,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Constants.neutralColor),),
                          Text(totalPrice, style: TextStyle(fontFamily: 'RobotoMono', fontSize: 14, fontWeight: FontWeight.w700, color: Constants.blackColor),),
                        ],
                      ),
                      SizedBox(height: 14,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Offering Type", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Constants.neutralColor),),
                          Text(widget.transaction.asset.type == 'ipo' ? 'Public offer': widget.transaction.asset.type, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Constants.blackColor),),
                        ],
                      ),
                      const SizedBox(height: 15,),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Pay With", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Constants.neutralColor),),
                          Text('Flutterwave', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Constants.blackColor),),
                        ],
                      )
                    ],),
                ),
              ),),
              const SizedBox(height: 20,),
              const Text(
                "Note : You will be allotted the units you purchased for this shares in a few days.",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Constants.blackColor),
              ),
              const SizedBox(height: 33,),
              Consumer2<CustomerProvider, PaymentProvider>(
               builder: (context,customerProvider, paymentProvider, cachedWidget){
                return CustomButton(
                  data: "Make Payment",
                  isLoading: customerProvider.isFetchingCustomersDetails || paymentProvider.isFetchingPaymentLink,
                  textColor: Constants.whiteColor,
                  color: Constants.primaryColor,
                  onPressed: () async {
                    //await customerProvider.getCustomerDetails();
                    PaymentUrlResponse response = await paymentProvider.getPaymentUrl(reservationId: widget.transaction.id, gateway: 'flutterwave');
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
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
