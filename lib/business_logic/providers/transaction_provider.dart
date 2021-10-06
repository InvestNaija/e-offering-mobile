import 'package:flutter/foundation.dart';
import 'package:invest_naija/business_logic/data/response/shares_response_model.dart';
import 'package:invest_naija/business_logic/data/response/transaction_list_response_model.dart';
import 'package:invest_naija/business_logic/data/response/transaction_response_model.dart';
import 'package:invest_naija/business_logic/repository/transactions_repository.dart';

class TransactionProvider extends ChangeNotifier{
  bool loading = true;
  Map<String, double> portfolioAmount = Map();

  bool loadingRecentTransaction = true;
  List<TransactionResponseModel> recentTransactions = [];
  List<TransactionResponseModel> transactions = [];
  List<TransactionResponseModel> reservoir = [];
  bool hasError = false;
  String errorMessage = '';

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
        hasError = false;
        errorMessage = '';
        var filteredAssets = transactionsResponse.data.where((element) => element.asset.type == 'ipo').toList();
        recentTransactions = filteredAssets.reversed.toList().take(5).toList();
        transactions = filteredAssets.reversed.toList();
        reservoir = filteredAssets.reversed.toList();
        calculateCumulativeEIpoInvestmentAmount(filteredAssets);
      }else{
        hasError = true;
        errorMessage = transactionsResponse.error.message;
      }
    }catch(exception){
      print(exception.toString());
      hasError = true;
      errorMessage = 'An error occurred';
    }
    loadingRecentTransaction = false;
    notifyListeners();
  }

  void calculateCumulativeEIpoInvestmentAmount(List<TransactionResponseModel> transactions){
    Map<String, double> currencyValue = Map();
    var paidTransactions = transactions.where((transaction) => transaction.status.toLowerCase() == 'paid').toList();
    for(TransactionResponseModel transaction in paidTransactions){
      String currency = transaction.asset.currency;
      if(!currencyValue.containsKey(currency)){
        currencyValue[currency] = transaction.amount;
      }else{
        currencyValue[currency] = transaction.amount + currencyValue[currency];
      }
    }
    portfolioAmount = currencyValue;
  }

  void updateTransaction({String reservationId, double units, double amount}) {
    var reservoirIndex = reservoir.indexWhere((trxn) => trxn.id == reservationId);
    if(reservoirIndex >= 0){
      reservoir[reservoirIndex]..amount = amount
        ..unitsExpressed = units;

      recentTransactions = reservoir.take(5).toList();
      transactions = reservoir.take(reservoir.length).toList();
      notifyListeners();
    }
  }

  void updateTransactionAsPaid(SharesResponseModel asset) {
    try{
      var reservoirIndex = reservoir.indexWhere((trxn) => trxn.asset.id == asset.id);
      if(reservoirIndex >= 0){
        print('resevior index ===> $reservoirIndex');
        print(reservoir[reservoirIndex].status);
        reservoir[reservoirIndex].status = 'paid';
        recentTransactions = reservoir.take(5).toList();
        transactions = reservoir.take(reservoir.length).toList();
        notifyListeners();

      }else{
        print('resevior index ===> $reservoirIndex');
      }
    }catch(ex){
      print(ex);
    }
  }
}