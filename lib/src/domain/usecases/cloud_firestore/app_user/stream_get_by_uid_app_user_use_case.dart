import 'package:get_it/get_it.dart' show GetIt;

import '../../../entities/cloud_firestore/app_user.dart';
import '../../../repositories/cloud_firestore/app_user_repository.dart';
import '../../use_case.dart';

class StreamGetByUidAppUserUseCase
    implements UseCase<Stream<AppUser?>, String> {
  final appUserRepository = GetIt.I<AppUserRepository>();

  @override
  Stream<AppUser?> call(String uid) {
    return appUserRepository.streamGetByUid(uid: uid);
  }
}
