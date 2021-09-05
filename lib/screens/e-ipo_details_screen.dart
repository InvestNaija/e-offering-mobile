import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:invest_naija/business_logic/data/response/shares_response_model.dart';
import 'package:invest_naija/components/custom_button.dart';
import 'package:invest_naija/components/custom_checkbox.dart';
import 'package:invest_naija/components/custom_lead_icon.dart';
import 'package:invest_naija/utils/formatter_util.dart';

import '../constants.dart';

class EIpoDetailsScreen extends StatefulWidget {
  final SharesResponseModel asset;

  const EIpoDetailsScreen({Key key, this.asset}) : super(key: key);
  @override
  _EIpoDetailsScreenState createState() => _EIpoDetailsScreenState();
}

class _EIpoDetailsScreenState extends State<EIpoDetailsScreen> {
  bool hasAcceptedTermsAndConditions = false;
  
  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: Platform.localeName, name: widget.asset.currency);
    String minAmount = formatCurrency.format(widget.asset.anticipatedMinPrice);
    String maxAmount = FormatterUtil.formatNumber(widget.asset.availableShares);
    String sharePrice = widget.asset.sharePrice == 0 ? 'Pending Price Discovery' : '${formatCurrency.format(widget.asset.sharePrice)}';

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
            title: Row(
              children: [
                const SizedBox(width: 25,),
                Image.network(widget.asset.image ?? "https://i.ibb.co/J5NWzMb/mtn.png", width: 24, height: 24,),
                const SizedBox(width: 13,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.asset.name ?? '', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Constants.blackColor),),
                    Text("$minAmount - $maxAmount", style: TextStyle(fontSize: 10, fontFamily: 'RobotoMono', fontWeight: FontWeight.w700, color: Constants.neutralColor),),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 22, right: 22, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40,),
              const Text("Overview",
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Constants.blackColor),
              ),
              const SizedBox(height: 12,),
              Card(child: ClipPath(
                clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3))),
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: Constants.successColor, width: 5))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Share price", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Constants.neutralColor),),
                      const SizedBox(height: 4,),
                      Text(sharePrice, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Constants.blackColor),),
                      const SizedBox(height: 7,),
                      Divider(),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Application Status", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Constants.blackColor),),
                          Text(widget.asset.openForPurchase ? 'Open' : 'Closed', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Constants.successColor),),
                        ],
                      ),
                      SizedBox(height: 12,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Offering Type", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Constants.blackColor),),
                          Text(widget.asset.type == 'ipo' ? 'Public Offer' : widget.asset.type, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Constants.blackColor),),
                        ],
                      ),
                      const SizedBox(height: 12,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Minimum Price", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Constants.blackColor),),
                          Text(minAmount, style: TextStyle(fontSize: 12, fontFamily: 'RobotoMono', fontWeight: FontWeight.w600, color: Constants.blackColor),),
                        ],
                      ),
                      SizedBox(height: 12,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Available shares", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Constants.blackColor),),
                          Text(maxAmount, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Constants.blackColor),),
                        ],
                      ),
                      const SizedBox(height: 15,),
                    ],),
                ),
              ),),
              const SizedBox(height: 20,),
              const Text("IPO Description",
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Constants.blackColor),
              ),
              const SizedBox(height: 12,),
              Card(child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.asset.name ?? "MTN Nigeria", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Constants.blackColor),),
                        Image.network(widget.asset.image, width: 24, height: 24,)
                      ],
                    ),
                    const SizedBox(height: 15,),
                Html(data: widget.asset.description,)
               ],
              ),
              ),),
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
                            text: 'Terms and Conditions',
                            style: const TextStyle(
                                color: Constants.primaryColor, fontSize: 12),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // navigate to desired screen
                              })
                      ]),
                    ),
                  ),
                  const SizedBox(width: 5,),
                ],
              ),
              const SizedBox(height: 25,),
              CustomButton(
                data: "Purchase",
                textColor: Constants.whiteColor,
                color: Constants.primaryColor,
                onPressed: () {
                  if(!hasAcceptedTermsAndConditions){
                    final snackBar = SnackBar(content: Text('Please accept the terms and condition'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    return;
                  }

                  Navigator.pushNamed(context,'/express-interest', arguments: widget.asset);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
