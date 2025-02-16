import 'package:get_it/get_it.dart' show GetIt;

import '../data/firebase/cloud_firestore/app_user_service.dart';
import '../data/firebase/cloud_firestore/to_do_service.dart';
import '../data/firebase/firebase_service.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../data/repositories/cloud_firestore/app_user_repository_impl.dart';
import '../data/repositories/cloud_firestore/to_do_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/repositories/cloud_firestore/app_user_repository.dart';
import '../domain/repositories/cloud_firestore/to_do_repository.dart';
import '../domain/usecases/auth/create_user_with_email_and_password_use_case.dart';
import '../domain/usecases/auth/get_current_signed_in_user_email_use_case.dart';
import '../domain/usecases/auth/get_current_signed_in_user_use_case.dart';
import '../domain/usecases/auth/is_user_signed_in_use_case.dart';
import '../domain/usecases/auth/send_email_verification_use_case.dart';
import '../domain/usecases/auth/send_password_reset_email_use_case.dart';
import '../domain/usecases/auth/sign_in_with_email_and_password_use_case.dart';
import '../domain/usecases/auth/sign_in_with_google_use_case.dart';
import '../domain/usecases/auth/sign_out_use_case.dart';
import '../domain/usecases/cloud_firestore/app_user/create_app_user_use_case.dart';
import '../domain/usecases/cloud_firestore/app_user/delete_app_user_use_case.dart';
import '../domain/usecases/cloud_firestore/app_user/get_all_app_user_use_case.dart';
import '../domain/usecases/cloud_firestore/app_user/get_all_by_email_app_user_use_case.dart';
import '../domain/usecases/cloud_firestore/app_user/get_app_user_use_case.dart';
import '../domain/usecases/cloud_firestore/app_user/get_by_uid_app_user_use_case.dart';
import '../domain/usecases/cloud_firestore/app_user/get_by_uids_app_user_use_case.dart';
import '../domain/usecases/cloud_firestore/app_user/stream_get_all_app_user_use_case.dart';
import '../domain/usecases/cloud_firestore/app_user/stream_get_by_uid_app_user_use_case.dart';
import '../domain/usecases/cloud_firestore/app_user/stream_get_by_uids_app_user_use_case.dart';
import '../domain/usecases/cloud_firestore/app_user/update_app_user_use_case.dart';
import '../domain/usecases/cloud_firestore/todo/create_to_do_use_case.dart';
import '../domain/usecases/cloud_firestore/todo/delete_to_do_use_case.dart';
import '../domain/usecases/cloud_firestore/todo/get_all_to_do_use_case.dart';
import '../domain/usecases/cloud_firestore/todo/get_to_do_use_case.dart';
import '../domain/usecases/cloud_firestore/todo/stream_get_all_to_do_use_case.dart';
import '../domain/usecases/cloud_firestore/todo/update_to_do_use_case.dart';
import 'utils/loading/loading_screen.dart';

void setupLocator() {
  _registerCommons();
  _registerServices();
  _registerRepositories();
  _registerAuthUseCases();
  _registerAppUserUseCases();
  _registerTodoUseCases();
}

void _registerCommons() {
  GetIt.I.registerLazySingleton(() => LoadingScreen());
}

void _registerServices() {
  GetIt.I.registerLazySingleton(() => FirebaseService());
  GetIt.I.registerLazySingleton(() => AppUserService());
  GetIt.I.registerLazySingleton(() => ToDoService());
}

void _registerRepositories() {
  GetIt.I.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  GetIt.I
      .registerLazySingleton<AppUserRepository>(() => AppUserRepositoryImpl());
  GetIt.I.registerLazySingleton<ToDoRepository>(() => ToDoRepositoryImpl());
}

void _registerAuthUseCases() {
  GetIt.I.registerLazySingleton(() => CreateUserWithEmailAndPasswordUseCase());
  GetIt.I.registerLazySingleton(() => SignInWithEmailAndPasswordUseCase());
  GetIt.I.registerLazySingleton(() => SignInWithGoogleUseCase());
  GetIt.I.registerLazySingleton(() => SignOutUseCase());
  GetIt.I.registerLazySingleton(() => GetCurrentSignedInUserUseCase());
  GetIt.I.registerLazySingleton(() => GetCurrentSignedInUserEmailUseCase());
  GetIt.I.registerLazySingleton(() => IsUserSignedInUseCase());
  GetIt.I.registerLazySingleton(() => SendEmailVerificationUseCase());
  GetIt.I.registerLazySingleton(() => SendPasswordResetEmailUseCase());
}

void _registerAppUserUseCases() {
  GetIt.I.registerLazySingleton(() => CreateAppUserUseCase());
  GetIt.I.registerLazySingleton(() => DeleteAppUserUseCase());
  GetIt.I.registerLazySingleton(() => GetAllAppUserUseCase());
  GetIt.I.registerLazySingleton(() => GetAllByEmailAppUserUseCase());
  GetIt.I.registerLazySingleton(() => StreamGetAllAppUserUseCase());
  GetIt.I.registerLazySingleton(() => GetAppUserUseCase());
  GetIt.I.registerLazySingleton(() => GetByUidAppUserUseCase());
  GetIt.I.registerLazySingleton(() => StreamGetByUidAppUserUseCase());
  GetIt.I.registerLazySingleton(() => GetByUidsAppUserUseCase());
  GetIt.I.registerLazySingleton(() => StreamGetByUidsAppUserUseCase());
  GetIt.I.registerLazySingleton(() => UpdateAppUserUseCase());
}

void _registerTodoUseCases() {
  GetIt.I.registerLazySingleton(() => CreateToDoUseCase());
  GetIt.I.registerLazySingleton(() => DeleteToDoUseCase());
  GetIt.I.registerLazySingleton(() => GetToDoUseCase());
  GetIt.I.registerLazySingleton(() => GetAllToDoUseCase());
  GetIt.I.registerLazySingleton(() => StreamGetAllToDoUseCase());
  GetIt.I.registerLazySingleton(() => UpdateToDoUseCase());
}
