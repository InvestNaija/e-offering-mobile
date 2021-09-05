import 'package:flutter/material.dart';
import 'package:invest_naija/business_logic/data/response/shares_response_model.dart';
import 'package:invest_naija/business_logic/data/response/transaction_response_model.dart';
import 'package:invest_naija/utils/formatter_util.dart';
import 'package:shimmer/shimmer.dart';

import '../constants.dart';

class InvestmentDetailBreakdownCard extends StatelessWidget {
  final TransactionResponseModel transaction;
  const InvestmentDetailBreakdownCard({Key key, this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Constants.yellowBrandColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: 24, top: 18, bottom: 18, right: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(transaction.asset.name,
                    style: const TextStyle(
                        color: Constants.fontColor2, fontSize: 14),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    "₦${FormatterUtil.formatNumber(transaction.amount)}", style: const TextStyle(
                        fontFamily: 'Roboto',
                        color: Constants.blackColor,
                        fontSize: 27,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Interest Rate",
                            style: const TextStyle(color: Constants.fontColor2, fontSize: 14),),
                          const Text(
                            "7% p.a",
                            style: TextStyle(
                                color: Constants.blackColor,
                                fontSize: 14, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      const SizedBox(width: 30,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Accrued Interest",
                            style: const TextStyle(color: Constants.fontColor2, fontSize: 14),),
                          const Text(
                            "₦11,000.00",
                            style: TextStyle(
                                color: Constants.greenColor,
                                fontSize: 14, fontWeight: FontWeight.w700),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 22,),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Units",
                            style: const TextStyle(color: Constants.fontColor2, fontSize: 14),),
                           Text(transaction.unitsExpressed.toString(),
                            style: const TextStyle(
                                color: Constants.blackColor,
                                fontSize: 14, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      const SizedBox(width: 30,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Initial Deposit",
                            style: const TextStyle(color: Constants.fontColor2, fontSize: 14),),
                           Text(
                            "₦${FormatterUtil.formatNumber(transaction.amount * transaction.unitsExpressed)}",
                            style: TextStyle(
                                color: Constants.blackColor,
                                fontSize: 14, fontWeight: FontWeight.w700),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),);
  }
}

class LoadingInvestmentDetailBreakdownCard extends StatelessWidget {

  const LoadingInvestmentDetailBreakdownCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color.fromRGBO(151, 150, 145, 0.2),
      highlightColor: Color.fromRGBO(229, 229, 222, 0.6),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Constants.yellowBrandColor,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
