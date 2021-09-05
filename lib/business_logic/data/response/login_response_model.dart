import 'package:invest_naija/business_logic/data/response/customer_response_model.dart';

import 'error_response.dart';

class LoginResponseModel{
  int code;
  String status;
  CustomerResponseModel data;
  ErrorResponse error;
  String message;
  String token;


  LoginResponseModel();

  LoginResponseModel.fromJson(Map<String, dynamic> json) :
        code = json["code"],
        status = json["status"],
        data = json["data"] == null ? null : CustomerResponseModel.fromJson(json["data"]),
        message = json["message"],
        token = json["token"],
        error = json["error"] == null ?  null : ErrorResponse.fromJson(json["error"]);
}