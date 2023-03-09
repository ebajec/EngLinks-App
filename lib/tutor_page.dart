import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

/* Tutoring page will need to have input boxes for the user and a button to send
the tutor request.  In _TutorPageState, before the build() method, some control 
flow will need to assess whether or not the user is logged in. */
class TutorPage extends StatefulWidget {
  @override
  State<TutorPage> createState() => _TutorPageState();
}

class _TutorPageState extends State<TutorPage> {
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
