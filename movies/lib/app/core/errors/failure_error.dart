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
