import 'dart:async' show StreamSubscription;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show SchedulerBinding;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart' show GetIt;

import '../../common/constants/app_styles.dart';
import '../../common/utils/extensions/double_extension.dart';
import '../../common/utils/loading/loading_screen.dart';
import '../../domain/entities/cloud_firestore/app_user.dart';
import '../../domain/entities/cloud_firestore/to_do.dart';
import '../../domain/usecases/cloud_firestore/todo/stream_get_all_to_do_use_case.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/to_do/to_do_bloc.dart';
import '../widgets/todo_item.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key, required this.title});

  final String title;

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _controller = TextEditingController();
  final _streamGetAllToDoUseCase = GetIt.I<StreamGetAllToDoUseCase>();
  StreamSubscription<AppUser?>? _streamSubscriptionAppUser;
  AppUser? _currentAppUser;

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

  User get currentUser => authBloc.state.user!;
  Stream<AppUser?> get streamAppUser => authBloc.state.streamAppUser!;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _streamGetAllToDoUseCase.call(currentUser.uid).listen((todos) {
        toDoBloc.add(ToDoSet(todos.toList()));
      });
      _streamSubscriptionAppUser = streamAppUser
          .listen((appUser) => setState(() => _currentAppUser = appUser));
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
        backgroundColor: AppStyles.backgroundColor,
        appBar: AppBar(
          title: Text(widget.title),
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: AppStyles.backgroundColor,
          actions: [
            IconButton(
              onPressed: () => authBloc.add(SignOut()),
              icon: Icon(Icons.logout, color: AppStyles.errorColor),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: AppStyles.pagePadding,
            right: AppStyles.pagePadding,
            bottom: AppStyles.pagePadding,
          ),
          child: Column(
            children: [
              Container(
                color: AppStyles.backgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppStyles.pagePadding.sizedBoxHeight,
                    Text(
                      'Hi! ${_currentAppUser?.name ?? ''}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      'what do you want to do today?',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                    32.0.sizedBoxHeight,
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Add a task',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: AppStyles.textGrey),
                        prefixIcon: IconButton(
                            onPressed: _addTodo,
                            icon: Icon(Icons.add, color: AppStyles.textGrey)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: AppStyles.fillGrey,
                      ),
                      onEditingComplete: _addTodo,
                    ),
                    8.0.sizedBoxHeight,
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<ToDoBloc, ToDoState>(
                  builder: (context, state) {
                    return ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => 8.0.sizedBoxHeight,
                      itemCount: state.toDos.length,
                      itemBuilder: (context, index) {
                        final todo = state.toDos[index];
                        return TodoItem(
                          todo: todo,
                          onDelete: () => toDoBloc.add(ToDoDelete(todo.docId!)),
                          onCheckboxed: (value) {
                            toDoBloc.add(
                              ToDoUpdate(
                                todo.docId!,
                                todo.copyWith(isDone: value),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _streamSubscriptionAppUser?.cancel();
    super.dispose();
  }
}
