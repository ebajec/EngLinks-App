import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
* Global application state.  Only add stuff to this which will need to be shared
between all parts of the app.  This will mostly be stuff like login info and
user settings.  Other information pertaining to the state of particular pages 
should be contained within the state of that page.
*/
class AppState extends ChangeNotifier {
  int glob = 5;
  void setGlob(int x) {
    glob = x;
  }
}

class GlobDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Text(appState.glob.toString()),
      ),
    );
  }
}
