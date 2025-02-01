import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../common/constants/app_constants.dart';
import '../../../common/exceptions/cloud_firestore/cloud_firestore_exception.dart';
import '../../../common/exceptions/cloud_firestore/user_exceptions.dart';
import '../../../domain/entities/cloud_firestore/app_user.dart';
import 'cloud_firestore_constants.dart';

class AppUserService {
  final users = FirebaseFirestore.instance.collection(
    CloudFirestoreConstants.usersCollection,
  );

  Future<void> delete({required String docId}) async {
    try {
      await users.doc(docId).delete();
    } catch (e) {
      throw CouldNotDeleteUserException();
    }
  }

  Future<void> update({
    required String docId,
    required AppUser appUser,
  }) async {
    try {
      await users.doc(docId).update(appUser.toJson());
    } catch (e) {
      throw CouldNotUpdateUserException();
    }
  }

  Future<AppUser> get({required String docId}) async {
    try {
      final doc = await users.doc(docId).get();
      if (doc.data() != null) {
        return AppUser.fromJson(doc.id, doc.data()!, doc.reference);
      } else {
        throw UserNotFoundException();
      }
    } catch (e) {
      throw CouldNotGetUserException();
    }
  }

  Future<AppUser> getByUid({required String uid}) async {
    try {
      final query = await users.where(appUserUid, isEqualTo: uid).get();
      final appUser = query.docs
          .map((doc) => AppUser.fromJson(doc.id, doc.data(), doc.reference))
          .singleOrNull;
      if (appUser != null) {
        return appUser;
      } else {
        throw UserNotFoundException();
      }
    } on CloudFirestoreException {
      rethrow;
    } catch (e) {
      throw CouldNotGetUserException();
    }
  }

  Future<Iterable<AppUser>> getAllByEmail({required String email}) async {
    try {
      email = email.trim();
      if (email.isEmpty) return [];

      email = email.toLowerCase();

      final query = await users
          .orderBy(appUserEmail)
          .startAt([email])
          .endAt(['$email\uf8ff'])
          .limit(AppConstants.searchLimit)
          .get();
      final appUsers =
          query.docs.map((e) => AppUser.fromJson(e.id, e.data(), e.reference));
      return appUsers;
    } catch (e) {
      throw CouldNotGetAllUsersException();
    }
  }

  Future<Iterable<AppUser>> getByUids({required List<String> uids}) async {
    if (uids.isEmpty) return [];

    final query = await users.where(appUserUid, whereIn: uids).get();
    return query.docs.map(
      (doc) => AppUser.fromJson(doc.id, doc.data(), doc.reference),
    );
  }

  Future<Iterable<AppUser>> getAll() async {
    final query = await users.get();
    return query.docs.map(
      (doc) => AppUser.fromJson(doc.id, doc.data(), doc.reference),
    );
  }

  Stream<Iterable<AppUser>> streamGetByUids({required List<String> uids}) {
    if (uids.isEmpty) return Stream.value([]);

    return users.where(appUserUid, whereIn: uids).snapshots().map((query) =>
        query.docs
            .map((doc) => AppUser.fromJson(doc.id, doc.data(), doc.reference)));
  }

  Stream<Iterable<AppUser>> streamGetAll() =>
      users.snapshots().map((query) => query.docs
          .map((doc) => AppUser.fromJson(doc.id, doc.data(), doc.reference)));

  Future<AppUser> create({required AppUser appUser}) async {
    try {
      final document = await users.add(appUser.toJson());
      final fetchedDoc = await document.get();
      return AppUser.fromJson(
          fetchedDoc.id, fetchedDoc.data()!, fetchedDoc.reference);
    } catch (e) {
      throw CouldNotCreateUserException();
    }
  }
}
