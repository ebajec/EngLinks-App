
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

/* This page shouldn't be much, just a general description of app features. */
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            'Our Services',
            style: TextStyle(
                fontSize: 40,
                color: Colors.purple,
                fontWeight: FontWeight.w900),
          ),
          Icon(Icons.school),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
                'EngLinks offers one-on-one tutoring from experienced peers at competitive rates. Take your academic performance to the next level. '),
          ),
          Icon(Icons.settings),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
                'Workshops are offered in select courses during midterm and exam periods to review key concepts and solidify understanding of course material. Click below to explore eligible courses. '),
          ),
          Icon(Icons.book),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
                'EngLinks offers quality educational resources to students at no charge. This includes a textbook library located in the ILC, workbooks and online resources to help students study.'),
          ),
        ],
      ),
    );;
  }
}
