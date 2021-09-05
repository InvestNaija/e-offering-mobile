import 'package:invest_naija/business_logic/data/response/response_model.dart';
import 'package:invest_naija/business_logic/data/response/transaction_response_model.dart';

class TransactionListResponseModel extends ResponseModel{
  List<TransactionResponseModel> data;

  TransactionListResponseModel();

  TransactionListResponseModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    code = json["code"];
    status = json["status"];
    message = json["message"];

    var list = json['data'] as List;
    data = list == null ? [] : list.map((i) => TransactionResponseModel.fromJson(i)).toList();
  }
}