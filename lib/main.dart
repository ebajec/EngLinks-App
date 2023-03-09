import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'home_page.dart';
import 'events_page.dart';
import 'tutor_page.dart';
import 'resource_page.dart';
import 'options_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'EngLinks App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: MainDisplay(),
      ),
    );
  }
}

/* Main display of the app, including the bottom navigation bar and 
the selected page.  This is the widget which will be displayed for the user at 
all times while using the app.  
*/
class MainDisplay extends StatefulWidget {
  @override
  State<MainDisplay> createState() => _MainDisplayState();
}

class _MainDisplayState extends State<MainDisplay> {
  int _selectedIndex = 0;

  var pages = <Widget>[
    HomePage(),
    EventsPage(),
    TutorPage(),
    ResourcePage(),
    OptionsPage()
  ];

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    Widget page;

    try {
      page = pages[_selectedIndex];
    } catch (e) {
      throw UnimplementedError('no widget for $_selectedIndex');
    }

    void onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: const Text("EngLinks"),
      )),
      body: page,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Tutoring',
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
        selectedItemColor: Colors.purple[800],
        unselectedItemColor: Color.fromARGB(255, 150, 104, 170),
        onTap: onItemTapped,
      ),
    );
  }
}
