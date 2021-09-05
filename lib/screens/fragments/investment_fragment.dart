import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invest_naija/business_logic/providers/transaction_provider.dart';
import 'package:invest_naija/components/investment_detail_breakdown_card.dart';
import 'package:invest_naija/components/investment_detail_card.dart';
import 'package:invest_naija/constants.dart';
import 'package:provider/provider.dart';

import 'investment_plans_fragment.dart';

class InvestmentFragment extends StatefulWidget {
  @override
  _InvestmentFragmentState createState() => _InvestmentFragmentState();
}

class _InvestmentFragmentState extends State<InvestmentFragment> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        Provider.of<TransactionProvider>(context, listen: false).refreshRecentTransactions();
        return Future<bool>.value(true);
      },
      child: Container(
        child: Consumer<TransactionProvider>(builder: (context, transactionProvider, widget){
          return Stack(children: [
            Offstage(
              offstage: transactionProvider.recentTransactions.length > 0,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/images/data-analyst.svg", height: 135, width: 180,),
                    const Text(
                      "You currently do not have any savings plan\nrunning, click the button to start",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12, color: Constants.fontColor2),
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.symmetric(horizontal: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Investment",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Constants.fontColor2,
                              fontSize: 24,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                        const SizedBox(height: 25,),
                        Consumer<TransactionProvider>(
                          builder: (BuildContext context, transactionProvider, Widget child) {
                            return InvestmentDetailCard(
                              cumulativeEIpoInvestmentAmount: transactionProvider.cumulativeEIpoInvestmentAmount,
                              onTap: (){
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => InvestmentPlansFragment()));
                            },);
                          },
                        ),
                        const SizedBox(height: 50,),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                      child: Card(
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding:  const EdgeInsets.only(right: 22, left: 22, top: 30),
                          child: Column(
                            children: [
                              Row(children: [
                                SvgPicture.asset('assets/images/investment-analysis.svg', width: 25, height: 25,),
                                const SizedBox(width: 12,),
                                const Text("My investments",
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      color: Constants.blackColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              ],),
                              const SizedBox(height: 30,),
                              Expanded(child: ListView.separated(
                                itemCount: transactionProvider.loadingRecentTransaction ? 5 : transactionProvider.recentTransactions.length,
                                itemBuilder: (context, index){
                                  return transactionProvider.loadingRecentTransaction ? LoadingInvestmentDetailBreakdownCard() : InvestmentDetailBreakdownCard(transaction: transactionProvider.recentTransactions[index],);
                                }, separatorBuilder: (BuildContext context, int index)=> SizedBox(height: 10,),
                              ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],);
        }),
      ),
    );
  }
}
