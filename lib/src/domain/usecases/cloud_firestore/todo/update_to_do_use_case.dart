import 'package:get_it/get_it.dart';

import '../../../entities/cloud_firestore/to_do.dart';
import '../../../repositories/cloud_firestore/to_do_repository.dart';
import '../../use_case.dart';

class UpdateToDoUseCase implements UseCase<Future<void>, UpdateToDoParams> {
  final toDoRepository = GetIt.I<ToDoRepository>();

  @override
  Future<void> call(UpdateToDoParams params) async {
    return await toDoRepository.update(
      docId: params.docId,
      toDo: params.toDo,
    );
  }
}

class UpdateToDoParams {
  final String docId;
  final ToDo toDo;
  UpdateToDoParams({
    required this.docId,
    required this.toDo,
  });
}
