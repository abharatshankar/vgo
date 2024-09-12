import 'package:flutter/cupertino.dart';
import 'package:vgo_flutter_app/src/model/request/create_address_request.dart';
import 'package:vgo_flutter_app/src/model/response/address_list_response.dart';
import 'package:vgo_flutter_app/src/model/response/status_response.dart';

import '../../../model/response/address_response.dart';
import '../../../model/response/status_code_response.dart';
import '../../../network/api/api_request_manager.dart';

class AddressViewModel {
  static final AddressViewModel instance = AddressViewModel();

  void validateCreateStore(CreateAddressRequest request, BuildContext context,
      {required Function(String? message, bool) completion}) {
    if (request.address_type?.isEmpty ?? false) {
      completion("Please enter address type!", false);
    } else if (request.house_no?.isEmpty ?? false) {
      completion("Please enter house/flat number", false);
    } else if (request.address1?.isEmpty ?? false) {
      completion("Please enter address 1!", false);
    } else if (request.address2?.isEmpty ?? false) {
      completion("Please enter address 2!", false);
    } else if (request.land_mark?.isEmpty ?? false) {
      completion("Please enter landmark!", false);
    } else if (request.city?.isEmpty ?? false) {
      completion("Please enter city!", false);
    } else if (request.state?.isEmpty ?? false) {
      completion("Please enter state!", false);
    } else if (request.country?.isEmpty ?? false) {
      completion("Please enter country!", false);
    } else if (request.postal_code?.isEmpty ?? false) {
      completion("Please enter postel code!", false);
    } else {
      completion('', true);
    }
  }

  void callCreateAddress(CreateAddressRequest request,
      {required Function(AddressResponse? response) completion}) {
    ApiRequestManager.instance.apiCreateAddress(request,
        completion: (response) {
      completion(response);
    });
  }

  void callGetAddressList(String username,
      {required Function(AddressListResponse? response) completion}) {
    ApiRequestManager.instance.apiGetDeliveryAddress(username,
        completion: (response) {
      completion(response);
    });
  }

  void callDeleteAddress(String id,
      {required Function(StatusCodeResponse? response) completion}) {
    ApiRequestManager.instance.apiDeleteDeliveryAddress(id,
        completion: (response) {
          completion(response);
        });
  }
}
