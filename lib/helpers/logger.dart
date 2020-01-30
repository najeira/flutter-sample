import 'package:flutter/foundation.dart';
import 'package:stack_trace/stack_trace.dart';

class Logger {
  bool printToConsole = false;

  void info(String message) {
    final List<String> parts = Trace.current().frames[1].member.split(".");
    final String className = parts[0];
    final String methodName = parts[1];
    if (printToConsole) {
      debugPrint(message);
    }
  }

  void error(String message) {
    final List<String> parts = Trace.current().frames[1].member.split(".");
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
    final List<String> parts = Trace.current().frames[1].member.split(".");
    final String className = parts[0];
    final String methodName = parts[1];
    if (printToConsole) {
      debugPrint(message);
    }
  }
}

Logger logger = Logger();
