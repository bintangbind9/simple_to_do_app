import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<User> signInWithGoogle({String? idToken});

  Future<Exception?> signOut();

  Future<User?> getCurrentSignedInUser();

  String? getCurrentSignedInUserEmail();

  bool isUserSignedIn();

  Future<void> sendEmailVerification();

  Future<void> sendPasswordResetEmail({required String toEmail});
}
