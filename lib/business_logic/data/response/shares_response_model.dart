class SharesResponseModel {
 String id;
 String description;
 String name;
 String type;
 int anticipatedMaxPrice;
 int anticipatedMinPrice;
 double sharePrice;
 int availableShares;
 bool openForPurchase;
 String closingDate;
 int popularity;
 String image;
 String createdAt;
 String updatedAt;
 String currency;

 SharesResponseModel.fromJson(Map<String, dynamic> json){
  id = json["id"];
  description = json["description"];
  name = json["name"];
  type = json["type"];
  anticipatedMaxPrice = json["anticipatedMaxPrice"];
  anticipatedMinPrice = json["anticipatedMinPrice"];
  sharePrice = json["sharePrice"] * 1.0;
  availableShares = json["availableShares"];
  openForPurchase = json["openForPurchase"];
  closingDate = json["closingDate"];
  popularity = json["popularity"];
  image = json["image"];
  currency = json['currency'];
  createdAt = json["createdAt"];
  updatedAt = json["updatedAt"];
 }
}