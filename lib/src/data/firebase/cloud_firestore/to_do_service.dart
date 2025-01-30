import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../common/exceptions/cloud_firestore/to_do_exceptions.dart';
import '../../../domain/entities/cloud_firestore/to_do.dart';
import 'cloud_firestore_constants.dart';

class ToDoService {
  final todos = FirebaseFirestore.instance.collection(
    CloudFirestoreConstants.toDosCollection,
  );

  Future<void> delete({required String docId}) async {
    try {
      await todos.doc(docId).delete();
    } catch (e) {
      throw CouldNotDeleteToDoException();
    }
  }

  Future<void> update({
    required String docId,
    required ToDo toDo,
  }) async {
    try {
      await todos.doc(docId).update(toDo.toJson(isUpdate: true));
    } catch (e) {
      throw CouldNotUpdateToDoException();
    }
  }

  Future<ToDo> get({required String docId}) async {
    try {
      final doc = await todos.doc(docId).get();
      if (doc.data() != null) {
        return ToDo.fromJson(doc.id, doc.data()!, doc.reference);
      } else {
        throw ToDoNotFoundException();
      }
    } catch (e) {
      throw CouldNotGetToDoException();
    }
  }

  Future<Iterable<ToDo>> getAll(String appUserUid) async {
    try {
      final query = await todos
          .where(todoAppUserUid, isEqualTo: appUserUid)
          .orderBy(todoTimestamp, descending: true)
          .get();
      return query.docs.map(
        (doc) => ToDo.fromJson(doc.id, doc.data(), doc.reference),
      );
    } catch (e) {
      throw CouldNotGetAllToDosException();
    }
  }

  Stream<Iterable<ToDo>> streamGetAll(String appUserUid) {
    return todos
        .where(todoAppUserUid, isEqualTo: appUserUid)
        .orderBy(todoTimestamp, descending: true)
        .snapshots()
        .map((query) => query.docs.map(
              (doc) => ToDo.fromJson(doc.id, doc.data(), doc.reference),
            ));
  }

  Future<ToDo> create({required ToDo toDo}) async {
    try {
      final document = await todos.add(toDo.toJson(isUpdate: false));
      final fetchedDoc = await document.get();
      return ToDo.fromJson(
        fetchedDoc.id,
        fetchedDoc.data()!,
        fetchedDoc.reference,
      );
    } catch (e) {
      throw CouldNotCreateToDoException();
    }
  }
}
