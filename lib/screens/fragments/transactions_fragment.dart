
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invest_naija/business_logic/providers/transaction_provider.dart';
import 'package:invest_naija/components/transaction_row.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../transaction_summary_screen.dart';

class TransactionsFragment extends StatefulWidget {
  @override
  _TransactionsFragmentState createState() => _TransactionsFragmentState();
}

class _TransactionsFragmentState extends State<TransactionsFragment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Transactions", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Constants.blackColor),),
                SvgPicture.asset("assets/images/filter.svg"),
              ],
            ),
          ),
          const SizedBox(height: 35,),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
              child: Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Consumer<TransactionProvider>(
                    builder: (context, transactionsProvider, child) {
                      return RefreshIndicator(
                        onRefresh: ()=> transactionsProvider.refreshTransactions(),
                        child: ListView.builder(
                          itemCount: transactionsProvider.loadingRecentTransaction ? 10 : transactionsProvider.recentTransactions.length,
                          itemBuilder: (context, index){
                          return transactionsProvider.loadingRecentTransaction ?
                          LoadingTransactionRow():
                          TransactionRow(
                            transaction: transactionsProvider.recentTransactions[index],
                            onTap: (){
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => TransactionSummaryScreen(
                                      transaction: transactionsProvider.recentTransactions[index],
                                    )));
                            }
                          );
                        },),
                      );
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
