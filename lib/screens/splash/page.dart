import 'package:chat_online/provider/user.dart';
import 'package:chat_online/screens/home/page.dart';
import 'package:chat_online/screens/login/page.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatelessWidget {
  FirebaseAuth auth;
  SplashScreenPage() {
    auth = FirebaseAuth.instance;
  }

  Future<void> timeoutSpash(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));
    final _user = context.read<UserProvider>().user;
    if (_user == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: timeoutSpash(context),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return Container();
        } else {
          return Center(
            child: FlutterLogo(
              size: 200.0,
            ),
          );
        }
      },
    );
  }
}
