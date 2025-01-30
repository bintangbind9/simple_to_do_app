import 'package:get_it/get_it.dart';

import '../../../entities/cloud_firestore/to_do.dart';
import '../../../repositories/cloud_firestore/to_do_repository.dart';
import '../../use_case.dart';

class GetAllToDoUseCase implements UseCase<Future<Iterable<ToDo>>, String> {
  final toDoRepository = GetIt.I<ToDoRepository>();

  @override
  Future<Iterable<ToDo>> call(String appUserUid) async {
    return await toDoRepository.getAll(appUserUid: appUserUid);
  }
}
