import 'package:invest_naija/business_logic/data/response/response_model.dart';

class BanksResponseModel extends ResponseModel{

  BanksResponseModel();

  List<BankResponseModel> data;
  BanksResponseModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    var list = json['data'] as List;
    data = list == null ? [] : list.map((i) => BankResponseModel.fromJson(i)).toList();
  }
}

class BankResponseModel{
  bool active;
  String code;
  String country;
  String createdAt;
  String currency;
  String gateway;
  int id;
  bool isDeleted;
  String longCode;
  String name;
  bool payWithBank;
  String slug;
  String type;
  String updatedAt;

  BankResponseModel.fromJson(Map<String, dynamic> json) :
        active = json["active"],
        code = json["code"],
        country = json["country"],
        createdAt = json["createdAt"],
        currency = json["currency"],
        gateway = json["gateway"],
        id =  json["id"],
        isDeleted = json["is_deleted"],
        longCode = json["longcode"],
        name = json["name"],
        payWithBank = json["pay_with_bank"],
        slug = json["slug"],
        type = json["type"],
        updatedAt = json["updatedAt"];
}