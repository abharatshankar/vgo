import 'package:flutter/cupertino.dart';
import 'package:vgo_flutter_app/src/model/request/mobile_number_request.dart';
import 'package:vgo_flutter_app/src/model/response/user_login_response.dart';
import 'package:vgo_flutter_app/src/model/response/user_register_response.dart';

import '../model/response/country_list_response.dart';
import '../network/api/api_request_manager.dart';

class LoginViewModel {
  static final LoginViewModel instance = LoginViewModel();

  void doLoginValidate(MobileNumberRequest request, BuildContext context,
      {required Function(String? message, bool) completion}) {
    if (request.mobileNumber?.isEmpty ?? false) {
      completion("Please enter mobile number!", false);
    } else if (request.mobileNumber!.length < 10) {
      completion("Please enter valid mobile number!", false);
    } else {
      completion('', true);
    }
  }

  void doLoginAPI(MobileNumberRequest request,
      {required Function(UserLoginResponse? response) completion}) {
    ApiRequestManager.instance.doUserLogin(request, completion: (response) {
      completion(response);
    });
  }

  void callUserExistsOrNot(MobileNumberRequest request,
      {required Function(UserRegisterResponse? response) completion}) {
    ApiRequestManager.instance.checkUserExistsOrNot(request,
        completion: (response) {
      completion(response);
    });
  }

  void apiCountryList({required Function(CountryListResponse? response) completion}) {
    ApiRequestManager.instance.countryList(completion: (response) {
      completion(response);
    });
  }

}
