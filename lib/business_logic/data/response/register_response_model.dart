import 'package:invest_naija/business_logic/data/response/customer_response_model.dart';
import 'package:invest_naija/business_logic/data/response/error_response.dart';

class RegisterResponseModel{
  int code;
  String status;
  ErrorResponse error;
  CustomerResponseModel data;

  RegisterResponseModel();

  RegisterResponseModel.fromJson(Map<String, dynamic> json) :
      code = json["code"],
      status = json["status"],
      error = json["error"] ==  null ? null : ErrorResponse.fromJson(json["error"]),
      data = json["data"] ==  null ? null : CustomerResponseModel.fromJson(json["data"]);
}