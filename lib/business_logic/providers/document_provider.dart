import 'package:flutter/foundation.dart';
import 'package:image_picker_platform_interface/src/types/picked_file/unsupported.dart';
import 'package:invest_naija/business_logic/data/response/data/document_data.dart';
import 'package:invest_naija/business_logic/data/response/documents_reponse_model.dart';
import 'package:invest_naija/business_logic/data/response/response_model.dart';
import 'package:invest_naija/business_logic/repository/document_repository.dart';

class DocumentProvider extends ChangeNotifier{

  String profOfAddressNo = '';
  String profOfAddressImage = '';
  String profOfAddressDocumentType = '';

  String profOfIdNo  = '';
  String profOfIdImage = '';
  String profOfIdDocumentType = '';

  String signatureNo = '';
  String signatureImage = '';

  Future<DocumentsResponseModel> getSavedDocuments() async{
    DocumentsResponseModel response = await DocumentRepository().getAllUsersDocument();
    signatureNo = response.data.firstWhere((element) => element.name == 'signatureNo;signature', orElse: null)?.value ?? '';
    signatureImage = response.data.firstWhere((element) => element.name == 'signature;signature', orElse: null)?.value ?? '';

    profOfAddressNo = response.data.firstWhere((element) =>
    (element.name == 'profOfAddressNo;passport') || element.name == 'profOfAddressNo;driverLicense' || element.name == 'profOfAddressNo;utility' || element.name == 'profOfIdNo;nationalId', orElse: null)?.value ?? '';


    DocumentData profOfAddress = response.data.firstWhere((element) =>
    (element.name == 'profOfAddress;passport') || element.name == 'profOfAddress;driverLicense' || element.name == 'profOfAddress;utility' || element.name == 'profOfAddress;nationalId', orElse: null);
    profOfAddressImage = profOfAddress?.value ?? '';
    profOfAddressDocumentType = getDocumentType(profOfAddress?.name ?? '');

    profOfIdNo = response.data.firstWhere((element) =>
    (element.name == 'profOfIdNo;passport') || element.name == 'profOfIdNo;driverLicense' || element.name == 'profOfIdNo;nationalId', orElse: null)?.value ?? '';

    DocumentData profOfId = response.data.firstWhere((element) =>
    (element.name == 'profOfId;passport') || element.name == 'profOfId;driverLicense' || element.name == 'profOfId;nationalId', orElse: null);

    profOfIdImage = profOfId?.value ?? '';

    profOfIdDocumentType = getDocumentType(profOfId?.name ?? '');

    notifyListeners();
    return response;
  }

  String getDocumentType(String keyword){
    if(keyword.contains('passport')){
      return 'International Passport';
    }else if(keyword.contains('driverLicense')){
      return 'Driver License';
    }else if(keyword.contains('utility')){
      return 'Utility Bill';
    }else if (keyword.contains('nationalId')){
      return 'National Identity Card';
    }else{
      return 'No document selected';
    }
  }

  refreshImages() {
    Future.delayed(
        Duration(seconds: 5),
            ()=> this.getSavedDocuments()
    );
  }
}