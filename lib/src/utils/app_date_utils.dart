import 'package:basic_utils/basic_utils.dart';
import 'package:intl/intl.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';

class AppDateUtils {

  static final String dateFormat = 'yyyy-MM-dd hh:mm:ss';
  static final String dateFormatMonth = 'MMM dd, yyyy';
  static final String dateFormatYMD = 'yyyy-MM-dd';

  static final DateFormat inputFormat = new DateFormat(dateFormat);
  static final DateFormat inputFormatYMD = new DateFormat(dateFormatYMD);

  static String convertToAgo(String dateTime) {
    DateTime input = DateFormat(dateFormat).parse(dateTime, true);
    Duration diff = DateTime.now().difference(input);

    if (diff.inDays >= 1) {
      return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} second${diff.inSeconds == 1 ? '' : 's'} ago';
    } else {
      return 'just now';
    }
  }

  static String getTimeAgo(String createDate, updatedDate) {
    return updatedDate != null
        ? convertToAgo(updatedDate)
        : convertToAgo(createDate);
  }

  static String getMonthInText(String createDate, updatedDate) {
/*    loggerNoStack.e('createDate : ' + createDate);
    loggerNoStack.e('updatedDate : ' + updatedDate);*/
    String date = '';
    if (StringUtils.isNotNullOrEmpty(updatedDate) && updatedDate.toString().toLowerCase() != 'null') {
      date = updatedDate;
    } else {
      date = createDate;
    }
    // loggerNoStack.e('date : ' + date);
    var inputDate = inputFormat.parse(date);
    return DateFormat(dateFormatMonth).format(inputDate);
  }

  static String extractTimeFromDateTime(String createDate, updatedDate) {
/*    loggerNoStack.e('createDate : ' + createDate);
    loggerNoStack.e('updatedDate : ' + updatedDate);*/
    String date = '';
    if (StringUtils.isNotNullOrEmpty(updatedDate) && updatedDate.toString().toLowerCase() != 'null') {
      date = updatedDate;
    } else {
      date = createDate;
    }
    // loggerNoStack.e('date : ' + date);
    var spilt = date.split(" ");
    return spilt[1];
  }

  static String getDateINYMD(String createDate, updatedDate) {
/*    loggerNoStack.e('createDate : ' + createDate);
    loggerNoStack.e('updatedDate : ' + updatedDate);*/
    String date = '';
    if (StringUtils.isNotNullOrEmpty(updatedDate) && updatedDate.toString().toLowerCase() != 'null') {
      date = updatedDate;
    } else {
      date = createDate;
    }
    //loggerNoStack.e('date : ' + date);
    var inputDate = inputFormatYMD.parse(date);
    return DateFormat(dateFormatMonth).format(inputDate);
  }
}
