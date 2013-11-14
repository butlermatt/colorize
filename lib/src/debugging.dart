library colorize.debugging;

import 'package:logging/logging.dart';
export 'package:logging/logging.dart' show Logger;

init() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.loggerName}: ${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}