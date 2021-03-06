import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:invest_naija/business_logic/data/response/error_response.dart';
import 'package:invest_naija/business_logic/data/response/response_model.dart';
import 'dart:convert' as convert;
import 'package:invest_naija/business_logic/data/response/transaction_list_response_model.dart';
import 'api_util.dart';
import 'local/local_storage.dart';

class TransactionRepository{
  Future<TransactionListResponseModel> getTransactions() async {
    print('Authorization ${appLocalStorage.getToken()}');
    try{
    Response response =  await http.get(
      Uri.parse('${baseUrl}reservations/my-reservations'),
      headers: <String, String>{
        'Authorization': appLocalStorage.getToken(),
      },
    ).timeout(const Duration(seconds: 60), onTimeout: () {
      throw TimeoutException(
          'The connection has timed out, Please try again!');
    });
    var jsonResponse = convert.jsonDecode(response.body);
    return TransactionListResponseModel.fromJson(jsonResponse);
    } on Exception catch (exception) {
      String response = exception is IOException
          ? "You are not connected to internet"
          : 'The connection has timed out, Please try again!';
      return TransactionListResponseModel()..error = ErrorResponse(message: response);
    }
  }

  Future<ResponseModel> deleteTransaction(String id) async {
    print('Authorization ${appLocalStorage.getToken()}');
    try{
      Response response =  await http.delete(
        Uri.parse('${baseUrl}reservations/cancel/$id'),
        headers: <String, String>{
          'Authorization': appLocalStorage.getToken(),
        },
      ).timeout(const Duration(seconds: 60), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });
      print(response.body);
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