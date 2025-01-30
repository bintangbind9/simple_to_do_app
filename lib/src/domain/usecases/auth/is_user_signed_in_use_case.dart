import 'package:get_it/get_it.dart' show GetIt;

import '../../repositories/auth_repository.dart';
import '../use_case.dart';

class IsUserSignedInUseCase implements UseCase<bool, void> {
  final authRepository = GetIt.I<AuthRepository>();

  @override
  bool call(void params) {
    return authRepository.isUserSignedIn();
  }
}
