
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

    return Placeholder();
  }
}
