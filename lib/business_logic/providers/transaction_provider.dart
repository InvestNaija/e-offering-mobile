import 'package:flutter/foundation.dart';
import 'package:invest_naija/business_logic/data/response/transaction_list_response_model.dart';
import 'package:invest_naija/business_logic/data/response/transaction_response_model.dart';
import 'package:invest_naija/business_logic/repository/transactions_repository.dart';

class TransactionProvider extends ChangeNotifier{
  bool loading = true;
  double cumulativeEIpoInvestmentAmount = 0.0;

  bool loadingRecentTransaction = true;
  List<TransactionResponseModel> recentTransactions = [];

  Future<bool> refreshTransactions() async{
    loadingRecentTransaction = true;
    notifyListeners();
    getRecentTransactions();
    return true;
  }

  void refreshRecentTransactions() async{
    loadingRecentTransaction = true;
    notifyListeners();
    getRecentTransactions();
  }

  void getRecentTransactions() async{
    TransactionListResponseModel transactionsResponse = await TransactionRepository().getTransactions();
    if(transactionsResponse.error == null){
      recentTransactions = transactionsResponse.data;
      calculateCumulativeEIpoInvestmentAmount(transactionsResponse.data);
    }
    loadingRecentTransaction = false;
    notifyListeners();
  }

  void calculateCumulativeEIpoInvestmentAmount(List<TransactionResponseModel> transactions){
     double tempAmount = 0.0;
     for(TransactionResponseModel transaction in transactions){
       tempAmount += (transaction.unitsExpressed * transaction.amount);
     }
     cumulativeEIpoInvestmentAmount = tempAmount;
  }
}