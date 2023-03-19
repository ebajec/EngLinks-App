import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'my_styles.dart';
import 'app_state.dart';

class AccountInfo {
  AccountInfo();

  String? _username;

  String? retrieveName() {
    return _username;
  }

  //Updates account info fields after validating with server. Returns message
  //with information about login attempt.
  //
  //Server must
  Future<String> update(
      String username, String password, Uri validatorUrl) async {
    Map<String, String> temp = {'username': username, 'password': password};

    String accountInfoTicket = json.encode(temp);
    try {
      //We should encrypt this

      var response = await http.post(validatorUrl, body: accountInfoTicket);

      Map<String, bool> responseInfo = json.decode(response.body);

      bool passwordCheck = responseInfo['passwordCheck']!;
      bool usernameCheck = responseInfo['usernameCheck']!;

      if (passwordCheck == false && usernameCheck == false) {
        return 'invalid username and password';
      }
      if (usernameCheck == false) {
        return 'Invalid username';
      }
      if (passwordCheck == false) {
        return 'Invalid username';
      }

      _username = username;

      return 'Login successful!';
    } catch (e) {
      return 'Unable to contact login server';
    }
  }
}

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
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //title
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.only(
                    left: 18, right: 18, top: 15, bottom: 0),
                child: Text("Login to your account",
                    style: TextStyle(fontSize: 22)),
              ),
            ),

            //username input
            Padding(
              padding: EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 0),
              child: TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: 'Username/Email',
                  contentPadding: const EdgeInsets.only(left: 18, right: 18),
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

            //password input
            Padding(
              padding: const EdgeInsets.only(
                  left: 25, right: 25, top: 15, bottom: 15),
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  contentPadding: const EdgeInsets.only(left: 18, right: 18),
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

            //submission button
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(bottom: 15),
              child: SizedBox(
                height: 40,
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var url = Uri.http('google.com', '/bigpenisman');

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Attempting to log in...')),
                      );

                      var attemptResponse = await appState.accountInfo.update(
                          usernameController.text,
                          passwordController.text,
                          url);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(attemptResponse)),
                      );
                    }
                  },
                  style: MyButtonStyles.buttonStyleLarge(context),
                  child: const Text('Login'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
