import 'package:flutter/foundation.dart';
import 'package:invest_naija/business_logic/data/request/register_request_model.dart';
import 'package:invest_naija/business_logic/data/response/bvn_response_model.dart';
import 'package:invest_naija/business_logic/data/response/nin_response_model.dart';
import 'package:invest_naija/business_logic/data/response/response_model.dart';
import 'package:invest_naija/business_logic/repository/auth_repository.dart';
import 'package:invest_naija/business_logic/data/response/register_response_model.dart';

class RegisterProvider extends ChangeNotifier{

  bool isLoading = false;
  bool resendingOtp = false;

  Future<NinResponseModel> checkNin({String firstName, String lastName, String nin}) async{
    isLoading = true;
    notifyListeners();

    NinResponseModel checkNinResponseModel = await AuthRepository().checkNin(
      firstName: firstName,
      lastName: lastName,
      nin: nin
    );

    isLoading = false;
    notifyListeners();

    return checkNinResponseModel;
  }


  Future<BvnResponseModel> checkBvn({String bvn, String dob}) async{
    isLoading = true;
    notifyListeners();

    BvnResponseModel checkBvnResponseModel = await AuthRepository().checkBvn(
        bvn: bvn,
        dob: dob
    );

    isLoading = false;
    notifyListeners();

    return checkBvnResponseModel;
  }


  Future<RegisterResponseModel> registerUser(RegisterRequestModel registerRequestModel) async {

    registerRequestModel.gender = registerRequestModel.gender == "m" ? "Male" : "Female";

    isLoading = true;
    notifyListeners();

    RegisterResponseModel registerResponseModel = await AuthRepository().registerUser(
        registerRequestModel: registerRequestModel,
    );

    isLoading = false;
    notifyListeners();

    return registerResponseModel;
  }


  Future<ResponseModel> confirmOtp({String email, String otp}) async {
    isLoading = true;
    notifyListeners();

    ResponseModel responseModel = await AuthRepository().verifyOtp(
        email : email,
        password: '',
        loading : true,
        otp : otp
    );

    isLoading = false;
    notifyListeners();

    return responseModel;
  }

  Future<ResponseModel> resendOtp({String email}) async{
      resendingOtp = true;
      notifyListeners();
      ResponseModel responseModel = await AuthRepository().resendOtp(email: email);

      resendingOtp = false;
      notifyListeners();

      return responseModel;
  }
}