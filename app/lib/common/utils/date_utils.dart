import 'package:intl/intl.dart';

class DateUtils {
  String formatUTCDateToLocal(
    int timestamp, {
    format = 'EEEE, dd MMMM yyyy HH:mm:ss',
  }) {
    final date = getLocalTime(timestamp);
    return DateFormat(format).format(date);
  }

  DateTime getLocalTime(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true).toLocal();
  }

  String formatTo(
    DateTime date, {
    format = 'dd/MM/yyyy',
  }) {
    return DateFormat(format).format(date);
  }

  DateTime parse(
    String date, {
    format = 'dd/MM/yyyy',
  }) {
    return DateFormat(format).parse(date);
  }

  String transform(
    String date, {
    formatFrom = 'yyyy-MM-dd',
    formatTo = 'dd/MM/yyyy',
  }) {
    return DateFormat(formatTo).format(DateFormat(formatFrom).parse(date));
  }

  String tryTransform(
    String date, {
    formatFrom = 'yyyy-MM-dd',
    formatTo = 'dd/MM/yyyy',
  }) {
    try {
      return transform(date, formatFrom: formatFrom, formatTo: formatTo);
      // ignore: avoid_catches_without_on_clauses
    } catch (ex) {
      return '';
    }
  }
}
