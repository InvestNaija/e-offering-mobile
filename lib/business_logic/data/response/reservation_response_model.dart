import 'package:invest_naija/business_logic/data/response/response_model.dart';

class ReservationResponseModel{
  String id;
  double amount;
  String assetId;
  String brokerId;
  String createdAt;
  String updatedAt;
  String customerId;
  bool paid;
  String refund;
  String status;
  int unitsAlloted;
  int unitsExpressed;
  int unitsRefund;

  ReservationResponseModel.fromJson(Map<String, dynamic> json) :
        id = json["id"],
        amount = json["amount"] * 1.0,
        assetId = json["assetId"],
        brokerId = json["brokerId"],
        customerId = json["customerId"],
        paid = json["paid"],
        refund = json["refund"],
        status = json["status"],
        unitsAlloted = json["unitsAlloted"],
        unitsExpressed = json["unitsExpressed"],
        unitsRefund = json["unitsRefund"],
        createdAt = json["createdAt"],
        updatedAt = json["updatedAt"];
}