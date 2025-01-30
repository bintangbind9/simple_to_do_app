part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  final bool isLoading;
  final String? loadingText;
  final Exception? exception;
  final User? user;
  final AppUser? appUser;

  const AuthState({
    required this.isLoading,
    this.loadingText,
    this.exception,
    this.user,
    this.appUser,
  });
}

final class AuthInitial extends AuthState {
  const AuthInitial({required super.isLoading});
}

final class AuthSignedOut extends AuthState {
  const AuthSignedOut({
    required super.isLoading,
    super.loadingText,
    super.exception,
  });
}

final class AuthSignedIn extends AuthState {
  const AuthSignedIn({
    required super.user,
    required super.appUser,
    required super.isLoading,
    super.loadingText,
    super.exception,
  });
}

final class AuthNeedsVerification extends AuthState {
  const AuthNeedsVerification({
    required super.user,
    required super.appUser,
    required super.isLoading,
    super.loadingText,
    super.exception,
  });
}

final class AuthRegistering extends AuthState {
  const AuthRegistering({
    required super.isLoading,
    super.loadingText,
    super.exception,
  });
}
