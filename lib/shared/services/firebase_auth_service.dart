import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:onfly/firebase_options.dart';

class FirebaseAuthService {
  static final FirebaseAuthService _instance = FirebaseAuthService._internal();
  FirebaseAuthService._internal();

  factory FirebaseAuthService() {
    return _instance;
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void checkAuthentication({required BuildContext context}) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed('/Login');
      } else {
        Navigator.of(context).pushReplacementNamed('/HomePage');
      }
    });
  }
}
