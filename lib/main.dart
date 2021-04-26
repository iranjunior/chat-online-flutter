import 'dart:async';

import 'package:chat_online/provider/config.dart';
import 'package:chat_online/provider/message.dart';
import 'package:chat_online/provider/user.dart';
import 'package:chat_online/screens/splash/page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserProvider(context)),
      ChangeNotifierProvider(create: (context) => MessageProvider(context)),
      ChangeNotifierProvider(create: (context) => ConfigProvider()),
      ],
    child: const EntryPage(),
  ));
}

class EntryPage extends StatelessWidget {
  const EntryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Analytics Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.green,
      ),
      home: SplashScreenPage(),
    );
  }
}
