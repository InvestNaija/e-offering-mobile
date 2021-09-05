import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invest_naija/business_logic/data/response/transaction_response_model.dart';
import 'package:invest_naija/utils/formatter_util.dart';
import 'package:shimmer/shimmer.dart';

import '../constants.dart';

class TransactionRow extends StatelessWidget {
  final Function onTap;
  final TransactionResponseModel transaction;

  const TransactionRow({Key key, this.onTap, this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: Platform.localeName, name: transaction.asset.currency);
    String amount = formatCurrency.format(transaction.amount);
    print(amount);

    return GestureDetector(
      onTap: ()=> onTap(),
      child: Container(
        margin: EdgeInsets.only(bottom: 11),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.network(transaction.asset.image, height: 26, width: 26,),
                    SizedBox(width: 15,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(amount,
                          style: const TextStyle(
                              fontFamily: 'RobotoMono',
                              color: Constants.blackColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          transaction.asset.name,
                          style: const TextStyle(
                              color: Constants.gray4Color,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ],),
                  ],
                ),

                Text(FormatterUtil.formatName(this.transaction.status),
                  style: TextStyle(
                      color: this.transaction.paid ? Constants.greenColor : Constants.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 11,),
            const Divider(color: Constants.gray4Color,)
          ],
        ),
      ),
    );
  }
}


class LoadingTransactionRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color.fromRGBO(151, 150, 145, 0.2),
      highlightColor: Color.fromRGBO(229, 229, 222, 0.6),
      child: Container(
        color: Constants.primaryColor,
        margin: EdgeInsets.only(bottom: 11),
        height: 50,
        width: double.infinity,
      ),
    );
  }
}