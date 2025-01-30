import 'package:cloud_firestore/cloud_firestore.dart'
    show Timestamp, DocumentReference;
import 'package:get_it/get_it.dart' show GetIt;

import '../../../data/firebase/firebase_service.dart';

const String cloudFirestoreEntityCreatedAt = 'createdAt';
const String cloudFirestoreEntityCreatedBy = 'createdBy';
const String cloudFirestoreEntityUpdatedAt = 'updatedAt';
const String cloudFirestoreEntityUpdatedBy = 'updatedBy';
const String cloudFirestoreEntityDeletedAt = 'deletedAt';
const String cloudFirestoreEntityDeletedBy = 'deletedBy';

final firebaseService = GetIt.I<FirebaseService>();
const String unknownUser = 'unknown';

Map<String, dynamic> getCreatedMap() => {
      cloudFirestoreEntityCreatedAt: Timestamp.now(),
      cloudFirestoreEntityCreatedBy:
          firebaseService.getCurrentSignedInUserEmail() ?? unknownUser,
    };

Map<String, dynamic> getUpdatedMap() => {
      cloudFirestoreEntityUpdatedAt: Timestamp.now(),
      cloudFirestoreEntityUpdatedBy:
          firebaseService.getCurrentSignedInUserEmail() ?? unknownUser,
    };

abstract class CloudFirestoreEntity {
  final String? docId;
  final DocumentReference<Map<String, dynamic>>? docRef;
  final Timestamp? createdAt;
  final String? createdBy;
  final Timestamp? updatedAt;
  final String? updatedBy;
  final Timestamp? deletedAt;
  final String? deletedBy;

  CloudFirestoreEntity({
    this.docId,
    this.docRef,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.deletedAt,
    this.deletedBy,
  });

  bool get isDeleted => deletedAt == null ? false : true;

  Map<String, dynamic> get deletedMap => {
        cloudFirestoreEntityDeletedAt: deletedAt,
        cloudFirestoreEntityDeletedBy: isDeleted
            ? (firebaseService.getCurrentSignedInUserEmail() ?? unknownUser)
            : null,
      };

  Map<String, dynamic> toJsonCreate() => {
        ...getCreatedMap(),
        ...getUpdatedMap(),
        ...deletedMap,
      };

  Map<String, dynamic> toJsonUpdate() => {
        ...getUpdatedMap(),
        ...deletedMap,
      };
}
