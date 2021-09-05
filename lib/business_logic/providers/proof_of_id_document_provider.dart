import 'package:flutter/foundation.dart';
import 'package:image_picker_platform_interface/src/types/picked_file/unsupported.dart';
import 'package:invest_naija/business_logic/data/response/response_model.dart';
import 'package:invest_naija/business_logic/repository/document_repository.dart';

class ProofOfIdDocumentProvider extends ChangeNotifier{

  var selectedProofOfId;
  bool isUploadingProofOfId = false;
  String selectedFilePath = '';

  void onImageSelected(String filePath){
    selectedFilePath = filePath;
    notifyListeners();
  }

  void removeImage(){
    selectedFilePath = '';
    notifyListeners();
  }

  void onProofOfIdSelected(var documentType){
    selectedProofOfId = documentType;
    notifyListeners();
  }

  Future<ResponseModel> uploadProofOfId(String imagePath, String docType, docNo) async{

    if(imagePath.isEmpty) return null;

    isUploadingProofOfId = true;
    notifyListeners();

    Map<String, String> parseValue = getParseValue(docType);
    ResponseModel responseModel = await DocumentRepository().uploadDocument(
        filePath: imagePath,
        key: parseValue['documentName'],
        identityName: parseValue['numberIdentifier'],
        identityNo: docNo
    );
    isUploadingProofOfId = false;
    notifyListeners();
    return responseModel;

  }

  Map<String, String> getParseValue(String documentType){
    switch(documentType){
      case 'International Passport' : {
        return {'documentName' : 'profOfId;passport',  'numberIdentifier' : 'profOfIdNo;passport'};
      }
      case 'Driver Licence' : {
        return {'documentName' : 'profOfId;driverLicense', 'numberIdentifier' : 'profOfIdNo;driverLicense' };
      }
      case 'National Identification Card' : {
        return {'documentName':'profOfId;nationalId', 'numberIdentifier':'profOfIdNo;nationalId'};
      }
      default : {
        return {'documentName' : 'profOfId;nationalId',  'numberIdentifier' : 'profOfIdNo;nationalId'};
      }
    }
  }
}