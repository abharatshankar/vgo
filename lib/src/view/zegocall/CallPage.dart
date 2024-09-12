import 'package:flutter/widgets.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';


class CallPage extends StatelessWidget {
  const CallPage({Key? key, required this.callID, required this.userName, required this.mobileNumber}) : super(key: key);
  final String callID;
  final String userName;
  final String mobileNumber;



  @override
  Widget build(BuildContext context) {

    loggerNoStack.e('userName' + userName);

    return ZegoUIKitPrebuiltCall(
      appID: 833408712, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign: 'b3a5dc7a5fe92b4262c08bca409972dcd7eae0a480514947241ad2dee3ab293a', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: this.mobileNumber,
      userName: this.userName,
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}