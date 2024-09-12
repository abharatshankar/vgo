import 'package:vgo_flutter_app/src/model/request/status_code_request.dart';
import 'package:vgo_flutter_app/src/model/response/status_code_response.dart';
import 'package:vgo_flutter_app/src/model/response/user_type_response.dart';

import '../network/api/api_request_manager.dart';

class ProfileViewModel {
  static final ProfileViewModel instance = ProfileViewModel();

  void callGetUserTypes(
      {required Function(UserTypeResponse? response) completion}) {
    ApiRequestManager.instance.getUserType(completion: (response) {
      completion(response);
    });
  }

  void callCreateUserCategory(StatusCodeRequest request,
      {required Function(StatusCodeResponse? response) completion}) {
    ApiRequestManager.instance.createUserCategory(request, completion: (response) {
      completion(response);
    });
  }
}
