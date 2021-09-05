import 'package:flutter/foundation.dart';
import 'package:invest_naija/business_logic/repository/wallet_repository.dart';
import 'package:invest_naija/business_logic/data/response/wallet_balance_response_model.dart';

class WalletProvider extends ChangeNotifier{
  int walletBalance = 0;

  void getWalletBalance() async{
    WalletBalanceResponseModel walletBalanceResponse = await WalletRepository().getWalletBalance();
    walletBalance = walletBalanceResponse.balance;
    notifyListeners();
  }
}