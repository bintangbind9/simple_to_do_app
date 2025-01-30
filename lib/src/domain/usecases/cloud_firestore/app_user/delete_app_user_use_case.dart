import 'package:get_it/get_it.dart' show GetIt;

import '../../../repositories/cloud_firestore/app_user_repository.dart';
import '../../use_case.dart';

class DeleteAppUserUseCase implements UseCase<Future<void>, String> {
  final appUserRepository = GetIt.I<AppUserRepository>();

  @override
  Future<void> call(String docId) async {
    return await appUserRepository.delete(docId: docId);
  }
}
