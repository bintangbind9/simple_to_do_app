import 'package:get_it/get_it.dart';

import '../../../entities/cloud_firestore/to_do.dart';
import '../../../repositories/cloud_firestore/to_do_repository.dart';
import '../../use_case.dart';

class StreamGetAllToDoUseCase
    implements UseCase<Stream<Iterable<ToDo>>, String> {
  final toDoRepository = GetIt.I<ToDoRepository>();

  @override
  Stream<Iterable<ToDo>> call(String appUserUid) {
    return toDoRepository.streamGetAll(appUserUid: appUserUid);
  }
}
