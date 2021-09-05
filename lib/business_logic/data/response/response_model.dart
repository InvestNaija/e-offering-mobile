import 'error_response.dart';

class ResponseModel{
  int code;
  String status;
  String message;
  ErrorResponse error;

  ResponseModel();

  ResponseModel.fromJson(Map<String, dynamic> json) :
        code = json["code"],
        status = json["status"],
        message = json["message"],
        error = json["error"] == null ? null : ErrorResponse.fromJson(json["error"]);
}