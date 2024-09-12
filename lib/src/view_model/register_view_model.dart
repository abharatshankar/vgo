import 'package:flutter/cupertino.dart';
import 'package:vgo_flutter_app/src/model/request/registration_request.dart';
import 'package:vgo_flutter_app/src/model/response/user_register_response.dart';
import 'package:string_validator/string_validator.dart';

import '../network/api/api_request_manager.dart';

class RegisterViewModel {
  static final RegisterViewModel instance = RegisterViewModel();

  void doRegisterValidate(RegistrationRequest request, BuildContext context,
      {required Function(String? message, bool) completion}) {
    if (request.firstName?.isEmpty ?? false) {
      completion("Please enter first name!", false);
    } else if (request.lastName?.isEmpty ?? false) {
      completion("Please enter last name!", false);
    } else if (request.mobileNumber?.isEmpty ?? false) {
      completion("Please enter mobile number!", false);
    } else if (request.mobileNumber!.length < 10) {
      completion("Please enter valid mobile number!", false);
    } else if (request.emailId!.isNotEmpty && !isEmail(request.emailId.toString())) {
      completion("Please enter valid email address!", false);
    } else {
      completion('', true);
    }
  }

  void doRegistrationAPI(RegistrationRequest request,
      {required Function(UserRegisterResponse? response) completion}) {
    ApiRequestManager.instance.doRegister(request, completion: (response) {
      completion(response);
    });
  }
}
