import 'package:logger/logger.dart';

// print('login(): Got token: $token');
// log('login(): Got token: $token');
// dev.log('login(): Got token: $token', name: 'login');
// dev.log('login(): Got token: $token');

final logger = getLogger();

void logd(String msg) {
  logger.d(msg);
}

void logi(String msg) {
  logger.i(msg);
}

void loge(String msg) {
  logger.e(msg);
}

void logv(String msg) {
  logger.v(msg);
}

void logw(String msg) {
  logger.w(msg);
}

void logwtf(String msg) {
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
