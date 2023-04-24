import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_styles.dart';
import 'my_widgets.dart';
import 'app_state.dart';
import 'dart:math';
import 'login.dart';

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
        SizedBox(height: 20),
        FeatureTitle('Account', textSize: 22, spacing: 5),
        AccountPage(loginState: appState.isLoggedIn()),
        SizedBox(height: 20),
        FeatureTitle('Debug options', textSize: 22, spacing: 5),
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
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AlignedText(
              text: 'You are not logged in. Log in to view account details.',
              alignment: Alignment.centerLeft,
            ),
          ),
          WideButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginForm()),
              );
            },
            label: 'Log in',
            textStyle: MyTextStyles.bold(context, 18),
            textAlign: Alignment.centerLeft,
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AlignedText(
              text: 'Hello, ${appState.retrieveUsername()}!',
              alignment: Alignment.centerLeft,
            ),
          ),
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AlignedText(
            alignment: Alignment.centerLeft,
            text: 'Edit server url (current: ${appState.serverURL})',
            style: MyTextStyles.bold(context, 16),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
