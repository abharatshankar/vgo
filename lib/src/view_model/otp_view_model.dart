import 'package:flutter/cupertino.dart';
import 'package:vgo_flutter_app/src/model/request/otp_request.dart';
import 'package:vgo_flutter_app/src/model/response/user_login_response.dart';

import '../network/api/api_request_manager.dart';

class OTPViewModel {
  static final OTPViewModel instance = OTPViewModel();

  void doOTPValidate(OTPRequest request, BuildContext context,
      {required Function(String? message, bool) completion}) {
    if (request.otp?.isEmpty ?? false) {
      completion("Please enter OTP!", false);
    } else if (request.otp!.length < 6) {
      completion("Please enter valid OTP!", false);
    } else {
      completion('', true);
    }
  }

  void doOTPAuthenticateAPI(OTPRequest request,
      {required Function(UserLoginResponse? response) completion}) {
    ApiRequestManager.instance.doUserOTPAuthenticate(request, completion: (response) {
      completion(response);
    });
  }
}
