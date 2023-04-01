import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_styles.dart';
import 'my_widgets.dart';
import 'app_state.dart';
import 'dart:math';

/*This should mostly just be accessibility options and login settings. */
class OptionsPage extends StatefulWidget {
  const OptionsPage({super.key});

  @override
  State<OptionsPage> createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: <Widget>[
        FeatureTitle('Account', textSize: 26),
        AccountPage(loginState: appState.isLoggedIn()),
        FeatureTitle('Debug options', textSize: 26),
        DebugPage(),
      ],
    );
  }
}

class AccountPage extends StatefulWidget {
  const AccountPage({
    required this.loginState,
    super.key,
  });

  final bool loginState;

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    if (!widget.loginState) {
      return AlignedText(
        text: 'You are not logged in. Log in to view account details.',
        alignment: Alignment.centerLeft,
      );
    } else {
      return Column(
        children: [
          WideButton(
              textStyle: MyTextStyles.bold(context, 18),
              textAlign: Alignment.centerLeft,
              label: 'Log out',
              onPressed: () {
                appState.logout();
              })
        ],
      );
    }
  }
}

class DebugPage extends StatefulWidget {
  const DebugPage({
    super.key,
  });

  @override
  State<DebugPage> createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  String? _serverUrl;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    var textFocusNode = FocusNode();

    return Column(
      children: [
        AlignedText(
          alignment: Alignment.centerLeft,
          text: 'Edit server url (current: ${appState.serverURL})',
          style: MyTextStyles.bold(context, 16),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 400,
            child: TextField(
              focusNode: textFocusNode,
              onChanged: (value) {
                _serverUrl = value;
              },
              onEditingComplete: () {
                if (_serverUrl != null && _serverUrl != '') {
                  appState.setServerURL(_serverUrl!);
                }
                textFocusNode.unfocus();
              },
              decoration: InputDecoration(
                labelText: 'Example: "localhost"',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



// Possibly useful unused code snippets VVV

/*
class DisplayLoginAndOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
/*
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username/Email',
                    hintText: 'Enter valid username or email address'),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
              child: TextField(

                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),

            Divider(
              color: Colors.black, //color of divider
              height: 5, //height spacing of divider
              thickness: 3, //thickness of divider line
              indent: 15, //spacing at the start of divider
              endIndent: 15, //spacing at the end of divider
            ),
*/
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 18, right: 18, top: 15, bottom: 0),
                child: Text("Accessibility Settings", style: TextStyle(fontSize: 22)),
              ),
            
            ),
          ],
        ),
      ),
    );
    
  }
}


return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),


      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.only(left:15.0,right: 15.0,top:5,bottom: 0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username/Email',
                    hintText: 'Enter valid username or email address'),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 20, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(

                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),

          ],
        ),
      ),
    );
*/
