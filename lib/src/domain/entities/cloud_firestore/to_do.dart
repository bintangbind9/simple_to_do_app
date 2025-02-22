import 'package:cloud_firestore/cloud_firestore.dart';

import 'cloud_firestore_entity.dart';

const String todoAppUserUid = 'appUserUid';
const String todoTitle = 'title';
const String todoTimestamp = 'timestamp';
const String todoReminderAt = 'reminderAt';
const String todoIsDone = 'isDone';

class ToDo extends CloudFirestoreEntity {
  final String appUserUid;
  final String title;
  final Timestamp timestamp;
  final DateTime reminderAt;
  final bool isDone;

  ToDo({
    super.docId,
    super.docRef,
    required this.appUserUid,
    required this.title,
    required this.timestamp,
    required this.reminderAt,
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
        reminderAt: (json[todoReminderAt] as Timestamp).toDate(),
        isDone: json[todoIsDone] ?? false,
        createdAt: json[cloudFirestoreEntityCreatedAt],
        createdBy: json[cloudFirestoreEntityCreatedBy],
        updatedAt: json[cloudFirestoreEntityUpdatedAt],
        updatedBy: json[cloudFirestoreEntityUpdatedBy],
        deletedAt: json[cloudFirestoreEntityDeletedAt],
        deletedBy: json[cloudFirestoreEntityDeletedBy],
      );

  Map<String, dynamic> toJson({required bool isUpdate}) {
    final todoMap = {
      todoAppUserUid: appUserUid,
      todoTitle: title,
      todoTimestamp: timestamp,
      todoReminderAt: reminderAt,
      todoIsDone: isDone,
    };

    if (isUpdate) {
      return {...todoMap, ...super.toJsonUpdate()};
    }

    return {...todoMap, ...super.toJsonCreate()};
  }

  ToDo copyWith({
    String? docId,
    DocumentReference<Map<String, dynamic>>? docRef,
    String? appUserUid,
    String? title,
    Timestamp? timestamp,
    DateTime? reminderAt,
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
        reminderAt: reminderAt ?? this.reminderAt,
        isDone: isDone ?? this.isDone,
        createdAt: createdAt ?? this.createdAt,
        createdBy: createdBy ?? this.createdBy,
        updatedAt: updatedAt ?? this.updatedAt,
        updatedBy: updatedBy ?? this.updatedBy,
        deletedAt: deletedAt ?? this.deletedAt,
        deletedBy: deletedBy ?? this.deletedBy,
      );
}
