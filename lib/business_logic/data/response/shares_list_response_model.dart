import 'package:invest_naija/business_logic/data/response/response_model.dart';

import 'shares_response_model.dart';

class SharesListResponseModel extends ResponseModel{
  List<SharesResponseModel> data;

  SharesListResponseModel();

  SharesListResponseModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
      code = json["code"];
      status = json["status"];
      message = json["message"];

      var list = json['data'] as List;
      data = list.map((i) => SharesResponseModel.fromJson(i)).toList();
  }
}