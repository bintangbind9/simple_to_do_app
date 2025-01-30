part of 'to_do_bloc.dart';

@immutable
sealed class ToDoEvent {}

final class ToDoAdd extends ToDoEvent {
  final ToDo toDo;

  ToDoAdd(this.toDo);
}

final class ToDoDelete extends ToDoEvent {
  final String id;

  ToDoDelete(this.id);
}

final class ToDoUpdate extends ToDoEvent {
  final String id;
  final ToDo toDo;

  ToDoUpdate(this.id, this.toDo);
}

final class ToDoGet extends ToDoEvent {
  final String id;

  ToDoGet(this.id);
}

final class ToDoGetAll extends ToDoEvent {}

final class ToDoSet extends ToDoEvent {
  final List<ToDo> toDos;

  ToDoSet(this.toDos);
}
