import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:invest_naija/business_logic/data/response/banks_response_model.dart';
import 'package:invest_naija/business_logic/data/response/error_response.dart';
import 'dart:convert' as convert;
import 'package:invest_naija/business_logic/data/response/response_model.dart';
import 'package:invest_naija/business_logic/data/response/verify_bank_account_response_model.dart';
import 'api_util.dart';
import 'local/local_storage.dart';

class UtilityRepository{
  Future<BanksResponseModel> getBanks() async {
    try{
    Response response =  await http.get(Uri.parse('https://griffin-be.herokuapp.com/api/v1/transactions/banks'),)
        .timeout(const Duration(seconds: 60), onTimeout: () {
      throw TimeoutException(
          'The connection has timed out, Please try again!');
    });
    var jsonResponse = convert.jsonDecode(response.body);
    return BanksResponseModel.fromJson(jsonResponse);
    } on Exception catch (exception) {
      String response = exception is IOException
          ? "You are not connected to internet"
          : 'The connection has timed out, Please try again!';
      return BanksResponseModel()..error = ErrorResponse(message: response)
      ..status = 'Failed';
    }
  }

  Future<VerifyBankAccountResponseModel> verifyBankAccount({String bankCode, String nuban}) async {
    try {
      Response response = await http.post(
          Uri.parse(
              '${baseUrl}verifications/bank-account'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: convert.jsonEncode(
              { "bank_code": bankCode,
                "nuban": nuban
              })
      ).timeout(const Duration(seconds: 60), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });
      var jsonResponse = convert.jsonDecode(response.body);
      return VerifyBankAccountResponseModel.fromJson(jsonResponse);
    } on Exception catch (exception) {
      String response = exception is IOException
          ? "You are not connected to internet"
          : 'The connection has timed out, Please try again!';
      return ResponseModel()..error = ErrorResponse(message: response);
    }
  }

  Future<ResponseModel> updateBankDetail({String bankAccountName,
    String bankCode,
    String bankName,
    String password,
    String nuban}) async {

    try{
    var map = { 'bankAccountName': bankAccountName,
      'bankCode': bankCode,
      'bankName': bankName,
      'nuban': nuban,
      'password' : password
    };

    Response response =  await http.patch(
        Uri.parse('${baseUrl}customers/update-bank-details'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': appLocalStorage.getToken(),
        },
        body: convert.jsonEncode(map)
    ).timeout(const Duration(seconds: 60), onTimeout: () {
      throw TimeoutException(
          'The connection has timed out, Please try again!');
    });
    var jsonResponse = convert.jsonDecode(response.body);
    return ResponseModel.fromJson(jsonResponse);
    } on Exception catch (exception) {
      String response = exception is IOException
          ? "You are not connected to internet"
          : 'The connection has timed out, Please try again!';
      return ResponseModel()..error = ErrorResponse(message: response);
    }
  }
}