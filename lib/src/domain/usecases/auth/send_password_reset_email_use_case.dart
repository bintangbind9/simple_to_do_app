import 'package:get_it/get_it.dart' show GetIt;

import '../../repositories/auth_repository.dart';
import '../use_case.dart';

class SendPasswordResetEmailUseCase implements UseCase<Future<void>, String> {
  final authRepository = GetIt.I<AuthRepository>();

  @override
  Future<void> call(String toEmail) async {
    return await authRepository.sendPasswordResetEmail(toEmail: toEmail);
  }
}
