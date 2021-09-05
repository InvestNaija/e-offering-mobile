import 'package:flutter/foundation.dart';
import 'package:image_picker_platform_interface/src/types/picked_file/unsupported.dart';
import 'package:invest_naija/business_logic/data/response/response_model.dart';
import 'package:invest_naija/business_logic/repository/document_repository.dart';

class ProofOfAddressDocumentProvider extends ChangeNotifier{

  var selectedProofOfAddress;
  bool isUploadingProofOfAddress = false;
  String selectedFilePath = '';

  void onImageSelected(String filePath){
    selectedFilePath = filePath;
    notifyListeners();
  }

  void removeImage(){
    selectedFilePath = '';
    notifyListeners();
  }

  void onProofOfAddressSelected(var documentType){
    selectedProofOfAddress = documentType;
    notifyListeners();
  }

  Future<ResponseModel> uploadProofOfAddress(String imagePath, String docType, docNo) async{

    if(imagePath.isEmpty) return null;

    isUploadingProofOfAddress = true;
    notifyListeners();

    Map<String, String> parseValue = getParseValue(docType);
    ResponseModel responseModel = await DocumentRepository().uploadDocument(
        filePath: imagePath,
        key: parseValue['documentName'],
        identityName: parseValue['numberIdentifier'],
        identityNo: docNo
    );
    isUploadingProofOfAddress = false;
    notifyListeners();
    return responseModel;

  }

  Map<String, String> getParseValue(String documentType){
    switch(documentType){
      case 'International Passport' : {
        return {'documentName' : 'profOfAddress;passport',  'numberIdentifier' : 'profOfAddressNo;passport'};
      }
      case 'Driver Licence' : {
        return {'documentName' : 'profOfAddress;driverLicense', 'numberIdentifier' : 'profOfAddressNo;driverLicense' };
      }
      case 'Utility Bill' : {
        return {'documentName':'profOfAddress;utility', 'numberIdentifier':'profOfAddressNo;utility'};
      }
      case 'National Identification Card' : {
        return {'documentName':'profOfAddress;nationalId', 'numberIdentifier':'profOfIdNo;nationalId'};
      }
      default : {
        return {'documentName' : 'profOfAddress;nationalId',  'numberIdentifier' : 'profOfIdNo;nationalId'};
      }
    }
  }
}