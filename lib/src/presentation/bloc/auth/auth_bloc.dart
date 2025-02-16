import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:meta/meta.dart';

import '../../../domain/entities/cloud_firestore/app_user.dart';
import '../../../domain/usecases/auth/create_user_with_email_and_password_use_case.dart';
import '../../../domain/usecases/auth/get_current_signed_in_user_use_case.dart';
import '../../../domain/usecases/auth/sign_in_with_email_and_password_use_case.dart';
import '../../../domain/usecases/auth/sign_in_with_google_use_case.dart';
import '../../../domain/usecases/auth/sign_out_use_case.dart';
import '../../../domain/usecases/cloud_firestore/app_user/stream_get_by_uid_app_user_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitial(isLoading: false)) {
    final streamGetByUidAppUserUseCase =
        GetIt.I<StreamGetByUidAppUserUseCase>();

    on<CreateUserWithEmailAndPassword>((event, emit) async {
      emit(const AuthRegistering(isLoading: true));

      final createUserWithEmailAndPasswordUseCase =
          GetIt.I<CreateUserWithEmailAndPasswordUseCase>();

      try {
        final user =
            await createUserWithEmailAndPasswordUseCase.call(event.params);

        emit(AuthNeedsVerification(
          user: user,
          streamAppUser: streamGetByUidAppUserUseCase.call(user.uid),
          isLoading: false,
        ));
      } on Exception catch (e) {
        emit(AuthRegistering(isLoading: false, exception: e));
      }
    });

    on<SignInWithEmailAndPassword>((event, emit) async {
      emit(const AuthSignedOut(isLoading: true));

      final signInWithEmailAndPasswordUseCase =
          GetIt.I<SignInWithEmailAndPasswordUseCase>();

      try {
        final user = await signInWithEmailAndPasswordUseCase.call(event.params);

        if (user.emailVerified) {
          emit(AuthSignedIn(
            user: user,
            streamAppUser: streamGetByUidAppUserUseCase.call(user.uid),
            isLoading: false,
          ));
        } else {
          emit(AuthNeedsVerification(
            user: user,
            streamAppUser: streamGetByUidAppUserUseCase.call(user.uid),
            isLoading: false,
          ));
        }
      } on Exception catch (e) {
        emit(AuthSignedOut(isLoading: false, exception: e));
      }
    });

    on<SignInWithGoogle>((event, emit) async {
      emit(const AuthSignedOut(isLoading: true));

      final signInWithGoogleUseCase = GetIt.I<SignInWithGoogleUseCase>();

      try {
        final user = await signInWithGoogleUseCase.call(event.idToken);

        if (user.emailVerified) {
          emit(AuthSignedIn(
            user: user,
            streamAppUser: streamGetByUidAppUserUseCase.call(user.uid),
            isLoading: false,
          ));
        } else {
          emit(AuthNeedsVerification(
            user: user,
            streamAppUser: streamGetByUidAppUserUseCase.call(user.uid),
            isLoading: false,
          ));
        }
      } on Exception catch (e) {
        emit(AuthSignedOut(isLoading: false, exception: e));
      }
    });

    on<SignOut>((event, emit) async {
      final signOutUseCase = GetIt.I<SignOutUseCase>();
      final exception = await signOutUseCase.call(null);

      final getCurrentSignedInUserUseCase =
          GetIt.I<GetCurrentSignedInUserUseCase>();
      final user = await getCurrentSignedInUserUseCase.call(null);

      if (user == null) {
        emit(const AuthSignedOut(isLoading: false));
      } else {
        // Tidak berhasil sign out
        if (user.emailVerified) {
          emit(AuthSignedIn(
            user: user,
            streamAppUser: streamGetByUidAppUserUseCase.call(user.uid),
            isLoading: false,
            exception: exception,
          ));
        } else {
          emit(AuthNeedsVerification(
            user: user,
            streamAppUser: streamGetByUidAppUserUseCase.call(user.uid),
            isLoading: false,
            exception: exception,
          ));
        }
      }
    });

    on<GetCurrentSignedInUser>((event, emit) async {
      try {
        final getCurrentSignedInUserUseCase =
            GetIt.I<GetCurrentSignedInUserUseCase>();
        final user = await getCurrentSignedInUserUseCase.call(null);

        if (user == null) {
          emit(const AuthSignedOut(isLoading: false));
        } else {
          if (user.emailVerified) {
            emit(AuthSignedIn(
              user: user,
              streamAppUser: streamGetByUidAppUserUseCase.call(user.uid),
              isLoading: false,
            ));
          } else {
            emit(AuthNeedsVerification(
              user: user,
              streamAppUser: streamGetByUidAppUserUseCase.call(user.uid),
              isLoading: false,
            ));
          }
        }
      } on Exception catch (e) {
        emit(AuthSignedOut(isLoading: false, exception: e));
      }
    });

    on<RegisteringAccount>((event, emit) {
      emit(const AuthRegistering(isLoading: false));
    });
  }
}
