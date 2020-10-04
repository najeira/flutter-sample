import 'package:intl/intl.dart';

final DateFormat _outputFormat = DateFormat('yyyy/MM/dd(E) HH:mm', "ja_JP");

final DateFormat _inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ssZ', "ja_JP");

String formatDateTime(DateTime dt) {
  return _outputFormat.format(dt);
}

DateTime parseDateTime(String str) {
  return _inputFormat.parseUtc(str);
}

String formatDateTimeString(String str) {
  try {
    return formatDateTime(parseDateTime(str));
  } catch (_) {
    return "";
  }
}
