import 'package:invest_naija/business_logic/data/response/response_model.dart';

class PaymentUrlResponse extends ResponseModel{
  PaymentData data;
  PaymentUrlResponse();
  PaymentUrlResponse.fromJson(Map<String, dynamic> json) :
        data = PaymentData.fromJson(json['data']),
        super.fromJson(json);
}

class PaymentData{
  String authorizationUrl;
  PaymentData.fromJson(Map<String, dynamic> json):
        authorizationUrl = json == null ? null : json['authorization_url'] ?? '';
}
