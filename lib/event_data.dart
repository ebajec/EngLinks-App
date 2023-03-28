import 'package:flutter/material.dart';
import 'dart:convert';

class Event {
  final String title;
  final Color color;

  Event(this.title, this.color);
}

const Map<String, int> months = {
  'JAN': 1,
  'FEB': 2,
  'MAR': 3,
  'APR': 4,
  'MAY': 5,
  'JUN': 6,
  'JUL': 7,
  'AUG': 8,
  'SEP': 9,
  'OCT': 10,
  'NOV': 11,
  'DEC': 12
};

Map<DateTime, List<Event>> parseEventData(String data) {
  List tempData = json.decode(data);

  Map<DateTime, List<Event>> events = {};

  for (var eventData in tempData) {
    var date = DateTime.utc(eventData['year'] as int,
        months[eventData['month']?.toUpperCase()]!, eventData['date'] as int);

    String title = eventData['title']! + '\n' + eventData['time'];
    Color color;

    //workshops are blue just because
    if (title.toLowerCase().contains('workshop')) {
      color = Colors.blue;
    } else {
      color = Colors.yellow;
    }

    var event = Event(title, color);

    if (events.containsKey(date)) {
      events[date]?.add(event);
    } else {
      events[date] = [event];
    }
  }

  return events;
}
