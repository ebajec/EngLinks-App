import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'events_page.dart';
import 'tutor_page.dart';
import 'resource_page.dart';
import 'options_page.dart';

/*
* Global application state.  Only add stuff to this which will need to be shared
between all parts of the app.  This will mostly be stuff like login info and
user settings.  Other information pertaining to the state of a particular page 
should be contained within the state of that page.
*/
class AppState extends ChangeNotifier {}

List<double> SizeQuery(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return [width, height];
}
