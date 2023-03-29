import 'package:flutter/material.dart';
import 'login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'event_data.dart';

/*
* Global application state.  Only add stuff to this which will need to be shared
between all parts of the app.  This will mostly be stuff like login info and
user settings.  Other information pertaining to the state of a particular page 
should be contained within the state of that page.
*/
class AppState extends ChangeNotifier {
  String serverURL = 'localhost';

  bool loginNotifier = false;
  String? _username;

  Map<String, Map<DateTime, List<Event>>> events = {
    'first year': {},
    'upper year': {},
    'misc': {}
  };

  AppState() {
    retrieveEventData('first year');
    retrieveEventData('upper year');
  }

  void setServerURL(String url) {
    serverURL = url;
    notifyListeners();
  }

  Future<bool> retrieveEventData(String type) async {
    String filename;

    if (type == 'first year') {
      filename = 'events_first_year.txt';
    } else if (type == 'upper year') {
      filename = 'events_upper_year.txt';
    } else if (type == 'misc') {
      filename = 'events_misc.txt';
    } else {
      return false;
    }

    var url = Uri.http(serverURL, 'event_data/$filename');
    var response;

    try {
      response = await http.get(url);
    } catch (e) {
      return false;
    }

    var eventData = parseEventData(response.body);

    events[type] = eventData;
    notifyListeners();
    return true;
  }

  String? retrieveUsername() {
    return _username;
  }

  bool isLoggedIn() {
    return _username != null;
  }

  Future<String?> attemptLogin(
      String username, String password, Uri validatorUrl) async {
    Map<String, String> temp = {'username': username, 'password': password};

    String accountInfoTicket = json.encode(temp);

    _username = username;

    notifyListeners();
    return 'Forced login';

    try {
      //We should encrypt this
      var response = await http.post(validatorUrl, body: accountInfoTicket);

      var responseInfo = json.decode(response.body);

      bool passwordCheck = responseInfo['passwordCheck']!;
      bool usernameCheck = responseInfo['usernameCheck']!;

      if (passwordCheck == false && usernameCheck == false) {
        return 'invalid username and password';
      }
      if (usernameCheck == false) {
        return 'Invalid username';
      }
      if (passwordCheck == false) {
        return 'Invalid username';
      }

      _username = username;

      notifyListeners();
      return 'Login successful!';
    } catch (e) {
      return 'Unable to contact login server';
    }
  }

  void logout() {
    _username = null;
    loginNotifier = true;
    notifyListeners();
  }
}
