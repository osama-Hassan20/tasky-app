import 'package:equatable/equatable.dart';

import 'error_strings.dart';

class ServerException extends Equatable implements Exception {
  final String? message;

  const ServerException([this.message]);

  @override
  List<Object?> get props => [message];

  @override
  String toString() {
    return '$message';
  }
}

class FetchDataException extends ServerException {
  const FetchDataException([message])
      : super(ErrorStrings.errorDuringCommunication);
}

class BadRequestException extends ServerException {
  const BadRequestException([message]) : super(ErrorStrings.badRequest);
}

class UnauthorizedException extends ServerException {
  const UnauthorizedException([message]) : super(ErrorStrings.unauthorized);
}

class NotFoundException extends ServerException {
  const NotFoundException([message]) : super(ErrorStrings.requestedInfoNotFound);
}

class ConflictException extends ServerException {
  const ConflictException([message]) : super(ErrorStrings.conflictOccurred);
}

class InternalServerErrorException extends ServerException {
  const InternalServerErrorException([message])
      : super(ErrorStrings.internalServerError);
}

class NoInternetConnectionException extends ServerException {
  const NoInternetConnectionException([message])
      : super(ErrorStrings.noInternetConnection);
}

class CacheException implements Exception {}