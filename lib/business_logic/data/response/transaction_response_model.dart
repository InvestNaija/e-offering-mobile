import 'package:invest_naija/business_logic/data/response/customer_response_model.dart';
import 'package:invest_naija/business_logic/data/response/shares_response_model.dart';

class TransactionResponseModel{

  String id;
  double unitsExpressed;
  int unitsAlloted;
  int unitsRefund;
  double amount;
  bool paid;
  String refund;
  String status;
  String createdAt;
  String updatedAt;
  String customerId;
  String assetId;
  String brokerId;
  CustomerResponseModel customer;
  SharesResponseModel asset;

  TransactionResponseModel.fromJson(Map<String, dynamic> json){
     id = json["id"];
     unitsExpressed = json["unitsExpressed"] is double ? json["unitsExpressed"] :  (json["unitsExpressed"] as int).toDouble();
     unitsAlloted  = json["unitsAlloted"];
     unitsRefund  = json["unitsRefund"];
     amount = json["amount"] * 1.0;
     paid = json["paid"];
     refund = json["refund"];
     status = json["status"];
     createdAt = json["createdAt"];
     updatedAt = json["updatedAt"];
     customerId = json["customerId"];
     assetId = json["assetId"];
     brokerId = json["brokerId"];
     customer = CustomerResponseModel.fromJson(json["customer"]);
     asset = SharesResponseModel.fromJson(json["asset"]);
  }
}