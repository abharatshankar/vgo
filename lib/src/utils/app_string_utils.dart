import 'package:basic_utils/basic_utils.dart';

import '../model/country.dart';

class AppStringUtils{

  static const String noImageUrlWallet = 'https://i.ibb.co/ckN61GB/no-pictures.png';
  static const String noImageUrl = 'https://i.ibb.co/QXBmtNk/403017-avatar-default-head-person-unknown-icon.png';

  static const int TYPE_INT = 1;
  static const int TYPE_TEXT = 2;
  static const int TYPE_SPACE = 3;
  static const int TYPE_PERSON_NAME = 4;
  static const int TYPE_ANY = 5;
  static const int TYPE_UPI_ID = 6;

  static var defaultCountry = Country(
      countryIconPath: 'https://vgopay.in/icons/IND_Icon.png',
      countryCode: '+91',
      currencyCode: 'INR');

  static var defaultCurrency = 'INR';

  static String? emptyString(String? value){
    return value ?? '';
  }

  static String? subStringDateTime(String? value){
    return value!.length > 16 ? value.substring(0, 16).toString() : value.toString();
  }

  static String? subStringDate(String? value){
    return value!.length > 10 ? value.substring(0, 10).toString() : value.toString();
  }

  static String? extractFirstLetter(String value){
    final String output = value.length > 0 ? value.substring(0, 1).toString() : value.toString();
    return StringUtils.capitalize(output);
  }

}