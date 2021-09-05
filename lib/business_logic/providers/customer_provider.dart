import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invest_naija/business_logic/data/response/customer_response_model.dart';
import 'package:invest_naija/business_logic/data/response/login_response_model.dart';
import 'package:invest_naija/business_logic/data/response/response_model.dart';
import 'package:invest_naija/business_logic/repository/auth_repository.dart';
import 'package:invest_naija/business_logic/repository/local/local_storage.dart';

class CustomerProvider extends ChangeNotifier{
  CustomerResponseModel user = CustomerResponseModel();
  bool loading = false;
  int currentPage = 0;

  bool isFetchingCustomersDetails = false;
  bool isChangingPassword = false;

  Future<CustomerResponseModel> getCustomerFromLocalStorage() async{
    user = appLocalStorage.getCustomer();
    notifyListeners();
    return user;
  }

  Future<bool> hasCscs() async{
    user = appLocalStorage.getCustomer();
    bool hasCscs = user?.cscs?.isNotEmpty ?? false;
    bool hasCscsRef = user?.cscsRef?.isNotEmpty ?? false;
    return hasCscs || hasCscsRef ?? false;
  }

  Future<bool> hasNuban() async{
    user = appLocalStorage.getCustomer();
    return user?.nuban?.isNotEmpty ?? false;
  }

  void changePage(int index){
    currentPage = index;
    notifyListeners();
  }

  Future<ResponseModel> changePassword({String confirmNewPassword, String newPassword, String oldPassword}) async{
    isChangingPassword = true;
    notifyListeners();

    ResponseModel responseModel = await AuthRepository().changePassword(
        confirmNewPassword: confirmNewPassword,
        newPassword: newPassword,
        oldPassword: oldPassword);

    isChangingPassword = false;
    notifyListeners();

    return responseModel;
  }

  Future<bool> checkLoginStatus() async{
    return appLocalStorage.getLoggedInStatus() ?? false;
  }


  Future<ResponseModel> updateProfileImage({String imageBase64}) async{
    return await AuthRepository().uploadProfilePicture(imageBase64: imageBase64);
  }

  getCustomerDetailsSilently() async{
    LoginResponseModel responseModel =  await AuthRepository().fetchCustomerData();
    if(responseModel.error == null && responseModel.data != null){
      await appLocalStorage.saveCustomer(responseModel.data);
      user = responseModel.data;
      notifyListeners();
    }
  }

  Future<LoginResponseModel> getCustomerDetails() async{
    isFetchingCustomersDetails = false;
    notifyListeners();

    LoginResponseModel responseModel =  await AuthRepository().fetchCustomerData();
    if(responseModel.error == null && responseModel.data != null){
      await appLocalStorage.saveCustomer(responseModel.data);
      user = responseModel.data;
      notifyListeners();
    }

    isFetchingCustomersDetails = false;
    notifyListeners();

    return responseModel;
  }

  Future<String> getBase64FromFile(XFile image) async {
    List<int> imageBytes = await image.readAsBytes();
    return 'data:image/jpeg;base64,${base64Encode(imageBytes)}';
  }

  Future<String> getBase64FromPickedFile(PickedFile image) async {
    List<int> imageBytes = await image.readAsBytes();
    return 'data:image/jpeg;base64,${base64Encode(imageBytes)}';
  }

  String getInitialMessage(CustomerResponseModel user) {
    bool cssIsEmpty = user?.cscs?.isEmpty ?? true;
    bool nubanIsEmpty = user?.nuban?.isEmpty ?? true;

    if(cssIsEmpty || nubanIsEmpty) return 'Please update your Cscs and Bank account details.';

    if(cssIsEmpty) return 'Please update your cscs details.';

    return 'Please update your banking details.';
  }
}