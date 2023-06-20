import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart';

class MyException implements Exception {
  String? exceptionMessage;

  MyException(dynamic exception) {
    if (exception is SocketException) {
      if (exception.osError?.errorCode == 111 ||
          exception.osError?.errorCode == 110) {
        exceptionMessage = "Server not reachable";
      }
      if (exception.osError?.errorCode == 7) {
        exceptionMessage = "Please check your internet connection";
      }

      if (exception.osError?.errorCode == 101) {
        exceptionMessage = "Slow connection";
      }
    } else if (exception is String) {
      exceptionMessage = exception;
    } else if (exception is ArgumentError) {
      exceptionMessage = "Please try after sometime.";
    } else if (exception is MyException) {
      exceptionMessage = exception.exceptionMessage;
    } else if (exception is PlatformException) {
      exceptionMessage = "Permissions denied";
    } else if (exception is Response) {
      if (exception.statusCode == 404) {
        exceptionMessage = "Please try after sometime.";
      } else if (exception.statusCode == 500) {
        exceptionMessage = "Please try after sometime.";
      } else if (exception.statusCode == 403) {
        exceptionMessage = "Session Expired, Please login";
      }
    }
  }

  factory MyException.onException(String exception) {
    return MyException(exception);
  }

  @override
  String toString() {
    return exceptionMessage ?? "";
  }
}
