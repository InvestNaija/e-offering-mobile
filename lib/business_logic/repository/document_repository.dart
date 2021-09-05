import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:invest_naija/business_logic/data/response/documents_reponse_model.dart';
import 'dart:io';
import 'dart:convert' as convert;
import 'package:invest_naija/business_logic/data/response/error_response.dart';
import 'package:invest_naija/business_logic/data/response/response_model.dart';

import 'api_util.dart';
import 'local/local_storage.dart';

class DocumentRepository {
  Future<ResponseModel> uploadDocument({String filePath,String key, String identityName, String identityNo}) async {
   try{
     http.MultipartRequest request = http.MultipartRequest('POST',
         Uri.parse('${baseUrl}customers/upload-kyc-documents'));
     request.headers['Authorization'] = appLocalStorage.getToken();
     request.files.add( await http.MultipartFile.fromPath(key, filePath));
     request.fields[identityName] = identityNo;
     StreamedResponse response = await request.send();
     ResponseModel responseModel;
     await response.stream.transform(convert.utf8.decoder).firstWhere((value) {
       var jsonResponse = convert.jsonDecode(value);
       responseModel = ResponseModel.fromJson(jsonResponse);
       return true;
     });
     return responseModel;
   }on Exception catch (exception) {
     String response = exception is IOException
         ? "You are not connected to internet"
         : 'The connection has timed out, Please try again!';
     return ResponseModel()..error = ErrorResponse(message: response);
   }
  }

  Future<DocumentsResponseModel> getAllUsersDocument() async {
    try{
      Response response =  await http.get(
        Uri.parse('${baseUrl}customers/documents/kyc'),
        headers: <String, String>{
          'Authorization': appLocalStorage.getToken(),
        },
      ).timeout(const Duration(seconds: 60), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });
      var jsonResponse = convert.jsonDecode(response.body);
      return DocumentsResponseModel.fromJson(jsonResponse);
    } on Exception catch (exception) {
      String response = exception is IOException
          ? "You are not connected to internet"
          : 'The connection has timed out, Please try again!';
      return DocumentsResponseModel()..error = ErrorResponse(message: response);
    }
  }
}
