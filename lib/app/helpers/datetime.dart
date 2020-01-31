import 'package:intl/intl.dart';

final DateFormat dateFormat = DateFormat('yyyy/MM/dd(E) HH:mm', "ja_JP");

String formatDateTime(DateTime dt) {
  return dateFormat.format(dt);
}
