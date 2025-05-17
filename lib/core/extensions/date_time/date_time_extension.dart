extension DateTimeExtension on DateTime {
  int toTimeStamp() => Duration(milliseconds: millisecondsSinceEpoch).inSeconds;
}
