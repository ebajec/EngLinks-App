import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_styles.dart';
import 'misc_widgets.dart';
import 'app_state.dart';

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

    return Column(
      children: <Widget>[
        AccountPage(loginState: appState.isLoggedIn()),
        AccessibilityPage(),
      ],
    );
  }
}

class AccountPage extends StatelessWidget {
  const AccountPage({
    required this.loginState,
    super.key,
  });

  final bool loginState;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    return Column(
      children: [
        AlignedText(
          text: 'Account',
          alignment: Alignment.centerLeft,
          style: MyTextStyles.titleMedium(context),
        ),
        if (!loginState)
          AlignedText(
            text: 'You are not logged in. Log in to view account details.',
            alignment: Alignment.centerLeft,
          )
        else
          Text('hello ${appState.accountInfo.retrieveName()}!'),
      ],
    );
  }
}

class AccessibilityPage extends StatelessWidget {
  const AccessibilityPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlignedText(
        text: "Accessibility Settings",
        alignment: Alignment.centerLeft,
        style: MyTextStyles.titleMedium(context));
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
