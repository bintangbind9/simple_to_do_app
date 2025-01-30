import 'package:get_it/get_it.dart' show GetIt;

import '../../../entities/cloud_firestore/app_user.dart';
import '../../../repositories/cloud_firestore/app_user_repository.dart';
import '../../use_case.dart';

class UpdateAppUserUseCase
    implements UseCase<Future<void>, UpdateAppUserParams> {
  final appUserRepository = GetIt.I<AppUserRepository>();

  @override
  Future<void> call(UpdateAppUserParams params) async {
    return await appUserRepository.update(
      docId: params.docId,
      appUser: params.appUser,
    );
  }
}

class UpdateAppUserParams {
  final String docId;
  final AppUser appUser;
  UpdateAppUserParams({
    required this.docId,
    required this.appUser,
  });
}
