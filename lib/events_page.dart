import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

/* We'll have to import the table calendar library from pub.dev to get started 
here. */
class EventsPage extends StatefulWidget {
  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    return GlobDisplay();
  }
}
