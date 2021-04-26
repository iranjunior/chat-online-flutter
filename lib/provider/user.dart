import 'dart:async';

import 'package:chat_online/model/user.dart';
import 'package:chat_online/screens/home/page.dart';
import 'package:chat_online/screens/login/page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class UserProvider with ChangeNotifier {
  UserApp _user;

  UserProvider(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      login(UserApp.fromUserFirebase(FirebaseAuth.instance.currentUser));
    }
  }

  UserApp get user => _user;

  void login(UserApp user) {
    _user = user;
    notifyListeners();
  }

  void logout(BuildContext context) {
    FirebaseAuth.instance.signOut().then((_) {
      _user = null;
      notifyListeners();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => LoginPage()));
    });
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    if (googleAuth != null) {
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      FirebaseAuth.instance.signInWithCredential(credential).then((event) {
        login(UserApp.fromUserFirebase(event.user));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomePage()));
      });
    }
  }

  Future<void> signInWithFacebook(BuildContext context) async {
    final _fbLogin = FacebookAuth.instance;
    final result = await _fbLogin.login();
    if (result.token != null) {
      final FacebookAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(result.token);
      FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential)
          .then((event) {
        login(UserApp.fromUserFirebase(event.user));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomePage()));
      });
    }
  }
}
