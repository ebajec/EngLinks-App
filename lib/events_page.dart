//import 'dart:html';

//import 'dart:html';
//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'my_styles.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:basic_utils/basic_utils.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

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
  final double buttonSpacing = 30;

  @override
  Widget build(BuildContext context) {
    TextStyle buttonTextStyle = MyTextStyles.buttonLarge(context);
    ButtonStyle buttonStyle = MyButtonStyles.buttonStyleLarge(context);

    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(66),
            child: Text('Event Calendars',
                style: MyTextStyles.titleMedium(context)),
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

class CalendarFirstYear extends StatefulWidget {
  @override
  _CalendarFirstYearState createState() => _CalendarFirstYearState();
}

class _CalendarFirstYearState extends State<CalendarFirstYear> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'First Year events',
          style: MyTextStyles.appBarLarge(context),
        ),
      ),
      body: TableCalendar(
        firstDay: DateTime.utc(2023, 1, 1),
        lastDay: DateTime.utc(2023, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          // Use `selectedDayPredicate` to determine which day is currently selected.
          // If this returns true, then `day` will be marked as selected.

          // Using `isSameDay` is recommended to disregard
          // the time-part of compared DateTime objects.
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            // Call `setState()` when updating the selected day
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            // Call `setState()` when updating calendar format
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}

class CalendarUpperYear extends StatefulWidget {
  @override
  _CalendarUpperYearState createState() => _CalendarUpperYearState();
}

class _CalendarUpperYearState extends State<CalendarUpperYear> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upper Year events',
          style: MyTextStyles.appBarLarge(context),
        ),
      ),
      body: TableCalendar(
        firstDay: DateTime.utc(2023, 1, 1),
        lastDay: DateTime.utc(2023, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
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
    );
  }
}
