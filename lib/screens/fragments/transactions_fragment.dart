
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invest_naija/business_logic/providers/transaction_provider.dart';
import 'package:invest_naija/components/custom_button.dart';
import 'package:invest_naija/components/custom_checkbox.dart';
import 'package:invest_naija/components/filter_checkbox.dart';
import 'package:invest_naija/components/transaction_row.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../transaction_summary_screen.dart';

class TransactionsFragment extends StatefulWidget {
  @override
  _TransactionsFragmentState createState() => _TransactionsFragmentState();
}

class _TransactionsFragmentState extends State<TransactionsFragment> {
  String selectedType = '';
  TransactionProvider _transactionProvider;

  @override
  void initState() {
    super.initState();
    _transactionProvider = Provider.of<TransactionProvider>(context, listen: false);
  }

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
                GestureDetector(
                  onTap: ()=> _showCourseFilterModal(),
                  child: SvgPicture.asset("assets/images/filter.svg"),
                ),
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
                          itemCount: transactionsProvider.loadingRecentTransaction ? 10 : transactionsProvider.transactions.length,
                          itemBuilder: (context, index){
                          return transactionsProvider.loadingRecentTransaction ?
                          LoadingTransactionRow():
                          TransactionRow(
                            transaction: transactionsProvider.transactions[index],
                            onTap: () async{
                              await Navigator.pushNamed(context, '/transaction-summary', arguments: transactionsProvider.transactions[index]);
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

  Future<dynamic> _showCourseFilterModal(){
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(36),
                topLeft: Radius.circular(36)
            )
        ),
        elevation: 5,
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (BuildContext context, setState) => Container(
            padding: EdgeInsets.symmetric(horizontal: 22, vertical: 15),
            decoration: BoxDecoration(
                color: Constants.whiteColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(36),
                    topLeft: Radius.circular(36)
                )
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Transaction type",  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Constants.blackColor),),
                  FilterCheckBox(
                    name: 'All',
                    selected: selectedType == '',
                    onChanged: (value){
                      setState(() {
                        selectedType = '';
                      });
                    },
                  ),
                  FilterCheckBox(
                    name: 'Pending',
                    selected: selectedType == 'Pending',
                    onChanged: (value){
                      setState(() {
                        selectedType = 'Pending';
                      });
                    },
                  ),
                  FilterCheckBox(
                    name: 'Paid',
                    selected: selectedType == 'Paid',
                    onChanged: (value){
                      setState(() {
                        selectedType = 'Paid';
                      });
                    },
                  ),
                  SizedBox(height: 30,),
                  CustomButton(
                    data: "Apply filter",
                    color: Constants.primaryColor,
                    textColor: Constants.whiteColor,
                    onPressed: (){
                      _transactionProvider.filterTransactionByStatus(selectedType);
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
