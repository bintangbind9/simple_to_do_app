import 'package:get_it/get_it.dart' show GetIt;

import '../../repositories/auth_repository.dart';
import '../use_case.dart';

class SendEmailVerificationUseCase implements UseCase<Future<void>, void> {
  final authRepository = GetIt.I<AuthRepository>();

  @override
  Future<void> call(void params) async {
    return await authRepository.sendEmailVerification();
  }
}
