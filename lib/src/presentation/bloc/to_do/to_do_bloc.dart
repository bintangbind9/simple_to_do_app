import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:meta/meta.dart';

import '../../../domain/entities/cloud_firestore/to_do.dart';
import '../../../domain/usecases/cloud_firestore/todo/create_to_do_use_case.dart';
import '../../../domain/usecases/cloud_firestore/todo/delete_to_do_use_case.dart';
import '../../../domain/usecases/cloud_firestore/todo/update_to_do_use_case.dart';

part 'to_do_event.dart';
part 'to_do_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  ToDoBloc() : super(ToDoInitial(isLoading: true)) {
    on<ToDoAdd>((event, emit) async {
      emit(ToDoLoading(isLoading: true, loadingText: 'Adding todo...'));

      try {
        final createToDoUseCase = GetIt.I<CreateToDoUseCase>();
        await createToDoUseCase.call(event.toDo);
        emit(ToDoSuccess(
          isLoading: false,
          toDos: List<ToDo>.from(state.toDos),
        ));
      } on Exception catch (e) {
        emit(ToDoFailure(isLoading: false, exception: e));
      }
    });

    on<ToDoDelete>((event, emit) async {
      emit(ToDoLoading(isLoading: true, loadingText: 'Delete todo...'));

      try {
        final deleteToDoUseCase = GetIt.I<DeleteToDoUseCase>();
        await deleteToDoUseCase.call(event.id);
        emit(ToDoSuccess(
          isLoading: false,
          toDos: List<ToDo>.from(state.toDos),
        ));
      } on Exception catch (e) {
        emit(ToDoFailure(isLoading: false, exception: e));
      }
    });

    on<ToDoUpdate>((event, emit) async {
      emit(ToDoLoading(isLoading: true, loadingText: 'Updating todo...'));

      try {
        final updateToDoUseCase = GetIt.I<UpdateToDoUseCase>();
        await updateToDoUseCase.call(
          UpdateToDoParams(
            docId: event.id,
            toDo: event.toDo,
          ),
        );
        emit(ToDoSuccess(
          isLoading: false,
          toDos: List<ToDo>.from(state.toDos),
        ));
      } on Exception catch (e) {
        emit(ToDoFailure(isLoading: false, exception: e));
      }
    });

    on<ToDoSet>((event, emit) {
      emit(ToDoSuccess(
        isLoading: state.isLoading,
        toDos: event.toDos,
      ));
    });
  }
}
