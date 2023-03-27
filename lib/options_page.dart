
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_styles.dart';
import 'misc_widgets.dart';
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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          AlignedText(
            text: 'Account',
            alignment: Alignment.centerLeft,
            style: MyTextStyles.titleMedium(context),
          ),
          AlignedBar(width: 300),
          AccountPage(loginState: appState.isLoggedIn()),
          AlignedText(
              text: "Accessibility",
              alignment: Alignment.centerLeft,
              style: MyTextStyles.titleMedium(context)),
          AlignedBar(width: 300),
          AccessibilityPage(),
        ],
      ),
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
          SizedBox(height: 10),
          OptionButton(
              label: 'Log out',
              onPressed: () {
                appState.logout();
              })
        ],
      );
    }
  }
}

class AccessibilityPage extends StatelessWidget {
  const AccessibilityPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlignedText(
        text: 'Something will eventually be here.',
        alignment: Alignment.centerLeft);
  }
}

class OptionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const OptionButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey),
          bottom: BorderSide(color: Colors.grey),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: AlignedText(
              text: label,
              style: MyTextStyles.bold(context, 18),
              alignment: Alignment.centerLeft,
            ),
          ),
        ),
      ),
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
