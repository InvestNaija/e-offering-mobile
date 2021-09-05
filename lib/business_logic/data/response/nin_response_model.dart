import 'error_response.dart';

class NinResponseModel{

  int code;
  String status;
  User data;
  ErrorResponse error;

  NinResponseModel();

  NinResponseModel.fromJson(Map<String, dynamic> json) :
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
  String nationality;
  String photo;
  String nin;
  String profession;
  String title;
  String height;
  String birthCountry;
  NextOfKin nextOfKin;
  Residence residence;
  String signature;

  User.fromJson(Map<String, dynamic> json) :
        firstname =  json["firstname"],
        lastname = json["lastname"],
        middlename = json["middlename"],
        email = json["email"],
        gender = json["gender"],
        phone = json["phone"],
        birthdate = json["birthdate"],
        nationality = json["nationality"],
        photo = json["photo"],
        nin = json["nin"],
        profession = json["profession"],
        title = json["title"],
        height = json["height"],
        birthCountry = json["birthCountry"],
        nextOfKin = NextOfKin.fromJson(json["nextOfKin"]),
        residence = Residence.fromJson(json["residence"]),
        signature = json["signature"];
}

class NextOfKin{
  String firstname;
  String lastname;
  String address1;
  String address2;
  String lga;
  String state;
  String town;

  NextOfKin.fromJson(Map<String, dynamic> json) :
        firstname =  json["firstname"],
        lastname = json["lastname"],
        address1 = json["address1"],
        address2 = json["address2"],
        lga = json["lga"],
        town = json["town"],
        state = json["state"];
}

class Residence{
  String address1;
  String lga;
  String state;

  Residence.fromJson(Map<String, dynamic> json) :
        address1 =  json["address1"],
        lga = json["lga"],
        state = json["state"];
}