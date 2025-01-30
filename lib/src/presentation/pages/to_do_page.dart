import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show SchedulerBinding;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart' show GetIt;

import '../../common/utils/loading/loading_screen.dart';
import '../../domain/entities/cloud_firestore/app_user.dart';
import '../../domain/entities/cloud_firestore/to_do.dart';
import '../../domain/usecases/cloud_firestore/todo/stream_get_all_to_do_use_case.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/to_do/to_do_bloc.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key, required this.title});

  final String title;

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _controller = TextEditingController();
  final _streamGetAllToDoUseCase = GetIt.I<StreamGetAllToDoUseCase>();

  void _addTodo() {
    if (_controller.text.isNotEmpty) {
      toDoBloc.add(ToDoAdd(ToDo(
        title: _controller.text,
        appUserUid: currentUser.uid,
        timestamp: Timestamp.now(),
      )));
      _controller.clear();
    }
  }

  AuthBloc get authBloc => context.read<AuthBloc>();
  ToDoBloc get toDoBloc => context.read<ToDoBloc>();

  AppUser get currentUser => authBloc.state.appUser!;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _streamGetAllToDoUseCase.call(currentUser.uid).listen((todos) {
        toDoBloc.add(ToDoSet(todos.toList()));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          GetIt.I<LoadingScreen>().show(
            context: context,
            text: state.loadingText ?? 'Please wait...',
          );
        } else {
          GetIt.I<LoadingScreen>().hide();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: [
            IconButton(
              onPressed: () => authBloc.add(SignOut()),
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                top: 16.0,
                right: 16.0,
              ),
              child: Text(
                'Signed as: ${currentUser.name}',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                spacing: 16,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Add new task',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _addTodo,
                    child: const Text('Add'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<ToDoBloc, ToDoState>(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state.toDos.length,
                    itemBuilder: (context, index) {
                      final todo = state.toDos[index];
                      return ListTile(
                        title: Text(todo.title),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () =>
                              toDoBloc.add(ToDoDelete(todo.docId!)),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
