import 'package:get_it/get_it.dart' show GetIt;

import '../../../domain/entities/cloud_firestore/to_do.dart';
import '../../../domain/repositories/cloud_firestore/to_do_repository.dart';
import '../../firebase/cloud_firestore/to_do_service.dart';

class ToDoRepositoryImpl implements ToDoRepository {
  final toDoService = GetIt.I<ToDoService>();

  @override
  Future<ToDo> create({required ToDo toDo}) async {
    return await toDoService.create(toDo: toDo);
  }

  @override
  Future<void> delete({required String docId}) async {
    return await toDoService.delete(docId: docId);
  }

  @override
  Future<ToDo> get({required String docId}) async {
    return await toDoService.get(docId: docId);
  }

  @override
  Future<Iterable<ToDo>> getAll({required String appUserUid}) async {
    return await toDoService.getAll(appUserUid);
  }

  @override
  Stream<Iterable<ToDo>> streamGetAll({required String appUserUid}) {
    return toDoService.streamGetAll(appUserUid);
  }

  @override
  Future<void> update({
    required String docId,
    required ToDo toDo,
  }) async {
    return await toDoService.update(
      docId: docId,
      toDo: toDo,
    );
  }
}
