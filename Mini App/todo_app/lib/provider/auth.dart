import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/utils/nav_helper.dart';
import 'package:todo_app/utils/notif_helper.dart';
import 'package:todo_app/view/home.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool isLoading = false;

  Stream<User?> get streamAuthStatus => _auth.authStateChanges();

  Future<UserCredential?> signInWithGoogle() async {
    try {
      isLoading = true;
      notifyListeners();
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      isLoading = false;
      notifyListeners();
      Nav.toAll(const HomePage());
      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e, st) {
      if (kDebugMode) {
        isLoading = false;
        notifyListeners();
        log(st.toString());
      }
      log(e.toString());
      isLoading = false;
      notifyListeners();
      NotifUtils.showSnackbar(e.toString(), backgroundColor: Colors.red);
    }
    return null;
  }

  Future<void> logOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
