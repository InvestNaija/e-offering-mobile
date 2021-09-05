import 'package:flutter/foundation.dart';
import 'package:image_picker_platform_interface/src/types/picked_file/unsupported.dart';
import 'package:invest_naija/business_logic/data/response/response_model.dart';
import 'package:invest_naija/business_logic/repository/document_repository.dart';

class ProofOfSignatureDocumentProvider extends ChangeNotifier{

  var selectedProofOfSignature;
  bool isUploadingProofOfSignature = false;
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
    selectedProofOfSignature = documentType;
    notifyListeners();
  }

  Future<ResponseModel> uploadProofOfId(String imagePath, String docType, docNo) async{

    if(imagePath.isEmpty) return null;

    isUploadingProofOfSignature = true;
    notifyListeners();

    Map<String, String> parseValue = getParseValue(docType);
    ResponseModel responseModel = await DocumentRepository().uploadDocument(
        filePath: imagePath,
        key: parseValue['documentName'],
        identityName: parseValue['numberIdentifier'],
        identityNo: docNo
    );
    isUploadingProofOfSignature = false;
    notifyListeners();
    return responseModel;
  }

  Map<String, String> getParseValue(String documentType){
    return {'documentName' : 'signature;signature',  'numberIdentifier' : 'signatureNo;signature'};
  }
}