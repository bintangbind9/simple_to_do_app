part of 'equal_password_validation_bloc.dart';

@immutable
sealed class EqualPasswordValidationEvent {}

class UpdateEqualPasswordValidation extends EqualPasswordValidationEvent {
  final String password;
  UpdateEqualPasswordValidation({required this.password});
}
