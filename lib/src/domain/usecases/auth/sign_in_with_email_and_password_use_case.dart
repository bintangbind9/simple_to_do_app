import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart' show GetIt;

import '../../repositories/auth_repository.dart';
import '../use_case.dart';

class SignInWithEmailAndPasswordUseCase
    implements UseCase<Future<User>, SignInWithEmailAndPasswordParams> {
  final authRepository = GetIt.I<AuthRepository>();

  @override
  Future<User> call(SignInWithEmailAndPasswordParams params) async {
    return await authRepository.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class SignInWithEmailAndPasswordParams {
  final String email;
  final String password;
  SignInWithEmailAndPasswordParams({
    required this.email,
    required this.password,
  });
}
