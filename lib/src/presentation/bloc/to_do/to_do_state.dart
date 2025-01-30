part of 'to_do_bloc.dart';

@immutable
sealed class ToDoState {
  final List<ToDo> toDos;
  final bool isLoading;
  final String? loadingText;
  final Exception? exception;

  const ToDoState({
    this.toDos = const [],
    required this.isLoading,
    this.loadingText,
    this.exception,
  });
}

final class ToDoInitial extends ToDoState {
  const ToDoInitial({required super.isLoading});
}

final class ToDoLoading extends ToDoState {
  const ToDoLoading({
    required super.isLoading,
    super.loadingText,
  });
}

final class ToDoSuccess extends ToDoState {
  const ToDoSuccess({
    required super.isLoading,
    required super.toDos,
  });
}

final class ToDoFailure extends ToDoState {
  const ToDoFailure({
    required super.isLoading,
    required super.exception,
  });
}
