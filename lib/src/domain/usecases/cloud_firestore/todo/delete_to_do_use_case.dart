import 'package:get_it/get_it.dart' show GetIt;

import '../../../repositories/cloud_firestore/to_do_repository.dart';
import '../../use_case.dart';

class DeleteToDoUseCase implements UseCase<Future<void>, String> {
  final toDoRepository = GetIt.I<ToDoRepository>();

  @override
  Future<void> call(String docId) async {
    return await toDoRepository.delete(docId: docId);
  }
}
