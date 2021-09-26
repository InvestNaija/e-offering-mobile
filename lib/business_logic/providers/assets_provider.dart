import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:invest_naija/business_logic/data/response/cscs_verification_response_model.dart';
import 'package:invest_naija/business_logic/data/response/customer_response_model.dart';
import 'package:invest_naija/business_logic/data/response/express_interest_response_model.dart';
import 'package:invest_naija/business_logic/data/response/response_model.dart';
import 'package:invest_naija/business_logic/data/response/shares_list_response_model.dart';
import 'package:invest_naija/business_logic/data/response/shares_response_model.dart';
import 'package:invest_naija/business_logic/data/response/zannibal_response.dart';
import 'package:invest_naija/business_logic/repository/investment_repository.dart';
import 'package:invest_naija/business_logic/repository/local/local_storage.dart';

class AssetsProvider extends ChangeNotifier{

  bool isLoading = false;

  bool isLoadingTrendingShares = true;
  List<SharesResponseModel> trendingAssets = [];

  bool isLoadingEIpoAssets = true;
  List<SharesResponseModel> eIpoAssets = [];

  String verifiedName;
  bool cscsVerified = false;

  bool isCreatingCscs = false;
  bool isSavingReservation = false;
  bool isMakingReservation = false;

  void refreshPopularAssets(){
    isLoadingTrendingShares = true;
    notifyListeners();
    getPopularAssets();
  }

  void cancelReservation(){
    isMakingReservation = false;
    notifyListeners();
  }

  void getPopularAssets() async{
   try{
     SharesListResponseModel assets = await InvestmentRepository().getPopularAssets();
     if(assets.error == null && assets.status.toLowerCase() == 'success'){
       trendingAssets = assets.data.where((asset) => asset.type == 'ipo').toList();
     }
   }catch(exception){}
   isLoadingTrendingShares = false;
   notifyListeners();
  }

  void getEIpoAssets() async{
    SharesListResponseModel assets = await InvestmentRepository().getEIpoShares();
    if(assets.status.toLowerCase() == 'success') {
      eIpoAssets = assets.data.where((asset) => asset.type == 'ipo').toList();
    }else{
      eIpoAssets = [];
    }
    isLoadingEIpoAssets = false;
    notifyListeners();
  }

  Future<ExpressInterestResponseModel> payLater({String assetId, int units, double amount}) async{
    isSavingReservation = true;
    notifyListeners();
    var response = await expressInterest(assetId: assetId, units: units, amount: amount);
    isSavingReservation = false;
    notifyListeners();
    return response;
  }

  Future<ExpressInterestResponseModel> payNow({String assetId, int units, double amount}) async{
    isMakingReservation = true;
    notifyListeners();
    var response = await expressInterest(assetId: assetId, units: units, amount: amount);
    isMakingReservation = false;
    notifyListeners();
    return response;
  }

  Future<ResponseModel> updateReservation({String reservationId, double units, double amount}) async{
    isMakingReservation = true;
    notifyListeners();
    ResponseModel response = await InvestmentRepository()
        .updateInterest(reservationId: reservationId, units: units, amount: amount);
    isMakingReservation = false;
    notifyListeners();
    return response;
  }

  Future<ExpressInterestResponseModel> expressInterest({String assetId, int units, double amount}) async{
    ExpressInterestResponseModel expressInterestResponse = await InvestmentRepository()
         .expressInterest(assetId: assetId, units: units, amount: amount);
    return expressInterestResponse;
  }

  Future<ResponseModel> verifyCscs({String cscsNo}) async {
    isLoading = true;
    notifyListeners();
    CscsVerificationResponseModel response = await InvestmentRepository().verifyCscs(cscsNo: cscsNo);
    if(response.status.toLowerCase() =='success'){
      verifiedName = response.data.cscsResponse;
      cscsVerified = true;
    }else{
      cscsVerified = false;
    }
    isLoading = false;
    notifyListeners();
    return response;
  }

  Future<ResponseModel> uploadCscs({String cscsNo}) async {
    isLoading = true;
    notifyListeners();
    CscsVerificationResponseModel response = await InvestmentRepository().uploadCscs(cscsNo: cscsNo);
    if(response.status =='success'){
      verifiedName = '';
      cscsVerified = false;
      CustomerResponseModel user = appLocalStorage.getCustomer();
      user.cscs = cscsNo;
      await appLocalStorage.saveCustomer(user);
    }

    isLoading = false;
    notifyListeners();

    return response;
  }


  Future<ZannibalResponse> getSharePrice() async {
    ZannibalResponse zannibalResponse = await InvestmentRepository().getSharePrice();
    print('this it the juice------------');
    print(zannibalResponse.lastPrice);
    return zannibalResponse;
  }

  Future<ResponseModel> createCscsAccount({String citizen, String city, String country, String maidenName, String postalCode}) async {
    isCreatingCscs = true;
    notifyListeners();

    ResponseModel responseModel = await InvestmentRepository().createCscsAccount(
      citizen: citizen,
      city: city,
      country: country,
      maidenName: maidenName
    );

    isCreatingCscs = false;
    notifyListeners();

    return responseModel;
  }
}