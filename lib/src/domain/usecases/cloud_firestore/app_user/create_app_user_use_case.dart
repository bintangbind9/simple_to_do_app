import 'package:get_it/get_it.dart' show GetIt;

import '../../../entities/cloud_firestore/app_user.dart';
import '../../../repositories/cloud_firestore/app_user_repository.dart';
import '../../use_case.dart';

class CreateAppUserUseCase implements UseCase<Future<AppUser>, AppUser> {
  final appUserRepository = GetIt.I<AppUserRepository>();

  @override
  Future<AppUser> call(AppUser appUser) async {
    return await appUserRepository.create(appUser: appUser);
  }
}
