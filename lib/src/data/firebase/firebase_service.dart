import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../common/exceptions/auth_exceptions.dart';

class FirebaseService {
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = await getCurrentSignedInUser();
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else {
        throw GenericAuthException();
      }
    } on Exception catch (_) {
      rethrow;
    } catch (e) {
      throw GenericAuthException();
    }
  }

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = await getCurrentSignedInUser();
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        throw InvalidUserCredentialAuthException();
      } else if (e.code == 'invalid-credential') {
        throw InvalidUserCredentialAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (e) {
      throw GenericAuthException();
    }
  }

  Future<User> signInWithGoogle({String? idToken}) async {
    try {
      GoogleSignInAccount? googleUser;
      GoogleSignInAuthentication? googleAuth;

      // idToken is not null mean: signInWithGoogle from Web
      // idToken is null mean: signInWithGoogle not from Web
      if (idToken == null) {
        // Trigger the authentication flow
        googleUser = await GoogleSignIn().signIn();

        // Obtain the auth details from the request
        googleAuth = await googleUser?.authentication;
      }

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: idToken == null ? googleAuth?.accessToken : null,
        idToken: idToken ?? googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredentialResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredentialResult.user;

      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on Exception catch (_) {
      rethrow;
    } catch (e) {
      debugPrint('Error signInWithGoogle $e');
      throw GenericAuthException();
    }
  }

  Future<Exception?> signOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseAuth.instance.signOut();
        await GoogleSignIn().signOut();
        return null;
      } catch (e, stackTrace) {
        if (kDebugMode) {
          print('Error signOut: $e, $stackTrace');
        }
        return SignOutFailedAuthException();
      }
    } else {
      return UserNotLoggedInAuthException();
    }
  }

  Future<User?> getCurrentSignedInUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await user.reload();
        return user;
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  String? getCurrentSignedInUserEmail() {
    return FirebaseAuth.instance.currentUser?.email;
  }

  bool isUserSignedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<void> sendEmailVerification() async {
    final user = await getCurrentSignedInUser();
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  Future<void> sendPasswordResetEmail({required String toEmail}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: toEmail);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'firebase_auth/invalid-email':
          throw InvalidEmailAuthException();
        case 'firebase_auth/user-not-found':
          throw UserNotFoundAuthException();
        default:
          throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }
}
