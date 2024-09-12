import 'package:vgo_flutter_app/src/model/request/job_request.dart';
import 'package:vgo_flutter_app/src/model/request/kyc/education_request.dart';
import 'package:vgo_flutter_app/src/model/request/kyc/experience_request.dart';
import 'package:vgo_flutter_app/src/model/response/jobs/jobs_list_response.dart';
import 'package:vgo_flutter_app/src/model/response/jobs/jobs_response.dart';

import '../network/api/api_request_manager.dart';

class JobsViewModel {
  static final JobsViewModel instance = JobsViewModel();

  void createJobValidate(JobRequest request,
      {required Function(String? message, bool) completion}) {
    if (request.company_name?.isEmpty ?? false) {
      completion("Please enter company/organization name!", false);
    } else if (request.job_title?.isEmpty ?? false) {
      completion("Please enter job title!", false);
    } else if (request.industry?.isEmpty ?? false) {
      completion("Please enter industry!", false);
    } else if (request.key_skills?.isEmpty ?? false) {
      completion("Please enter key skills!", false);
    } else if (request.job_desc?.isEmpty ?? false) {
      completion("Please enter job description!", false);
    } else if (request.budget_amount?.toString().isEmpty ?? false) {
      completion("Please enter budget amount!", false);
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

  void callGetAllJobOrdersApi(String username,
      {required Function(JobsListResponse? response) completion}) {
    ApiRequestManager.instance.apiGetAllJobOrders(username,
        completion: (response) {
      completion(response);
    });
  }

  void callGetMyJobOrdersApi(String username,
      {required Function(JobsListResponse? response) completion}) {
    ApiRequestManager.instance.apiGetMyJobOrders(username,
        completion: (response) {
      completion(response);
    });
  }

  void apiGetMyPostedJobOrders(String username,
      {required Function(JobsListResponse? response) completion}) {
    ApiRequestManager.instance.apiGetMyPostedJobOrders(username,
        completion: (response) {
          completion(response);
        });
  }

  void callAcceptJobOrdersApi(String jobId, JobRequest request,
      {required Function(JobsResponse? response) completion}) {
    ApiRequestManager.instance.apiAcceptJobOrders(jobId, request,
        completion: (response) {
      completion(response);
    });
  }

  void callGetJobOrderLogsApi(String jobId,
      {required Function(JobsListResponse? response) completion}) {
    ApiRequestManager.instance.apiGetJobOrderLogs(jobId,
        completion: (response) {
      completion(response);
    });
  }

  void callCreateJobOrderLogsApi(String jobId, JobRequest request,
      {required Function(JobsResponse? response) completion}) {
    ApiRequestManager.instance.apiCreateJobOrderLog(jobId, request,
        completion: (response) {
          completion(response);
        });
  }

  void callCreateJobOrderApi(JobRequest request,
      {required Function(JobsResponse? response) completion}) {
    ApiRequestManager.instance.apiCreateJobOrder(request,
        completion: (response) {
      completion(response);
    });
  }
}
