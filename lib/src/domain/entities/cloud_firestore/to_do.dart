import 'package:cloud_firestore/cloud_firestore.dart';

import 'cloud_firestore_entity.dart';

const String todoAppUserUid = 'appUserUid';
const String todoTitle = 'title';
const String todoTimestamp = 'timestamp';
const String todoIsDone = 'isDone';

class ToDo extends CloudFirestoreEntity {
  final String appUserUid;
  final String title;
  final Timestamp timestamp;
  final bool isDone;

  ToDo({
    super.docId,
    super.docRef,
    required this.appUserUid,
    required this.title,
    required this.timestamp,
    this.isDone = false,
    super.createdAt,
    super.createdBy,
    super.updatedAt,
    super.updatedBy,
    super.deletedAt,
    super.deletedBy,
  });

  factory ToDo.fromJson(
    String docId,
    Map<String, dynamic> json,
    DocumentReference<Map<String, dynamic>> docRef,
  ) =>
      ToDo(
        docId: docId,
        docRef: docRef,
        appUserUid: json[todoAppUserUid],
        title: json[todoTitle],
        timestamp: json[todoTimestamp],
        isDone: json[todoIsDone] ?? false,
        createdAt: json[cloudFirestoreEntityCreatedAt],
        createdBy: json[cloudFirestoreEntityCreatedBy],
        updatedAt: json[cloudFirestoreEntityUpdatedAt],
        updatedBy: json[cloudFirestoreEntityUpdatedBy],
        deletedAt: json[cloudFirestoreEntityDeletedAt],
        deletedBy: json[cloudFirestoreEntityDeletedBy],
      );

  Map<String, dynamic> toJson() => {
        todoAppUserUid: appUserUid,
        todoTitle: title,
        todoTimestamp: timestamp,
        todoIsDone: isDone,
      };

  ToDo copyWith({
    String? docId,
    DocumentReference<Map<String, dynamic>>? docRef,
    String? appUserUid,
    String? title,
    Timestamp? timestamp,
    bool? isDone,
    Timestamp? createdAt,
    String? createdBy,
    Timestamp? updatedAt,
    String? updatedBy,
    Timestamp? deletedAt,
    String? deletedBy,
  }) =>
      ToDo(
        docId: docId ?? this.docId,
        docRef: docRef ?? this.docRef,
        appUserUid: appUserUid ?? this.appUserUid,
        title: title ?? this.title,
        timestamp: timestamp ?? this.timestamp,
        isDone: isDone ?? this.isDone,
        createdAt: createdAt ?? this.createdAt,
        createdBy: createdBy ?? this.createdBy,
        updatedAt: updatedAt ?? this.updatedAt,
        updatedBy: updatedBy ?? this.updatedBy,
        deletedAt: deletedAt ?? this.deletedAt,
        deletedBy: deletedBy ?? this.deletedBy,
      );
}
