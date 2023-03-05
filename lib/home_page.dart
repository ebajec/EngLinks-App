import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

/* This page shouldn't be much, just a general description of app features. */
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _handleInput(String? input) {
    if (input != null) {
      try {
        int num = input as int;
      } catch (e) {
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
              decoration: InputDecoration(
                hintText: 'Type a number in here...',
              ),
              onSubmitted: (String value) async {
                String msgText, msgTitleText;
                try {
                  int x = int.parse(value);
                  setState(() {
                    appState.setGlob(x);
                  });
                  msgText = 'The number has been set to "$value".';
                  msgTitleText = 'Yay!';
                } catch (e) {
                  msgText = 'A number was not entered';
                  msgTitleText = 'Uh oh...';
                }

                await showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(msgTitleText),
                      content: Text(msgText),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              }),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
