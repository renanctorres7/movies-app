import 'package:equatable/equatable.dart';

abstract class FailureError extends Equatable {}

class DomainError extends FailureError {
  @override
  List<Object?> get props => [];
}

class InvalidSearchText extends DomainError {}

class NullError extends FailureError {
  @override
  List<Object?> get props => [];
}

class DataSourceError extends FailureError {
  @override
  List<Object?> get props => [];
}

class ApiError extends FailureError {
  final int statusCode;
  final String message;

  ApiError({required this.statusCode, required this.message});

  @override
  List<Object?> get props => [statusCode, message];
}