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

    return GlobDisplay();
  }
}
