import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:invest_naija/business_logic/data/response/error_response.dart';
import 'package:invest_naija/business_logic/data/response/payment_url_response.dart';
import 'dart:convert' as convert;
import 'package:invest_naija/business_logic/data/response/response_model.dart';
import 'api_util.dart';
import 'local/local_storage.dart';

class PaymentRepository{

  Future<ResponseModel> verifyBankAccount({String bankCode, String nuban}) async {
    try {
      Response response = await http.post(
          Uri.parse('${baseUrl}reservations/make-payment'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': appLocalStorage.getToken(),
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
      return ResponseModel.fromJson(jsonResponse);
    } on Exception catch (exception) {
      String response = exception is IOException
          ? "You are not connected to internet"
          : 'The connection has timed out, Please try again!';
      return ResponseModel()..error = ErrorResponse(message: response);
    }
  }

  Future<PaymentUrlResponse> getPaymentUrl({String reservationId, String gateway}) async {
    try {
      Response response = await http.post(
          Uri.parse('${baseUrl}reservations/make-payment'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': appLocalStorage.getToken(),
          },
          body: convert.jsonEncode(
              { "reservationId": reservationId,
                "gateway": gateway
              })
      ).timeout(const Duration(seconds: 60), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });
      var jsonResponse = convert.jsonDecode(response.body);
      return PaymentUrlResponse.fromJson(jsonResponse);
    } on Exception catch (exception) {
      String response = exception is IOException
          ? "You are not connected to internet"
          : 'The connection has timed out, Please try again!';
      return PaymentUrlResponse()..error = ErrorResponse(message: response);
    }
  }
}