import 'package:invest_naija/business_logic/data/response/response_model.dart';

class ZannibalResponse extends ResponseModel{
  double lastPrice;

  ZannibalResponse();

  ZannibalResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    lastPrice = json["lastPrice"];
  }
}