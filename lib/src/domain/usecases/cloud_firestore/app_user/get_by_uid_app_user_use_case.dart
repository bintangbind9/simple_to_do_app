import 'package:get_it/get_it.dart' show GetIt;

import '../../../entities/cloud_firestore/app_user.dart';
import '../../../repositories/cloud_firestore/app_user_repository.dart';
import '../../use_case.dart';

class GetByUidAppUserUseCase implements UseCase<Future<AppUser>, String> {
  final appUserRepository = GetIt.I<AppUserRepository>();

  @override
  Future<AppUser> call(String uid) async {
    return await appUserRepository.getByUid(uid: uid);
  }
}
