import 'package:flutter/cupertino.dart';
import 'package:vgo_flutter_app/src/model/request/create_address_request.dart';
import 'package:vgo_flutter_app/src/model/request/kyc/education_request.dart';
import 'package:vgo_flutter_app/src/model/request/kyc/experience_request.dart';
import 'package:vgo_flutter_app/src/model/response/address_list_response.dart';
import 'package:vgo_flutter_app/src/model/response/kyc/kyc_response.dart';
import 'package:vgo_flutter_app/src/view/activity/kyc/profile/profile_response.dart';

import '../model/response/address_response.dart';
import '../model/response/kyc/kyc_list_response.dart';
import '../network/api/api_request_manager.dart';

class KycViewModel {
  static final KycViewModel instance = KycViewModel();

  void experienceValidate(ExperienceRequest request,
      {required Function(String? message, bool) completion}) {
    if (request.orgCompany?.isEmpty ?? false) {
      completion("Please enter company/organization name!", false);
    } else if (request.desig?.isEmpty ?? false) {
      completion("Please enter designation!", false);
    } else if (request.dept?.isEmpty ?? false) {
      completion("Please enter department!", false);
    } else if (request.workingYears?.isEmpty ?? false) {
      completion("Please enter working period!", false);
    } else if (request.cityTown?.isEmpty ?? false) {
      completion("Please enter city/town!", false);
    } else if (request.postalCode?.toString().isEmpty ?? false) {
      completion("Please enter postel code!", false);
    } else if (request.state?.isEmpty ?? false) {
      completion("Please enter state!", false);
    } else if (request.country?.isEmpty ?? false) {
      completion("Please enter country!", false);
    } else {
      completion('', true);
    }
  }

  void educationValidate(EducationRequest request,
      {required Function(String? message, bool) completion}) {
    if (request.course?.isEmpty ?? false) {
      completion("Please enter course name!", false);
    } else if (request.duration?.isEmpty ?? false) {
      completion("Please enter duration!", false);
    } else if (request.yearOfPass?.toString().isEmpty ?? false) {
      completion("Please enter year of passed!", false);
    } else if (request.collegeUniversity?.isEmpty ?? false) {
      completion("Please enter college/university!", false);
    } else if (request.cityTown?.isEmpty ?? false) {
      completion("Please enter city/town!", false);
    } else if (request.postalCode?.toString().isEmpty ?? false) {
      completion("Please enter postel code!", false);
    } else if (request.state?.isEmpty ?? false) {
      completion("Please enter state!", false);
    } else if (request.country?.isEmpty ?? false) {
      completion("Please enter country!", false);
    } else {
      completion('', true);
    }
  }

  void validateCreateAddress(CreateAddressRequest request, BuildContext context,
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

  void callCreateExperienceApi(ExperienceRequest request,
      {required Function(KycResponse? response) completion}) {
    ApiRequestManager.instance.apiCreateExperience(request,
        completion: (response) {
      completion(response);
    });
  }

  void callGetExperienceApi(String gapId,
      {required Function(KycListResponse? response) completion}) {
    ApiRequestManager.instance.apiGetExperienceList(gapId,
        completion: (response) {
      completion(response);
    });
  }

  void callGetEducationApi(String gapId,
      {required Function(KycListResponse? response) completion}) {
    ApiRequestManager.instance.apiGetEducationList(gapId,
        completion: (response) {
      completion(response);
    });
  }

  void callGetMyProfileInquiries(String gapId,
      {required Function(ProfileResponse? response) completion}) {
    ApiRequestManager.instance.apiGetMyProfileInquiries(gapId,
        completion: (response) {
      completion(response);
    });
  }

  void callGetAcceptProfiles(String gapId,
      {required Function(KycListResponse? response) completion}) {
    ApiRequestManager.instance.apiGetAcceptProfiles(gapId,
        completion: (response) {
      completion(response);
    });
  }

  void callUpdateProfileStatus(String gapId, String id,
      {required Function(KycListResponse? response) completion}) {
    ApiRequestManager.instance.apiUpdateProfileStatus(gapId, id,
        completion: (response) {
      completion(response);
    });
  }

  void callCreateExperience(ExperienceRequest request,
      {required Function(KycResponse? response) completion}) {
    ApiRequestManager.instance.apiCreateExperience(request,
        completion: (response) {
      completion(response);
    });
  }

  void callCreateEducation(EducationRequest request,
      {required Function(KycResponse? response) completion}) {
    ApiRequestManager.instance.apiCreateEducation(request,
        completion: (response) {
      completion(response);
    });
  }

  void callGetAddressApi(String gapId,
      {required Function(AddressListResponse? response) completion}) {
    ApiRequestManager.instance.apiGetAddressList(gapId, completion: (response) {
      completion(response);
    });
  }

  void callAddAddressProfile(CreateAddressRequest request,
      {required Function(AddressResponse? response) completion}) {
    ApiRequestManager.instance.apiAddAddressProfile(request,
        completion: (response) {
      completion(response);
    });
  }

  void callSearchProfileApi(String gapId,
      {required Function(ProfileResponse? response) completion}) {
    ApiRequestManager.instance.apiSearchProfile(gapId, completion: (response) {
      completion(response);
    });
  }
}
