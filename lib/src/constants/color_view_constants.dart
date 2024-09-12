import 'dart:ui';

class ColorViewConstants {

  static Color colorPrimaryText = HexColor("#1D1F29");
  static Color colorPrimaryTextHint = HexColor("#8E8E8E");
  static Color colorPrimaryTextMedium = HexColor("#1D1F29");
  static Color colorTextMedium = HexColor("#727272");
  static Color colorPrimaryOpacityText50 = HexColor("#501D1F29");
  static Color colorPrimaryOpacityText80 = HexColor("#801D1F29");
  static Color colorSecondaryText = HexColor("#8E8E8E");
  static Color colorBlueSecondaryText = HexColor("#0061AF");
  static Color colorBlueSecondaryDarkText = HexColor("#003E6F");
  static Color colorGreenBg = HexColor("#D6FDE3");
  static Color colorBlueBackground = HexColor("#50F2F9FF");
  static Color colorBlack = HexColor("#000000");
  static Color colorLightBlack = HexColor("#4B4B4B");
  static Color colorGray = HexColor("#9F9E9F");
  static Color colorDarkGray = HexColor("#757575");
  static Color colorLightGray = HexColor("#B9B9B9");
  static Color colorWhite = HexColor("#FFFFFF");
  static Color colorLightWhite = HexColor("#F6F6F6");
  static Color colorCyan = HexColor("#21FD9D");
  static Color colorYellow = HexColor("#f9d229");
  static Color colorTransferGray = HexColor("#EFEFEF");
  static Color colorHintGray = HexColor("#8E8E8E");
  static Color colorRed = HexColor("#C90000");
  static Color colorBlue = HexColor("#F0F8FF");
  static Color colorDarkBlue = HexColor("#6CBEFF");
  static Color colorGreen = HexColor("#00B139");
  static Color colorGrayLight = HexColor("#1000B139");
  static Color colorBlackOpacity= HexColor("#101D1F29");
  static Color colorGrayOpacity = HexColor("#108E8E8E");
  static Color colorHintBlue= HexColor("#f5f9fc");
  static Color colorGrayTransparent = HexColor("#209F9E9F");
  static Color colorGrayTransparent80 = HexColor("#509F9E9F");
  static Color colorChatBackground = HexColor("#C9E7FF");
  static Color colorLoader = HexColor("#409F9E9F");
  static Color colorHintRed = HexColor("#10C90000");
  static Color colorBrightRed = HexColor("#FF5733");
  static Color colorImageBg = HexColor("#000019");

}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
