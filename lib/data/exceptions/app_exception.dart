class AppException implements Exception {
  final String? _message;
  final String? _prefix;
  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return '$_message$_prefix';
  }
}

class NoInternetException extends AppException {
  NoInternetException([String? message])
      : super(message, 'No Internet Connection');
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([String? message])
      : super(message, 'You dont have access to it');
}

class RequestTimeOutException extends AppException {
  RequestTimeOutException([String? message])
      : super(message, 'Request Time Out');
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, 'An error occured while fetching data');
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, 'Invalid Request');
}

class NotFoundException extends AppException {
  NotFoundException([String? message]) : super(message, 'Resource Not Found');
}

class InternalServerErrorException extends AppException {
  InternalServerErrorException([String? message])
      : super(message, 'Internal Server Error');
}

class ServiceUnavailableException extends AppException {
  ServiceUnavailableException([String? message])
      : super(message, 'Service Unavailable');
}

class ConflictException extends AppException {
  ConflictException([String? message]) : super(message, 'There was a conflict during data operation');
}

class ForbiddenException extends AppException {
  ForbiddenException([String? message]) : super(message, 'you don\'t have permission to perform this action');
}
