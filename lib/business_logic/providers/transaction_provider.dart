import 'package:flutter/foundation.dart';
import 'package:invest_naija/business_logic/data/response/transaction_list_response_model.dart';
import 'package:invest_naija/business_logic/data/response/transaction_response_model.dart';
import 'package:invest_naija/business_logic/repository/transactions_repository.dart';

class TransactionProvider extends ChangeNotifier{
  bool loading = true;
  double cumulativeEIpoInvestmentAmount = 0.0;

  bool loadingRecentTransaction = true;
  List<TransactionResponseModel> recentTransactions = [];
  List<TransactionResponseModel> transactions = [];
  List<TransactionResponseModel> reservoir = [];

  Future<bool> refreshTransactions() async{
    loadingRecentTransaction = true;
    notifyListeners();
    getRecentTransactions();
    return true;
  }

  void filterTransactionByStatus(String status){
      if(status.isEmpty || status.toLowerCase() == 'all'){
        transactions = reservoir;
      }else {
        transactions = reservoir.where((trnx) => trnx.status == status.toLowerCase()).toList();
      }
      notifyListeners();
  }

  void refreshRecentTransactions() async{
    loadingRecentTransaction = true;
    notifyListeners();
    getRecentTransactions();
  }

  void getRecentTransactions() async{
    try{
      TransactionListResponseModel transactionsResponse = await TransactionRepository().getTransactions();
      if(transactionsResponse.error == null){
        var filteredAssets = transactionsResponse.data.where((element) => element.asset.type == 'ipo').toList();
        recentTransactions = filteredAssets.reversed.toList().getRange(0, 5).toList();
        transactions = filteredAssets.reversed.toList();
        reservoir = filteredAssets.reversed.toList();
        calculateCumulativeEIpoInvestmentAmount(transactionsResponse.data);
      }
    }catch(exception){}
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