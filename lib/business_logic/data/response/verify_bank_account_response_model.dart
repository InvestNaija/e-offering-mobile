import 'package:invest_naija/business_logic/data/response/response_model.dart';

class VerifyBankAccountResponseModel extends ResponseModel{
  BankDetailResponseModel data;

  VerifyBankAccountResponseModel.fromJson(Map<String, dynamic> json) : super.fromJson(json){
    data = json["data"] == null ? null : BankDetailResponseModel.fromJson(json["data"]);
  }
}

class BankDetailResponseModel{
  String accountName;
  String accountNumber;

  BankDetailResponseModel.fromJson(Map<String, dynamic> json){
    accountName = json["account_name"];
    accountNumber = json["account_number"];
  }
}