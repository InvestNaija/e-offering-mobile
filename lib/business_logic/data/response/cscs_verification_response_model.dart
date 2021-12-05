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
  String broker;
  String chn;

  CscsResponse.fromJson(Map<String, dynamic> json){
    try{
      bvnResponse = json['bvnResponse'];
      cscsNo = json['cscsNo'];
      cscsResponse = json['cscsResponse']["accountName"];
      broker = json['cscsResponse']["broker"];
      chn = json['cscsResponse']["chn"];
    }catch(ex){
      bvnResponse = '';
      cscsNo = '';
      cscsResponse = 'CSCS/CHN Number combination is not valid';
      broker = '';
      chn = '';
    }
  }

}