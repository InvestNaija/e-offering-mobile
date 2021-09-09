import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:invest_naija/business_logic/data/response/cscs_verification_response_model.dart';
import 'package:invest_naija/business_logic/data/response/error_response.dart';
import 'package:invest_naija/business_logic/data/response/express_interest_response_model.dart';
import 'package:invest_naija/business_logic/data/response/response_model.dart';
import 'dart:convert' as convert;
import 'package:invest_naija/business_logic/data/response/shares_list_response_model.dart';
import 'api_util.dart';
import 'local/local_storage.dart';

class InvestmentRepository{

  Future<ResponseModel> getEIpoShares() async {

    try{
    Response response =  await http.get(
        Uri.parse('${baseUrl}assets'),
    ).timeout(const Duration(seconds: 60), onTimeout: () {
      throw TimeoutException(
          'The connection has timed out, Please try again!');
    });
       var jsonResponse = convert.jsonDecode(response.body);
       return SharesListResponseModel.fromJson(jsonResponse);
    } on Exception catch (exception) {
      String response = exception is IOException
          ? "You are not connected to internet"
          : 'The connection has timed out, Please try again!';
      return SharesListResponseModel()..error = ErrorResponse(message: response)
       ..status = 'Failed';
    }
  }

  Future<SharesListResponseModel> getTopAssets() async {
    try{
    Response response =  await http.get(
      Uri.parse('${baseUrl}assets/top-assets'),
    ).timeout(const Duration(seconds: 60), onTimeout: () {
      throw TimeoutException(
          'The connection has timed out, Please try again!');
    });
    var jsonResponse = convert.jsonDecode(response.body);
    return SharesListResponseModel.fromJson(jsonResponse);
    } on Exception catch (exception) {
      String response = exception is IOException
          ? "You are not connected to internet"
          : 'The connection has timed out, Please try again!';
      return ResponseModel()..error = ErrorResponse(message: response);
    }
  }

  Future<SharesListResponseModel> getPopularAssets() async {
    try{
    Response response =  await http.get(
      Uri.parse('${baseUrl}assets/popular'),
    ).timeout(const Duration(seconds: 60), onTimeout: () {
      throw TimeoutException(
          'The connection has timed out, Please try again!');
    });
    var jsonResponse = convert.jsonDecode(response.body);
    return SharesListResponseModel.fromJson(jsonResponse);
    } on Exception catch (exception) {
      String response = exception is IOException
          ? "You are not connected to internet"
          : 'The connection has timed out, Please try again!';
      return SharesListResponseModel()..error = ErrorResponse(message: response);
    }
  }

  Future<ExpressInterestResponseModel> expressInterest({String assetId, int units, double amount}) async {
    try{
    Response response =  await http.post(
        Uri.parse('${baseUrl}reservations/express-interest'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': appLocalStorage.getToken(),
        },
        body: convert.jsonEncode({'assetId': assetId, 'units': units, 'amount' : amount})
    ).timeout(const Duration(seconds: 60), onTimeout: () {
      throw TimeoutException(
          'The connection has timed out, Please try again!');
    });
    var jsonResponse = convert.jsonDecode(response.body);
    return ExpressInterestResponseModel.fromJson(jsonResponse);
    } on Exception catch (exception) {
      String response = exception is IOException
          ? "You are not connected to internet"
          : 'The connection has timed out, Please try again!';
      return ExpressInterestResponseModel()..error = ErrorResponse(message: response)
          ..status = 'Failed';
    }
  }

  Future<CscsVerificationResponseModel> verifyCscs({String cscsNo}) async {
    try{
      Response response =  await http.post(
        Uri.parse('${baseUrl}mtn/customers/first-step'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': appLocalStorage.getToken(),
        },
        body: convert.jsonEncode(
        { 'cscsNo': cscsNo,
          'cscsNumber': '',
          'loading' : true,
        })
    ).timeout(const Duration(seconds: 60), onTimeout: () {
      throw TimeoutException(
          'The connection has timed out, Please try again!');
    });
    var jsonResponse = convert.jsonDecode(response.body);
    return CscsVerificationResponseModel.fromJson(jsonResponse);
    } on Exception catch (exception) {
      String response = exception is IOException
          ? "You are not connected to internet"
          : 'The connection has timed out, Please try again!';
      return CscsVerificationResponseModel()..error = ErrorResponse(message: response);
    }
  }

  Future<CscsVerificationResponseModel> uploadCscs({String cscsNo}) async {
    try{
      Response response =  await http.patch(
          Uri.parse('${baseUrl}verifications/cscs/no-verification'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': appLocalStorage.getToken(),
          },
          body: convert.jsonEncode(
              { 'cscsNo': cscsNo,})
      ).timeout(const Duration(seconds: 60), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });
      var jsonResponse = convert.jsonDecode(response.body);
      return CscsVerificationResponseModel.fromJson(jsonResponse);
    } on Exception catch (exception) {
      String response = exception is IOException
          ? "You are not connected to internet"
          : 'The connection has timed out, Please try again!';
      return CscsVerificationResponseModel()..error = ErrorResponse(message: response);
    }
  }

  Future<ResponseModel> createCscsAccount({String citizen, String city, String country, String maidenName, String postalCode}) async {
    try{
    Response response =  await http.post(
        Uri.parse('${baseUrl}customers/create-cscs'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': appLocalStorage.getToken(),
        },
        body: convert.jsonEncode(
            { 'Citizen': citizen == "Nigerian" ? "NG" : citizen,
              'City': city,
              'Country' : country == "Nigeria" ? "NG" : citizen,
              'MaidenName' : maidenName,
              'postalCode' : postalCode
            })
    ).timeout(const Duration(seconds: 60), onTimeout: () {
      throw TimeoutException(
          'The connection has timed out, Please try again!');
    });
    var jsonResponse = convert.jsonDecode(response.body);
    return ExpressInterestResponseModel.fromJson(jsonResponse);
    } on Exception catch (exception) {
      String response = exception is IOException
          ? "You are not connected to internet"
          : 'The connection has timed out, Please try again!';
      return ResponseModel()..error = ErrorResponse(message: response)
              ..status = 'Failed';
    }
  }
}