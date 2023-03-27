import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

const generalFailureMessage = 'Oops, somethings wrong. Please try again!';
const serverFailureMessage = 'Oops, API got error. Please try again!';
const badRequestedFailureMessage = 'Oops, payload error. Please try again!';

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

String mapFailureToMessage(Failure exception) {
  switch (exception.runtimeType) {
    case GeneralFailure:
      return generalFailureMessage;
    case ServerFailure:
      return serverFailureMessage;
    case BadRequestFailure:
      return badRequestedFailureMessage;
    default:
      return generalFailureMessage;
  }
}
