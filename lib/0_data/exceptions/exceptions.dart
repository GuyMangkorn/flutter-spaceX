import 'package:http/http.dart';

class AppException implements Exception {
  final String? message;
  final String? prefix;
  final String? url;

  AppException({
    this.message,
    this.prefix,
    this.url,
  });
}

class BadRequestException extends AppException {
  BadRequestException({message, prefix, url})
      : super(message: 'Bad request!', prefix: prefix, url: url);
}

class FetchDataException extends AppException {
  FetchDataException({message, prefix, url})
      : super(message: 'Bad request!', prefix: prefix, url: url);
}

class ServerException extends AppException {
  ServerException({message, prefix, url})
      : super(message: 'Server error!', prefix: prefix, url: url);
}

class MapStatusCode {
  static Never mapStatusCodeException(Response response) {
    switch (response.statusCode) {
      case 400:
      case 403:
        throw BadRequestException();
      case 500:
        throw ServerException();
      default:
        throw FetchDataException();
    }
  }
}
