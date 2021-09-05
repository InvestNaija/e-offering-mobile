import 'error_response.dart';

class BvnResponseModel{
  int code;
  String status;
  User data;
  ErrorResponse error;

  BvnResponseModel();

  BvnResponseModel.fromJson(Map<String, dynamic> json) :
      code = json["code"],
      status = json["status"],
      error = json["error"] == null ? null : ErrorResponse.fromJson(json["error"]),
      data = json["data"] == null ? null : User.fromJson(json["data"]);
}

class User{
  String firstname;
  String lastname;
  String middlename;
  String gender;
  String phone;
  String email;
  String birthdate;
  String photo;
  String bvn;
  String residentialAddress;

  User.fromJson(Map<String, dynamic> json) :
        firstname =  json["firstname"],
        lastname = json["lastname"],
        middlename = json["middlename"],
        email = json["email"],
        gender = json["gender"],
        phone = json["phone"],
        birthdate = json["birthdate"],
        photo = json["photo"],
        bvn = json["bvn"],
        residentialAddress = json["residentialAddress"];
}