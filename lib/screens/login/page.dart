import 'package:chat_online/provider/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Card(
            color: Colors.grey[200],
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(fontSize: 20.0),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  SignInButton(
                    Buttons.Google,
                    text: "Login com o Google",
                    onPressed: () =>
                        context.read<UserProvider>().signInWithGoogle(context),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  SignInButton(
                    Buttons.Facebook,
                    text: "Login com o Facebook",
                    onPressed: () => context
                        .read<UserProvider>()
                        .signInWithFacebook(context),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Stack(
                    children: [
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ou',
                            style: TextStyle(backgroundColor: Colors.grey[200]),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        isDense: true,
                        border: const OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)))),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Senha',
                        isDense: true,
                        border: const OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)))),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Logar'),
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(260, 40)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
