import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'my_styles.dart';
import 'app_state.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pageExited = true;
    super.dispose();
  }

  bool pageExited = false;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Login to your account", style: TextStyle(fontSize: 22)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                //username input
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: 'Username/Email',
                      contentPadding:
                          const EdgeInsets.only(left: 18, right: 18),
                      border: OutlineInputBorder(),
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid username or email address';
                      } else {
                        setState(() {});
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                //password input
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      contentPadding:
                          const EdgeInsets.only(left: 18, right: 18),
                      border: OutlineInputBorder(),
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid password';
                      } else {
                        setState(() {});
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                //submission button
                Center(
                  child: ElevatedButton(
                    style: MyButtonStyles.rectButton(context, 20, 100,
                        Theme.of(context).colorScheme.primary),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var url = Uri.http(appState.serverURL, '/login');

                        var attemptResponse = await appState.attemptLogin(
                            usernameController.text,
                            passwordController.text,
                            url);

                        if (!pageExited) {
                          setState(() {
                            if (appState.isLoggedIn()) {
                              Navigator.pop(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginForm()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(attemptResponse!)));
                            }
                          });
                        }
                      }
                    },
                    child: Text('Login', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
