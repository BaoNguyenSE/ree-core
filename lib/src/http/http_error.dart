import 'dart:io';

import 'package:app_core/src/http/http_client_wrapper.dart';
import 'package:dio/dio.dart';

class HttpError extends DioError {
  final ErrorMessageParser? _errorMessageParser;

  HttpError({
    required DioError dioError,
    ErrorMessageParser? errorMessageParser,
  })  : _errorMessageParser = errorMessageParser,
        super(
          requestOptions: dioError.requestOptions,
          response: dioError.response,
          type: dioError.type,
          error: dioError.error,
        );

  @override
  String get message {
    if (error is SocketException) {
      return "Cannot connect to server. Please check network and try again!";
    }

    final parsedMessage = _errorMessageParser?.call(httpError: this);
    if (parsedMessage != null) {
      return parsedMessage;
    }

    return super.message;
  }

  @override
  String toString() {
    return message;
  }
}

String? laravelErrorMessageParser({
  required HttpError httpError,
}) {
  if (httpError.response?.data is Map) {
    final Map data = httpError.response?.data as Map;
    if (data.containsKey("message")) {
      return data["message"].toString();
    } else {
      final StringBuffer buffer = StringBuffer();
      data.forEach((key, value) {
        if (buffer.isNotEmpty) {
          buffer.write("\n");
        }
        if (value is List) {
          buffer.write(value.join("\n"));
        } else {
          buffer.write(value);
        }
      });
      return buffer.toString();
    }
  }
  return null;
}
