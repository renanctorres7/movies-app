import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class InvalidSearchText extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class NullDatasource extends Failure {
  @override
  List<Object?> get props => [];
}

class DatasourceFailure extends Failure {
  @override
  List<Object?> get props => [];
}
