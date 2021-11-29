import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:invest_naija/business_logic/data/response/brokers_list_response_model.dart';
import 'package:invest_naija/business_logic/data/response/error_response.dart';
import 'dart:convert' as convert;
import 'api_util.dart';
import 'local/local_storage.dart';

class BrokersRepository{
  Future<BrokersListResponseModel> getBrokers() async {
    print('Authorization ${appLocalStorage.getToken()}');
    try{
      Response response =  await http.get(
        Uri.parse('${baseUrl}brokers?type=broker'),
        headers: <String, String>{
          'Authorization': appLocalStorage.getToken(),
        },
      ).timeout(const Duration(seconds: 60), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });
      var jsonResponse = convert.jsonDecode(response.body);
      return BrokersListResponseModel.fromJson(jsonResponse);
    } on Exception catch (exception) {
      String response = exception is IOException
          ? "You are not connected to internet"
          : 'The connection has timed out, Please try again!';
      return BrokersListResponseModel()..error = ErrorResponse(message: response);
    }
  }
}