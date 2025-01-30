import 'package:get_it/get_it.dart' show GetIt;

import '../../../entities/cloud_firestore/app_user.dart';
import '../../../repositories/cloud_firestore/app_user_repository.dart';
import '../../use_case.dart';

class StreamGetAllAppUserUseCase
    implements UseCase<Stream<Iterable<AppUser>>, void> {
  final appUserRepository = GetIt.I<AppUserRepository>();

  @override
  Stream<Iterable<AppUser>> call(void params) {
    return appUserRepository.streamGetAll();
  }
}
