import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

    return CalendarSelectionScreen();
  }
}

class CalendarSelectionScreen extends StatelessWidget {
  //look into making this variable obsolete please. some kind of auto-spacing
  //widget
  final double buttonSpacing = 30;

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyle(
        fontSize: 50,
        fontFamily: 'Helvetica',
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 85, 56, 136));
    TextStyle buttonTextStyle = TextStyle(
      fontSize: 42,
      fontFamily: 'Helvetica',
    );
    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      primary: Theme.of(context).colorScheme.secondary,
      onPrimary: Colors.white,
      shadowColor: Theme.of(context).colorScheme.outline,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      minimumSize: Size(360, 120),
    );

    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(66),
            child: Text('Event Calendars', style: titleStyle),
          ),
          ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarFirstYear()),
                );
              },
              child: Text(
                'First Year',
                style: buttonTextStyle,
              )),
          SizedBox(height: buttonSpacing),
          ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarUpperYear()),
                );
              },
              child: Text(
                'Upper Year',
                style: buttonTextStyle,
              ))
        ],
      ),
    );
  }
}

class CalendarFirstYear extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BackButton(),
      ],
    );
  }
}

class CalendarUpperYear extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BackButton(),
      ],
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      primary: Theme.of(context).colorScheme.secondary,
      onPrimary: Colors.white,
      shadowColor: Theme.of(context).colorScheme.outline,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      minimumSize: Size(50, 50),
    );

    return ElevatedButton.icon(
      style: buttonStyle,
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back),
      label: Text('Back'),
    );
  }
}
