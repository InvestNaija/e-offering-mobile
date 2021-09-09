import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:invest_naija/business_logic/data/response/banks_response_model.dart';
import 'package:invest_naija/business_logic/data/response/customer_response_model.dart';
import 'package:invest_naija/business_logic/data/response/response_model.dart';
import 'package:invest_naija/business_logic/data/response/verify_bank_account_response_model.dart';
import 'package:invest_naija/business_logic/repository/local/local_storage.dart';
import 'package:invest_naija/business_logic/repository/utility_repository.dart';

class BankProvider extends ChangeNotifier{
  bool bankAccountVerified = false;
  bool verifyingBankAccount = false;
  String verifiedAccountName = '';
  String bankName = '';
  String nuban = '';
  List<BankResponseModel> banks = [];
  BankResponseModel selectedBank;
  bool isUpdatingBankDetail = false;

  void getListOfBanks() async{
    BanksResponseModel banksResponseModel = await UtilityRepository().getBanks();
    if(banksResponseModel.status.toLowerCase() == 'success') {
      banks = banksResponseModel.data;
    }else{
      banks = [];
    }
    notifyListeners();
  }

  void verifyBankAccount({String bankCode, String nuban}) async{
    this.nuban = nuban;
    this.verifyingBankAccount = true;
    notifyListeners();

    VerifyBankAccountResponseModel verifyBankAccountResponseModel = await UtilityRepository().verifyBankAccount(
        bankCode: bankCode,
        nuban: nuban
    );
    if(verifyBankAccountResponseModel.error == null){
      bankAccountVerified = true;
      verifiedAccountName = verifyBankAccountResponseModel.data.accountName;
    }else{
      verifiedAccountName = 'No account found';
    }

    verifyingBankAccount = false;
    notifyListeners();
  }

  Future<ResponseModel> updateBankDetail({String bankAccountName,
    String bankCode,
    String bankName,
    String password,
    String nuban}) async{

    isUpdatingBankDetail = true;
    notifyListeners();

    ResponseModel responseModel = await UtilityRepository().updateBankDetail(
        bankAccountName: verifiedAccountName,
        bankCode: bankCode,
        bankName: bankName,
        password: password,
        nuban: nuban
    );

    if(responseModel.error == null){
      saveBankDetailsToSharedPreference(bankName: bankName, bankAccountName: bankAccountName, nuban:  nuban);
    }

    isUpdatingBankDetail = false;
    notifyListeners();

    return responseModel;
  }

  void getSelectedBank({String bankName}) async{
    selectedBank = banks.firstWhere((bank) => bank.name == bankName);
    notifyListeners();
  }

  void saveBankDetailsToSharedPreference({String bankAccountName, String bankName, String nuban}) async{
    CustomerResponseModel user = appLocalStorage.getCustomer();
    user.nuban = nuban;
    user.bankName = bankName;
    user.bankAccountName = bankAccountName;
    await appLocalStorage.saveCustomer(user);
  }

  void getBankDetailsFromSharedPreference() async{
    CustomerResponseModel user = appLocalStorage.getCustomer();
    this.verifiedAccountName = user.bankAccountName ?? '';
    this.bankName = user.bankName ?? '';
    this.nuban = user.nuban ?? '';
    notifyListeners();
  }
}