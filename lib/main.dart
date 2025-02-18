import 'dart:async' show runZonedGuarded;
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart' show GetIt;

import 'firebase_options.dart';
import 'src/common/locator.dart';
import 'src/data/firebase/firebase_messaging_service.dart';
import 'src/presentation/app.dart';
import 'src/presentation/bloc/auth/auth_bloc.dart';
import 'src/presentation/bloc/auth/equal_password_validation/equal_password_validation_bloc.dart';
import 'src/presentation/bloc/to_do/to_do_bloc.dart';

void main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
      setupLocator();

      await GetIt.I<FirebaseMessagingService>().initNotifications();

      runApp(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthBloc(),
            ),
            BlocProvider(
              create: (context) => EqualPasswordValidationBloc(),
            ),
            BlocProvider(
              create: (context) => ToDoBloc(),
            ),
          ],
          child: const App(),
        ),
      );
    },
    (error, stack) => dev.log(
      error.toString(),
      error: error,
      stackTrace: stack,
    ),
  );
}
