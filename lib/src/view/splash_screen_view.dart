import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/view/login/user_login_view.dart';
import 'package:vgo_flutter_app/src/view/team/team_menu_view.dart';

import '../model/response/settings_response.dart';
import '../session/session_manager.dart';
import '../utils/utils.dart';
import '../view_model/services_view_model.dart';
import 'bottom/bottom_navigation_view.dart';

class SplashScreenView extends StatefulWidget {
  SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreenView> {
  String userName = '';
  SettingsResponse? settingsResponse;

  @override
  void initState() {
    super.initState();
    loggerNoStack.e('SplashScreenView');
    SessionManager.getUserName().then((value) {
      userName = value!;
      loggerNoStack.e('userName :$userName');
    });

    getFCMToken();
    // callSettingsConfigApi();
  }

  Future<void> getFCMToken() async {
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp(
        options: FirebaseOptions(
      apiKey: "AIzaSyBZoS9WAOL-dIatqx8_spAW59DOVPdEcPw",
      appId: "1:241348522509:android:13292838b1c6e385451b44",
      messagingSenderId: "241348522509",
      projectId: "vgo-android-16d1a",
    )).then((value1){
      final messaging = FirebaseMessaging.instance;
      messaging.getToken().then((value){
        loggerNoStack.e('fcm token : ' + value!);
      });
    });

  }

  void callSettingsConfigApi() {
    ServicesViewModel.instance.callSettingsConfig(completion: (response) {
      setState(() {
        settingsResponse = response;
        if (userName.isNotEmpty) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TeamMenuView(settingsResponse: settingsResponse)),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => UserLoginView()),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      if (userName.isNotEmpty) {
        //B
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => BottomNavigationView(currentIndex: 0,)),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserLoginView()),
        );
      }
    });

    return Scaffold(
        body: Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/logo/vgo_logo.png',
              height: 150,
              width: 250,
            )));
  }
}
