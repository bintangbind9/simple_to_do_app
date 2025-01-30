import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart' show GetIt;

import '../../repositories/auth_repository.dart';
import '../use_case.dart';

class CreateUserWithEmailAndPasswordUseCase
    implements UseCase<Future<User>, CreateUserWithEmailAndPasswordParams> {
  final authRepository = GetIt.I<AuthRepository>();

  @override
  Future<User> call(CreateUserWithEmailAndPasswordParams params) async {
    return await authRepository.createUserWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class CreateUserWithEmailAndPasswordParams {
  final String email;
  final String password;
  CreateUserWithEmailAndPasswordParams({
    required this.email,
    required this.password,
  });
}
