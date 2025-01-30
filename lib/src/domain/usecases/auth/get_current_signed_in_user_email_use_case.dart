import 'package:get_it/get_it.dart' show GetIt;

import '../../repositories/auth_repository.dart';
import '../use_case.dart';

class GetCurrentSignedInUserEmailUseCase implements UseCase<String?, void> {
  final authRepository = GetIt.I<AuthRepository>();

  @override
  String? call(void params) {
    return authRepository.getCurrentSignedInUserEmail();
  }
}
