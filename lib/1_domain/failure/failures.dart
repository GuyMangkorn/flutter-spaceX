import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class GeneralFailure extends Failure with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class BadRequestFailure extends Failure with EquatableMixin {
  @override
  List<Object?> get props => [];
}
