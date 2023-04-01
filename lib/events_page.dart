import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'app_state.dart';
import 'event_data.dart';
import 'my_styles.dart';
import 'my_widgets.dart';

class CalendarSelectionScreen extends StatelessWidget {
  final double buttonWidth = 300;

  @override
  Widget build(BuildContext context) {
    TextStyle buttonTextStyle = MyTextStyles.buttonLarge(context);
    ButtonStyle buttonStyle = MyButtonStyles.rectButton(
        context, 32, buttonWidth, Theme.of(context).colorScheme.primary);

    var appState = context.watch<AppState>();

    Widget calendarIcon = Icon(
      Icons.calendar_month,
      color: Colors.white,
    );

    return Center(
      child: Column(
        children: [
          SizedBox(height: 20),
          FeatureTitle('Event Calendars', textSize: 26, spacing: 40),
          ElevatedButton(
            style: buttonStyle,
            onPressed: () {
              appState.retrieveEventData('first year');
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EventCalendar(
                          title: 'First year events',
                          eventType: 'first year',
                        )),
              );
            },
            child: IconTextLabel(
              'First year',
              width: buttonWidth,
              style: buttonTextStyle,
              icon: calendarIcon,
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            style: buttonStyle,
            onPressed: () {
              appState.retrieveEventData('upper year');
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EventCalendar(
                          title: 'Upper year events',
                          eventType: 'upper year',
                        )),
              );
            },
            child: IconTextLabel(
              'Upper year',
              width: buttonWidth,
              style: buttonTextStyle,
              icon: calendarIcon,
            ),
          )
        ],
      ),
    );
  }
}

class IconTextLabel extends StatelessWidget {
  const IconTextLabel(
    this.text, {
    super.key,
    required this.style,
    required this.icon,
    required this.width,
  });

  final double width;
  final TextStyle style;
  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                text,
                style: style,
              ),
            ),
          ),
          icon,
        ],
      ),
    );
  }
}

class EventCalendar extends StatefulWidget {
  final String eventType;
  final String title;
  EventCalendar({required this.eventType, required this.title});

  @override
  _EventCalendarState createState() => _EventCalendarState();
}

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventCalendarState extends State<EventCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Map<DateTime, List<Event>>? _events;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    _events = appState.events[widget.eventType];

    if (_events!.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            textAlign: TextAlign.center,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 160,
              child: MyImage(
                  assetImage: AssetImage("assets/broken_chain_icon.png")),
            ),
            AlignedText(
              text: 'Failed to load event data. \nRetry?',
              style: MyTextStyles.bold(context, 18),
              alignment: Alignment.center,
              textAlign: TextAlign.center,
            ),
            Center(
              child: IconButton(
                iconSize: 50,
                icon: Icon(
                  Icons.replay,
                  color: Colors.black,
                ),
                onPressed: () async {
                  appState.retrieveEventData(widget.eventType);
                },
              ),
            ),
            SizedBox(height: 150)
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.utc(2023, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            eventLoader: _getEventsForDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          Expanded(
            child: _selectedDay != null
                ? ListView.builder(
                    itemCount: _getEventsForDay(_selectedDay!).length,
                    itemBuilder: (BuildContext context, int index) {
                      Event event = _getEventsForDay(_selectedDay!)[index];
                      return ListTile(
                        title: Text(event.title),
                        leading: CircleAvatar(
                          backgroundColor: event.color,
                        ),
                      );
                    },
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events![day] ?? [];
  }
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    return CalendarSelectionScreen();
  }
}

/*
class CalendarUpperYear extends StatefulWidget {
  @override
  _CalendarUpperYearState createState() => _CalendarUpperYearState();
}

class _CalendarUpperYearState extends State<CalendarUpperYear> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Map<DateTime, List<Event>> _events = {
    //to add event do DateTime.utc(year, month, day): [Event('name of event:  short description \n time', Colors."any Colour")]
    //if you want to add an event to an existing day, in the [] add a comma
    DateTime.utc(2023, 4, 11): [
      Event('ELEC 274: Final WorkShop \n 6:30 PM - 9:30 PM', Colors.lightGreen)
    ],
    DateTime.utc(2023, 4, 13): [
      Event('ENPH 239: Final WorkShop \n 6:30 PM - 9:30 PM', Colors.lightGreen)
    ],
    DateTime.utc(2023, 4, 15): [
      Event('ELEC 252: Final WorkShop \n 6:30 PM - 9:30 PM', Colors.lightGreen)
    ],
    DateTime.utc(2023, 4, 17): [
      Event('CIVL 231: Final WorkShop \n 6:30 PM - 9:30 PM', Colors.lightGreen)
    ],
    DateTime.utc(2023, 4, 18): [
      Event('ENCH 245: Final Tutorial \n 1:00 PM - 4:00 PM', Colors.pink),
      Event('MECH 241: Final Workshop \n 1:00 PM - 4:00 PM', Colors.lightGreen)
    ],
  };

  List<Event> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    if (appState.events['upper year'] == null) {
      return Scaffold(
          appBar: AppBar(
            title: Text(
              'Upper Year events',
              textAlign: TextAlign.center,
            ),
          ),
          body: Column(
            children: [
              Text(
                'Failed to load calendar data :(',
                style: MyTextStyles.bold(context, 20),
              ),
              ElevatedButton(
                  onPressed: () async {
                    appState.retrieveEventData('first_year', server);
                  },
                  child: Text('Retry'))
            ],
          ));
    }
    _events = appState.events['upper year']!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upper Year events',
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.utc(2023, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            eventLoader: _getEventsForDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          Expanded(
            child: _selectedDay != null
                ? ListView.builder(
                    itemCount: _getEventsForDay(_selectedDay!).length,
                    itemBuilder: (BuildContext context, int index) {
                      Event event = _getEventsForDay(_selectedDay!)[index];
                      return ListTile(
                        title: Text(event.title),
                        leading: CircleAvatar(
                          backgroundColor: event.color,
                        ),
                      );
                    },
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
*/

/**
 * Map<DateTime, List<Event>> eventsFirst = {
  //to add event do DateTime.utc(year, month, day): [Event('name of event:  short description', Colors."any Colour")]
  //if you want to add an event to an existing day, in the [] add a comma
  DateTime.utc(2023, 4, 12): [
    Event('APSC 174: Final WorkShop [1] \n 11:00 AM - 2:00 PM', Colors.yellow)
  ],
  DateTime.utc(2023, 4, 13): [
    Event('APSC 174: Final WorkShop [2] \n 3:00 PM - 6:00 PM', Colors.yellow)
  ],
  DateTime.utc(2023, 4, 14): [
    Event(
        'APSC 112: Final WorkShop [1] \n 7:00 PM - 10:00 PM', Colors.lightBlue)
  ],
  DateTime.utc(2023, 4, 15): [
    Event(
        'APSC 112: Final WorkShop [2] \n 10:00 AM - 1:00 PM', Colors.lightBlue)
  ],
  DateTime.utc(2023, 4, 17): [
    Event('APSC 132: Final WorkShop \n 3:00 PM - 6:00 PM', Colors.teal)
  ],
  DateTime.utc(2023, 4, 18): [
    Event('APSC 162: Final WorkShop \n 10:00 AM - 1:00 PM', Colors.purple)
  ],
  DateTime.utc(2023, 4, 22): [
    Event('APSC 172: Final WorkShop \n 10:00 AM - 1:00 PM', Colors.orange)
  ],
};
 */
