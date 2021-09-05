import 'package:invest_naija/business_logic/data/response/response_model.dart';

class CscsVerificationResponseModel extends ResponseModel{
  CscsResponse data;
  CscsVerificationResponseModel();

  CscsVerificationResponseModel.fromJson(Map<String, dynamic> json) : super.fromJson(json){
    data = CscsResponse.fromJson(json['data']);
  }
}

class CscsResponse{
  String bvnResponse;
  String cscsNo;
  String cscsResponse;

  CscsResponse.fromJson(Map<String, dynamic> json){
    bvnResponse = json['bvnResponse'];
    cscsNo = json['cscsNo'];
    cscsResponse = json['cscsResponse'];
  }

}