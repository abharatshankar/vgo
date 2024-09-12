import 'package:vgo_flutter_app/src/model/request/bot/bot_chat_request.dart';
import 'package:vgo_flutter_app/src/model/response/jobs/jobs_response.dart';

import '../network/api/api_request_manager.dart';

class BotChatViewModel {
  static final BotChatViewModel instance = BotChatViewModel();

  void callBotGetChatResponseApi(BotChatRequest request,
      {required Function(JobsResponse? response) completion}) {
    ApiRequestManager.instance.apiBotGetChatResponse(request,
        completion: (response) {
      completion(response);
    });
  }
}
