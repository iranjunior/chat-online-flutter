import 'package:chat_online/model/user.dart';
import 'package:chat_online/provider/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class DrawerApp extends StatelessWidget {
  const DrawerApp({
    Key key
  }) :super(key: key);


  @override
  Widget build(BuildContext context) {
    UserApp _user = context.read<UserProvider>().user;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
              leading: Container(
                child: CircleAvatar(
                  radius: 32.0,
                  backgroundColor: Colors.amber,
                  backgroundImage: NetworkImage(_user.photo),
                ),
              ),
              title: Text(
                _user.name,
                style: TextStyle(fontSize: 12),
              ),
              subtitle: Text(
                _user.email,
                style: TextStyle(fontSize: 12),
              ),
              trailing: IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () => Provider.of<UserProvider>(context, listen: false).logout(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}