import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'HomePage.dart';
import 'EventsPage.dart';
import 'TutorPage.dart';
import 'ResourcePage.dart';
import 'OptionsPage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    Widget page;

    switch (_selectedIndex) {
      case 0:
        page = HomePage();
        break;
      case 1:
        page = EventsPage();
        break;
      case 2:
        page = TutorPage();
        break;
      case 3:
        page = ResourcePage();
        break;
      case 4:
        page = OptionsPage();
        break;
      default:
        throw UnimplementedError('no widget for $_selectedIndex');
    }

    void onItemTapped(int index) {
      setState(() {
      _selectedIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Title")
        ),
        
      body: page,

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Resources',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: onItemTapped,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Placeholder();
  }
}

class EventsPage extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Placeholder();
  }
}

class TutorPage extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Placeholder();
  }
}

class ResourcePage extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Placeholder();
  }
}

class OptionsPage extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Placeholder();
  }
}

