part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class CreateUserWithEmailAndPassword extends AuthEvent {
  final CreateUserWithEmailAndPasswordParams params;
  CreateUserWithEmailAndPassword({required this.params});
}

class SignInWithEmailAndPassword extends AuthEvent {
  final SignInWithEmailAndPasswordParams params;
  SignInWithEmailAndPassword({required this.params});
}

class SignInWithGoogle extends AuthEvent {
  final String? idToken;
  SignInWithGoogle({this.idToken});
}

class SignOut extends AuthEvent {}

class GetCurrentSignedInUser extends AuthEvent {}

class RegisteringAccount extends AuthEvent {}
