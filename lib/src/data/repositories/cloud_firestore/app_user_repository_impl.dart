import 'package:get_it/get_it.dart' show GetIt;

import '../../../domain/entities/cloud_firestore/app_user.dart';
import '../../../domain/repositories/cloud_firestore/app_user_repository.dart';
import '../../firebase/cloud_firestore/app_user_service.dart';

class AppUserRepositoryImpl implements AppUserRepository {
  final appUserService = GetIt.I<AppUserService>();

  @override
  Future<AppUser> create({required AppUser appUser}) async {
    return await appUserService.create(appUser: appUser);
  }

  @override
  Future<void> delete({required String docId}) async {
    return await appUserService.delete(docId: docId);
  }

  @override
  Future<AppUser> get({required String docId}) async {
    return await appUserService.get(docId: docId);
  }

  @override
  Stream<Iterable<AppUser>> streamGetAll() {
    return appUserService.streamGetAll();
  }

  @override
  Future<AppUser> getByUid({required String uid}) async {
    return await appUserService.getByUid(uid: uid);
  }

  @override
  Stream<AppUser?> streamGetByUid({required String uid}) {
    return appUserService.streamGetByUid(uid: uid);
  }

  @override
  Future<Iterable<AppUser>> getAllByEmail({required String email}) async {
    return await appUserService.getAllByEmail(email: email);
  }

  @override
  Future<Iterable<AppUser>> getAll() async {
    return await appUserService.getAll();
  }

  @override
  Future<Iterable<AppUser>> getByUids({required List<String> uids}) async {
    return await appUserService.getByUids(uids: uids);
  }

  @override
  Stream<Iterable<AppUser>> streamGetByUids({required List<String> uids}) {
    return appUserService.streamGetByUids(uids: uids);
  }

  @override
  Future<void> update({
    required String docId,
    required AppUser appUser,
  }) async {
    return await appUserService.update(
      docId: docId,
      appUser: appUser,
    );
  }
}
