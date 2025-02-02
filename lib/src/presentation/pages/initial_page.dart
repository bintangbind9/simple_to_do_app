import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart' show GetIt;

import '../../common/utils/loading/loading_screen.dart';
import '../bloc/auth/auth_bloc.dart';
import 'auth/login_page.dart';
import 'auth/register_page.dart';
import 'to_do_page.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AuthBloc>().add(GetCurrentSignedInUser());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
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
      builder: (context, state) {
        if (state is AuthSignedOut) {
          return const LoginPage();
        } else if (state is AuthSignedIn || state is AuthNeedsVerification) {
          return TodoPage(title: 'To Do List');
        } else if (state is AuthRegistering) {
          return const RegisterPage();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
      },
    );
  }
}
