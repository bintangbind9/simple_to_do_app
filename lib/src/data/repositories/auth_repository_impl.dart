import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart' show GetIt;

import '../../domain/repositories/auth_repository.dart';
import '../firebase/firebase_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final firebaseService = GetIt.I<FirebaseService>();

  @override
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await firebaseService.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await firebaseService.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<User?> getCurrentSignedInUser() async {
    return await firebaseService.getCurrentSignedInUser();
  }

  @override
  String? getCurrentSignedInUserEmail() {
    return firebaseService.getCurrentSignedInUserEmail();
  }

  @override
  bool isUserSignedIn() {
    return firebaseService.isUserSignedIn();
  }

  @override
  Future<User> signInWithGoogle({String? idToken}) async {
    return await firebaseService.signInWithGoogle(idToken: idToken);
  }

  @override
  Future<Exception?> signOut() async {
    return await firebaseService.signOut();
  }

  @override
  Future<void> sendEmailVerification() async {
    return await firebaseService.sendEmailVerification();
  }

  @override
  Future<void> sendPasswordResetEmail({required String toEmail}) async {
    return await firebaseService.sendPasswordResetEmail(toEmail: toEmail);
  }
}
