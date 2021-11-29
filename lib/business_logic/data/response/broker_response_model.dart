class BrokerResponseModel{

  String id;
  String name;
  String email;
  String phoneNumber;
  String code;
  String organizationType;
  String address;
  bool verified;
  String lastLoginDate;
  String createdAt;
  String updatedAt;
  String deletedAt;

  BrokerResponseModel.fromJson(Map<String, dynamic> json){
    id = json["id"];
    name = json["name"] ?? "";
    email  = json["email"];
    phoneNumber  = json["phoneNumber"];
    code = json["code"];
    organizationType = json["organizationType"];
    address = json["address"];
    verified = json["verified"];
    lastLoginDate = json["lastLoginDate"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    deletedAt = json["deletedAt"];
  }
}