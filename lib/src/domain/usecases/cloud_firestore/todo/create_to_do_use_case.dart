import 'package:get_it/get_it.dart' show GetIt;

import '../../../entities/cloud_firestore/to_do.dart';
import '../../../repositories/cloud_firestore/to_do_repository.dart';
import '../../use_case.dart';

class CreateToDoUseCase implements UseCase<Future<ToDo>, ToDo> {
  final toDoRepository = GetIt.I<ToDoRepository>();

  @override
  Future<ToDo> call(ToDo toDo) async {
    return await toDoRepository.create(toDo: toDo);
  }
}
