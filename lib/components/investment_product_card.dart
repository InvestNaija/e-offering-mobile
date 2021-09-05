import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invest_naija/business_logic/data/response/shares_response_model.dart';
import 'package:shimmer/shimmer.dart';
import '../constants.dart';

class InvestmentProductCard extends StatelessWidget {

  final SharesResponseModel asset;
  final Function onTap;

  const InvestmentProductCard({Key key,this.asset, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: Platform.localeName, name: asset.currency);
    return GestureDetector(
      onTap: (){
        this.onTap();
      },
      child: Card(
        child: SizedBox(height: 191, width: 150,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(this.asset.image ?? "https://i.ibb.co/J5NWzMb/mtn.png",
                  width: 30, height: 30,),
                const SizedBox(height: 14,),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      this.asset.name ?? "MTN Nigeria",
                      style: const TextStyle(
                          color: Constants.blackColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(height: 5,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Share Price:',
                      style: const TextStyle(
                        color: Constants.blackColor,
                        fontSize: 10,),
                    ),
                    Text(
                     this.asset.sharePrice == 0 ? 'Pending price discovery' : '${formatCurrency.format(this.asset.sharePrice)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Constants.blackColor,
                        fontSize: 13,),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Market Status:',
                      style: const TextStyle(
                        color: Constants.blackColor,
                        fontSize: 10,),
                    ),
                    Text(
                      this.asset.openForPurchase ? 'Open' : 'Closed',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Constants.successColor,
                        fontSize: 13,),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class LoadingInvestmentProductCard extends StatelessWidget {

  const LoadingInvestmentProductCard({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color.fromRGBO(151, 150, 145, 0.2),
      highlightColor: Color.fromRGBO(229, 229, 222, 0.6),
      child: Card(
        child: const SizedBox(height: 191, width: 150,),
      ),
    );
  }
}
