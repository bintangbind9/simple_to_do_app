import '../../entities/cloud_firestore/app_user.dart';

abstract class AppUserRepository {
  Future<void> delete({required String docId});

  Future<void> update({
    required String docId,
    required AppUser appUser,
  });

  Future<AppUser> get({required String docId});

  Future<AppUser> getByUid({required String uid});

  Stream<AppUser?> streamGetByUid({required String uid});

  Future<Iterable<AppUser>> getAllByEmail({required String email});

  Future<Iterable<AppUser>> getByUids({required List<String> uids});

  Future<Iterable<AppUser>> getAll();

  Stream<Iterable<AppUser>> streamGetByUids({required List<String> uids});

  Stream<Iterable<AppUser>> streamGetAll();

  Future<AppUser> create({required AppUser appUser});
}
