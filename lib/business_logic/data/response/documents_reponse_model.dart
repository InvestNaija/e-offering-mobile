import 'package:invest_naija/business_logic/data/response/data/document_data.dart';
import 'package:invest_naija/business_logic/data/response/response_model.dart';

class DocumentsResponseModel extends ResponseModel{
  List<DocumentData> data;

  DocumentsResponseModel();

  DocumentsResponseModel.fromJson(Map<String, dynamic> json): super.fromJson(json){
   if(json['data'] != null){
     var jsonList = json['data'] as List;
     data = jsonList.map((document) => DocumentData.fromJson(document)).toList();
   }else{
     data = [];
   }
  }
}