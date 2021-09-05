import 'package:flutter/foundation.dart';
import 'package:invest_naija/business_logic/data/response/login_response_model.dart';
import 'package:invest_naija/business_logic/data/response/response_model.dart';
import 'package:invest_naija/business_logic/repository/auth_repository.dart';
import 'package:invest_naija/business_logic/repository/local/local_storage.dart';
import '../../main.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isResettingPassword = false;

  Future<LoginResponseModel> login({String email, String password}) async{

    isLoading = true;
    notifyListeners();

    LoginResponseModel response = await AuthRepository().login(email: email, password: password);
    if(response.error == null){
      await appLocalStorage.saveCustomer(response.data);
      await appLocalStorage.saveToken(response.token);
      await appLocalStorage.setLoggedInStatus(true);
    }

    isLoading = false;
    notifyListeners();

    return response;
  }

  Future<bool> logout() async{
    userIsInsideApp = false;
    return appLocalStorage.clear();
  }


  Future<ResponseModel> resetPassword({String email}) async{
    isResettingPassword = true;
    notifyListeners();

    ResponseModel response = await AuthRepository().resetPassword(email: email);

    isResettingPassword = false;
    notifyListeners();

    return response;
  }

}