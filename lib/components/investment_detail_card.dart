import 'package:flutter/material.dart';
import 'package:invest_naija/utils/formatter_util.dart';

import '../constants.dart';

class InvestmentDetailCard extends StatelessWidget {
  final Function onTap;
  final cumulativeEIpoInvestmentAmount;
  const InvestmentDetailCard({Key key, this.onTap, this.cumulativeEIpoInvestmentAmount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(
            minHeight: 116,
            maxHeight: 116,
            minWidth: double.infinity),
        decoration: BoxDecoration(
          color: Constants.greenColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 10,
              left: 10,
              top: 30,
              child: Image.asset(
                "assets/images/hexagon.png",
                height: 77,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 24, top: 18, bottom: 18, right: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Wallet Balance",
                            style: const TextStyle(
                                color: Constants.whiteColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          GestureDetector(
                            onTap: ()=> this.onTap(),
                            child: const Text(
                              "+ New Investment",
                              style: const TextStyle(
                                  color: Constants.yellowColor, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        "₦${cumulativeEIpoInvestmentAmount == 0.0 ? cumulativeEIpoInvestmentAmount : FormatterUtil.formatNumber(cumulativeEIpoInvestmentAmount)}",
                        style: const TextStyle(
                            fontFamily: 'Roboto',
                            color: Constants.whiteColor,
                            fontSize: 28,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
