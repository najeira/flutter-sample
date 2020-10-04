import 'package:flutter/foundation.dart';

import 'package:stack_trace/stack_trace.dart';

class Logger {
  bool printToConsole = true;

  void info(String message) {
    final List<String> parts = _parts();
    final String className = parts[0];
    final String methodName = parts[1];
    if (printToConsole) {
      debugPrint(message);
    }
  }

  void error(String message) {
    final List<String> parts = _parts();
    final String className = parts[0];
    final String methodName = parts[1];
    if (printToConsole) {
      debugPrint(message);
    }
  }

  void errorException(Object e, [StackTrace s]) {
    if (printToConsole) {
      print(e);
      if (s != null) {
        print(s);
      }
    }
  }

  void warn(String message) {
    final List<String> parts = _parts();
    final String className = parts[0];
    final String methodName = parts[1];
    if (printToConsole) {
      debugPrint(message);
    }
  }

  List<String> _parts() {
    return Trace.current().frames[2].member.split(".");
  }
}

Logger logger = Logger();
