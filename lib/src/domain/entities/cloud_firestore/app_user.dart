import 'package:cloud_firestore/cloud_firestore.dart' show DocumentReference;

import 'cloud_firestore_entity.dart';

const String appUserUid = 'uid';
const String appUserDisplayName = 'displayName';
const String appUserEmail = 'email';
const String appUserEmailVerified = 'emailVerified';
const String appUserIsAnonymous = 'isAnonymous';
const String appUserPhoneNumber = 'phoneNumber';
const String appUserPhotoURL = 'photoURL';

class AppUser extends CloudFirestoreEntity {
  final String uid;
  final String? displayName;
  final String email;
  final bool emailVerified;
  final bool isAnonymous;
  final String? phoneNumber;
  final String? photoURL;

  AppUser({
    super.docId,
    super.docRef,
    required this.uid,
    this.displayName,
    required this.email,
    required this.emailVerified,
    required this.isAnonymous,
    this.phoneNumber,
    this.photoURL,
    super.createdAt,
    super.createdBy,
    super.updatedAt,
    super.updatedBy,
    super.deletedAt,
    super.deletedBy,
  });

  String get name => displayName ?? email;

  factory AppUser.fromJson(
    String docId,
    Map<String, dynamic> json,
    DocumentReference<Map<String, dynamic>> docRef,
  ) =>
      AppUser(
        docId: docId,
        docRef: docRef,
        uid: json[appUserUid],
        displayName: json[appUserDisplayName],
        email: json[appUserEmail],
        emailVerified: json[appUserEmailVerified],
        isAnonymous: json[appUserIsAnonymous],
        phoneNumber: json[appUserPhoneNumber],
        photoURL: json[appUserPhotoURL],
        createdAt: json[cloudFirestoreEntityCreatedAt],
        createdBy: json[cloudFirestoreEntityCreatedBy],
        updatedAt: json[cloudFirestoreEntityUpdatedAt],
        updatedBy: json[cloudFirestoreEntityUpdatedBy],
        deletedAt: json[cloudFirestoreEntityDeletedAt],
        deletedBy: json[cloudFirestoreEntityDeletedBy],
      );

  Map<String, dynamic> toJson() => {
        appUserUid: uid,
        appUserDisplayName: displayName,
        appUserEmail: email,
        appUserEmailVerified: emailVerified,
        appUserIsAnonymous: isAnonymous,
        appUserPhoneNumber: phoneNumber,
        appUserPhotoURL: photoURL,
      };
}
