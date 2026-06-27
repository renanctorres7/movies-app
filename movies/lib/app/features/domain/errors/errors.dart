import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class InvalidSearchText extends Failure {
  @override
  List<Object?> get props => [];
}

class EmptyResultFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class UnexpectedFailure extends Failure {
  @override
  List<Object?> get props => [];
}

@Deprecated('Use EmptyResultFailure')
typedef NullDatasource = EmptyResultFailure;

@Deprecated('Use UnexpectedFailure')
typedef DatasourceFailure = UnexpectedFailure;
