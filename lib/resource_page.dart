import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

/*Learning resources stuff.  Should mostly be links. */
class ResourcePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    return GlobDisplay();
  }
}
