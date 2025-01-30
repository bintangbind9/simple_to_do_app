import '../../entities/cloud_firestore/to_do.dart';

abstract class ToDoRepository {
  Future<void> delete({required String docId});

  Future<void> update({
    required String docId,
    required ToDo toDo,
  });

  Future<ToDo> get({required String docId});

  Future<Iterable<ToDo>> getAll({required String appUserUid});

  Stream<Iterable<ToDo>> streamGetAll({required String appUserUid});

  Future<ToDo> create({required ToDo toDo});
}
