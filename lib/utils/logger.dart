import 'package:logger/logger.dart';

final logger = getLogger();

void log(String msg) {
  // logger.d(msg);
  // logger.i(msg);
  // logger.e(msg);
  // logger.v(msg);
  // logger.w(msg);
  logger.wtf(msg);
}

Logger getLogger() {
  return Logger(printer: SimpleLogPrinter());
}

class SimpleLogPrinter extends LogPrinter {
  @override
  void log(LogEvent le) {
    var color = PrettyPrinter.levelColors[le.level];
    println(color('${le.message}'));
  }
}

// ! With class name:

// final logger = getLogger('LoginScreen');

// Logger getLogger(String className) {
//   return Logger(printer: SimpleLogPrinter(className));
// }

// class SimpleLogPrinter extends LogPrinter {
//   final String className;
//   SimpleLogPrinter(this.className);

//   @override
//   void log(LogEvent le) {
//     var color = PrettyPrinter.levelColors[le.level];
//     var emoji = PrettyPrinter.levelEmojis[le.level];
//     println(color('$emoji $className - ${le.message}'));
//   }
// }
