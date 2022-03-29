import 'dart:developer';

import 'package:logging/logging.dart';

const kNetworkDebug = true;

void initLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(_log);
}

void _log(LogRecord record) async {
  log(
    record.message,
    name: record.loggerName,
    level: record.level.value,
    error: record.error,
    stackTrace: record.stackTrace,
    time: DateTime.now(),
  );
}
