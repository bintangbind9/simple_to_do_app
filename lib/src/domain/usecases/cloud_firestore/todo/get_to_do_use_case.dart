import 'package:get_it/get_it.dart';

import '../../../entities/cloud_firestore/to_do.dart';
import '../../../repositories/cloud_firestore/to_do_repository.dart';
import '../../use_case.dart';

class GetToDoUseCase implements UseCase<Future<ToDo>, String> {
  final toDoRepository = GetIt.I<ToDoRepository>();

  @override
  Future<ToDo> call(String docId) async {
    return await toDoRepository.get(docId: docId);
  }
}
