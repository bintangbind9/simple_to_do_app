import 'package:get_it/get_it.dart' show GetIt;

import '../../../entities/cloud_firestore/app_user.dart';
import '../../../repositories/cloud_firestore/app_user_repository.dart';
import '../../use_case.dart';

class GetAllByEmailAppUserUseCase
    implements UseCase<Future<Iterable<AppUser>>, String> {
  final appUserRepository = GetIt.I<AppUserRepository>();

  @override
  Future<Iterable<AppUser>> call(String email) async {
    return await appUserRepository.getAllByEmail(email: email);
  }
}
