import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:invest_naija/business_logic/data/request/register_request_model.dart';
import 'package:invest_naija/business_logic/data/response/bvn_response_model.dart';
import 'package:invest_naija/business_logic/data/response/error_response.dart';
import 'dart:convert' as convert;
import 'package:invest_naija/business_logic/data/response/login_response_model.dart';
import 'package:invest_naija/business_logic/data/response/nin_response_model.dart';
import 'package:invest_naija/business_logic/data/response/register_response_model.dart';
import 'package:invest_naija/business_logic/data/response/response_model.dart';
import 'package:invest_naija/business_logic/repository/api_util.dart';
import 'package:invest_naija/business_logic/repository/local/local_storage.dart';

class AuthRepository {
  Future<LoginResponseModel> login({String email, String password}) async {
    try {
      Response response = await http
          .post(
              Uri.parse(
                  '${baseUrl}auth/customers/login'),
              headers: <String, String>{
                'Content-Type': 'application/json',
              },
              body: convert.jsonEncode(
                  {'email': email, 'password': password, 'loading': true}))
          .timeout(const Duration(seconds: 60), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });
      if(response.statusCode == 411){
        return LoginResponseModel()
          ..error = ErrorResponse(message: "You are not connected to internet")
          ..code = 411;
      }
      var jsonResponse = convert.jsonDecode(response.body);
      return LoginResponseModel.fromJson(jsonResponse);
    } on Exception catch (exception) {
      if (exception is IOException) {
        return LoginResponseModel()
          ..error = ErrorResponse(message: "You are not connected to internet");
      } else if (exception is TimeoutException) {
        return LoginResponseModel()
          ..error = ErrorResponse(message: exception.message);
      } else {
        return LoginResponseModel()
          ..error = ErrorResponse(message: "Oops! an error occurred");
      }
    }
  }

  Future<ResponseModel> resetPassword({String email}) async {
    try {
      Response response = await http.post(
          Uri.parse(
              '${baseUrl}auth/customers/forgot-password'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: convert
              .jsonEncode({'email': email, 'password': '', 'loading': true}))
          .timeout(const Duration(seconds: 60), onTimeout: () {
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

  Future<NinResponseModel> checkNin({String firstName, String lastName, String nin}) async {
    try {
      Response response = await http.post(
          Uri.parse(
              '${baseUrl}verifications/nin'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: convert.jsonEncode(
              {'firstName': firstName, 'lastName': lastName, 'nin': nin}))
          .timeout(const Duration(seconds: 60), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });
      var jsonResponse = convert.jsonDecode(response.body);
      return NinResponseModel.fromJson(jsonResponse);
    } on Exception catch (exception) {
      String response = exception is IOException
          ? "You are not connected to internet"
          : 'The connection has timed out, Please try again!';
      return NinResponseModel()..error = ErrorResponse(message: response);
    }
  }

  Future<BvnResponseModel> checkBvn({String bvn, String dob}) async {
    try {
      Response response = await http.post(
          Uri.parse(
              '${baseUrl}verifications/bvn'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: convert.jsonEncode(
              {'bvn': bvn, 'dob': dob}))
          .timeout(const Duration(seconds: 60), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });
      var jsonResponse = convert.jsonDecode(response.body);
      return BvnResponseModel.fromJson(jsonResponse);
    } on Exception catch (exception) {
      String response = exception is IOException
          ? "You are not connected to internet"
          : 'The connection has timed out, Please try again!';
      return BvnResponseModel()..error = ErrorResponse(message: response);
    }
  }

  Future<RegisterResponseModel> registerUser({RegisterRequestModel registerRequestModel}) async {
    try {
      Response response = await http.post(
          Uri.parse(
              '${baseUrl}auth/customers/signup'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: convert.jsonEncode(registerRequestModel.toJson()))
          .timeout(const Duration(seconds: 60), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });
      var jsonResponse = convert.jsonDecode(response.body);
      return RegisterResponseModel.fromJson(jsonResponse);
    } on Exception catch (exception) {
      String response = exception is IOException
          ? "You are not connected to internet"
          : 'The connection has timed out, Please try again!';
      return RegisterResponseModel()..error = ErrorResponse(message: response);
    }
  }

  Future<ResponseModel> verifyOtp({String email, String password, bool loading, String otp}) async {
    try {
      Response response = await http.post(
          Uri.parse(
              '${baseUrl}auth/customers/verify-otp'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: convert.jsonEncode({
            'email': email,
            'password': password,
            'loading': loading,
            'otp': otp
          })).timeout(const Duration(seconds: 60), onTimeout: () {
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

  Future<ResponseModel> changePassword(
      {String confirmNewPassword,
      String newPassword,
      String oldPassword}) async {
    try {
      Response response = await http.post(
          Uri.parse(
              '${baseUrl}auth/customers/change-password'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': appLocalStorage.getToken(),
          },
          body: convert.jsonEncode({
            'confirmNewPassword': confirmNewPassword,
            'newPassword': newPassword,
            'loading': false,
            'oldPassword': oldPassword
          })).timeout(const Duration(seconds: 60), onTimeout: () {
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


  Future<LoginResponseModel> fetchCustomerData() async {
    try {
      Response response = await http.get(
          Uri.parse('${baseUrl}customers/profile/fetch'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': appLocalStorage.getToken(),
          }).timeout(const Duration(seconds: 60), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });
      var jsonResponse = convert.jsonDecode(response.body);
      return LoginResponseModel.fromJson(jsonResponse);
    } on Exception catch (exception) {
      String response = exception is IOException
          ? "You are not connected to internet"
          : 'The connection has timed out, Please try again!';
      return LoginResponseModel()..error = ErrorResponse(message: response);
    }
  }


  Future<ResponseModel> uploadProfilePicture({String imageBase64}) async {
    try {
      Response response = await http
          .patch(
          Uri.parse('${baseUrl}customers/update-avatar'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': appLocalStorage.getToken(),
          },
          body: convert.jsonEncode({'image': imageBase64}))
          .timeout(const Duration(seconds: 60), onTimeout: () {
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

  Future<ResponseModel> resendOtp({String email}) async{
    try {
      Response response = await http.post(
          Uri.parse(
              '${baseUrl}auth/customers/resend-otp'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: convert.jsonEncode({'email': email,}))
          .timeout(const Duration(seconds: 60), onTimeout: () {
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
