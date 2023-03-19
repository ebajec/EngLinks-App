import 'package:flutter/material.dart';
import 'login.dart';

/*
* Global application state.  Only add stuff to this which will need to be shared
between all parts of the app.  This will mostly be stuff like login info and
user settings.  Other information pertaining to the state of a particular page 
should be contained within the state of that page.
*/
class AppState extends ChangeNotifier {
  AccountInfo accountInfo = AccountInfo();

  bool isLoggedIn() {
    return accountInfo.retrieveName() != null;
  }
}

List<double> SizeQuery(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return [width, height];
}
