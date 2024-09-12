import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static setGuestMode(value) async {
    final Future<SharedPreferences> sharedPreferences =
        SharedPreferences.getInstance();
    final SharedPreferences prefs = await sharedPreferences;
    prefs.setBool(enableGuest, true);
  }

  static Future<bool?> getGuestMode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(enableGuest);
  }

  static setUserId(value) async {
    final Future<SharedPreferences> sharedPreferences =
        SharedPreferences.getInstance();
    final SharedPreferences prefs = await sharedPreferences;
    prefs.setString(prefUserId, value ?? '');
  }

  static Future<String?> getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(prefUserId);
  }

  static setUserName(value) async {
    final Future<SharedPreferences> sharedPreferences =
        SharedPreferences.getInstance();
    final SharedPreferences prefs = await sharedPreferences;
    prefs.setString(prefUserName, value ?? '');
  }

  static Future<String?> getUserName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(prefUserName) ?? '';
  }

  static setFirstName(value) async {
    final Future<SharedPreferences> sharedPreferences =
        SharedPreferences.getInstance();
    final SharedPreferences prefs = await sharedPreferences;
    prefs.setString(prefFirstName, value ?? '');
  }

  static Future<String?> getFirstName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(prefFirstName);
  }

  static setLastName(value) async {
    final Future<SharedPreferences> sharedPreferences =
        SharedPreferences.getInstance();
    final SharedPreferences prefs = await sharedPreferences;
    prefs.setString(prefLastName, value ?? '');
  }

  static Future<String?> getLastName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(prefLastName);
  }

  static setOTP(value) async {
    final Future<SharedPreferences> sharedPreferences =
        SharedPreferences.getInstance();
    final SharedPreferences prefs = await sharedPreferences;
    prefs.setString(prefOTP, value ?? '');
  }

  static Future<String?> getOTP() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(prefOTP);
  }

  static setMobileNumber(value) async {
    final Future<SharedPreferences> sharedPreferences =
        SharedPreferences.getInstance();
    final SharedPreferences prefs = await sharedPreferences;
    prefs.setString(prefMobileNumber, value);
  }

  static Future<String?> getMobileNumber() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(prefMobileNumber);
  }

  static Future<bool> setPassword(value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(prefPassword, value);
  }

  static Future getPassword() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(prefPassword);
  }

  static Future<bool> setRememberMe(value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setBool(prefRememberMe, value);
  }

  static Future isRememberMe() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(prefRememberMe);
  }

  static Future<void> setUserDetails(value) async {
    final Future<SharedPreferences> sharedPreferences =
        SharedPreferences.getInstance();
    final SharedPreferences prefs = await sharedPreferences;
    Map<String, dynamic> valueMap = value.toMap();
    prefs.setString(userDetails, json.encode(valueMap));
  }

/*  static Future<LoginModel?> getUserDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonString = sharedPreferences.getString(userDetails).toString();
    Map<String, dynamic> valueMap = json.decode('');
    LoginModel model = LoginModel.fromJson(valueMap);
    return model;
  }*/

  static setCountryCode(value) async {
    final Future<SharedPreferences> sharedPreferences =
        SharedPreferences.getInstance();
    final SharedPreferences prefs = await sharedPreferences;
    prefs.setString(countryCode, value);
  }

  static Future<String?> getCountryCode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(countryCode);
  }

  static Future<void> setAccessToken(value) async {
    final Future<SharedPreferences> sharedPreferences =
        SharedPreferences.getInstance();
    final SharedPreferences prefs = await sharedPreferences;
    prefs.setString(accessKey, value);
  }

  static Future<String?> getAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(accessKey);
  }

  static void clearSession() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove('user_id');
    await sharedPreferences.remove('otp');
    sharedPreferences.clear();
  }

  static setLanguage(value) async {
    final Future<SharedPreferences> sharedPreferences =
        SharedPreferences.getInstance();
    final SharedPreferences prefs = await sharedPreferences;
    prefs.setString(language, value ?? '');
  }

  static Future<String?> getLanguage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(language);
  }

  static setTransactionId(value) async {
    final Future<SharedPreferences> sharedPreferences =
    SharedPreferences.getInstance();
    final SharedPreferences prefs = await sharedPreferences;
    prefs.setInt(transactionId, value ?? 0);
  }

  static Future<int?> getTransactionId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(transactionId);
  }

  static setCurrency(value) async {
    final Future<SharedPreferences> sharedPreferences =
    SharedPreferences.getInstance();
    final SharedPreferences prefs = await sharedPreferences;
    prefs.setString(currency, value ?? '');
  }

  static Future<String?> getCurrency() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(currency);
  }


  static setGapID(value) async {
    final Future<SharedPreferences> sharedPreferences =
    SharedPreferences.getInstance();
    final SharedPreferences prefs = await sharedPreferences;
    prefs.setString(gapId, value ?? '');
  }

  static Future<String?> getGapID() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(gapId);
  }

  static setProfession(value) async {
    final Future<SharedPreferences> sharedPreferences =
    SharedPreferences.getInstance();
    final SharedPreferences prefs = await sharedPreferences;
    prefs.setString(profession, value ?? '');
  }

  static Future<String?> getProfession() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(profession);
  }

  static const prefUserId = "user_id";
  static const prefUserName = "user_name";
  static const prefFirstName = "first_name";
  static const prefLastName = "last_name";
  static const prefOTP = "otp";
  static const prefMobileNumber = "mobile_number";
  static const prefPassword = "password";
  static const prefRememberMe = "remember_me";
  static const userDetails = "user_details";
  static const countryCode = "country_code";
  static const accessKey = "access_key";
  static const enableGuest = "enable_guest";
  static const language = "language";
  static const transactionId = "transaction_id";
  static const currency = "currency";
  static const gapId = "gap_id";
  static const profession = "profession";
}
