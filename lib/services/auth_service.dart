import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  Future signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
      final currentUser = FirebaseAuth.instance.currentUser;

      final isExist = await FirebaseFirestore.instance
          .collection('/users')
          .doc(currentUser!.uid)
          .get();
      if (isExist.exists) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .set({
          "email": currentUser.email,
          "name": currentUser.displayName ?? "No Name",
          'keys': isExist.data()!['keys'],
          'last_message_text': isExist.data()!['last_message_text'],
        });
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .set({
          "email": currentUser.email,
          "name": currentUser.displayName ?? "No Name",
          'keys': {},
          'last_message_text': "",
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  Future verifyEmail() async {
    String message = '';
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (!user!.emailVerified) {
        await user.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      message = e.code;
    } finally {
      // ignore: control_flow_in_finally
      return message;
    }
  }

  Future<bool> isAuthed() async {
    User? auth = FirebaseAuth.instance.currentUser;
    if (auth != null) {
      return true;
    } else {
      return false;
    }
  }

  Future resetPassword(String email) async {
    String message = '';
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        message = 'User is not found.';
      }
    } finally {
      // ignore: control_flow_in_finally
      return message;
    }
  }
}
