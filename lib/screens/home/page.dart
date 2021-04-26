import 'package:chat_online/model/message.dart';
import 'package:chat_online/screens/home/widgets/body.dart';
import 'package:chat_online/screens/home/widgets/drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Private'),
      ),
      drawer: DrawerApp(),
      body: BodyApp(),
    );
  }
}
