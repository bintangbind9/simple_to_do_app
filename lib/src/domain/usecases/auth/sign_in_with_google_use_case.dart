import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart' show GetIt;

import '../../repositories/auth_repository.dart';
import '../use_case.dart';

class SignInWithGoogleUseCase implements UseCase<Future<User>, String?> {
  final authRepository = GetIt.I<AuthRepository>();

  @override
  Future<User> call(String? idToken) async {
    return await authRepository.signInWithGoogle(idToken: idToken);
  }
}
