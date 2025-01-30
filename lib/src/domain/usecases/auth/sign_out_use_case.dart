import 'package:get_it/get_it.dart' show GetIt;

import '../../repositories/auth_repository.dart';
import '../use_case.dart';

class SignOutUseCase implements UseCase<Future<Exception?>, void> {
  final authRepository = GetIt.I<AuthRepository>();

  @override
  Future<Exception?> call(void params) async {
    return await authRepository.signOut();
  }
}
