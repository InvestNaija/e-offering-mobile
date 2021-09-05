import 'dart:convert';

import 'package:invest_naija/business_logic/data/response/customer_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'local_storage_repository.dart';

LocalStorage appLocalStorage;

class LocalStorage implements LocalStorageRepository{

  static SharedPreferences localStorage;

  static Future<LocalStorage> init() async{
    localStorage = await SharedPreferences.getInstance();
    return LocalStorage();
  }

  @override
  Future<bool> saveToken(String token) async{
    return await localStorage.setString("token", token);
  }

  @override
  String getToken() {
    return localStorage.getString("token");
  }

  @override
  Future<bool> saveCustomer(CustomerResponseModel customer) async{
    return await localStorage.setString("customer", json.encode(customer));
  }

  @override
  Future<bool> setLoggedInStatus(bool isLoggedIn) async{
    return await localStorage.setBool("isLoggedIn", isLoggedIn);
  }

  @override
  bool getLoggedInStatus() {
    return localStorage.getBool("isLoggedIn");
  }

  @override
  Future<bool> clear() async{
    return localStorage.clear();
  }

  @override
  CustomerResponseModel getCustomer() {
    String jsonCustomer = localStorage.getString("customer");
    Map<String, dynamic> decodedMap = json.decode(jsonCustomer);
    return CustomerResponseModel.fromJson(decodedMap);
  }
}