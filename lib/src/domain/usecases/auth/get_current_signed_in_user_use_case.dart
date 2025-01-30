import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart' show GetIt;

import '../../repositories/auth_repository.dart';
import '../use_case.dart';

class GetCurrentSignedInUserUseCase implements UseCase<Future<User?>, void> {
  final authRepository = GetIt.I<AuthRepository>();

  @override
  Future<User?> call(void params) async {
    return await authRepository.getCurrentSignedInUser();
  }
}
