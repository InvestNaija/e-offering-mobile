import 'package:invest_naija/business_logic/data/response/response_model.dart';

class WalletBalanceResponseModel extends ResponseModel{
  int balance;
  WalletBalanceResponseModel();

  WalletBalanceResponseModel.fromJson(Map<String, dynamic> json):
      balance = json["balance"],
      super.fromJson(json);
}