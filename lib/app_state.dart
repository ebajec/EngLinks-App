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
  List tutorRequestData = [];

  AppState() {
    retrieveEventData('first year');
    retrieveEventData('upper year');
  }

  Future<bool> deleteTutorRequest(int index) async {
    return false;
  }

  Future<bool> retrieveTutorRequestData() async {
    var url = Uri.http(serverURL, 'read_tutor_requests');
    // ignore: prefer_typing_uninitialized_variables
    var response;

    try {
      response = await http.post(url, body: '{"username":"$_username"}');
    } catch (e) {
      return false;
    }

    List dataJSON;
    try {
      dataJSON = json.decode(response.body);
    } catch (e) {
      return false;
    }

    tutorRequestData = dataJSON;

    notifyListeners();
    return true;
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

    var url = Uri.http(serverURL, 'load/$filename');
    var response;

    try {
      response = await http.get(url);
    } catch (e) {
      return false;
    }

    var eventData;
    try {
      eventData = parseEventData(response.body);
    } catch (e) {
      return false;
    }

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

    String accountInfo = json.encode(temp);

    var response;
    try {
      response = await http.post(validatorUrl, body: accountInfo);
    } catch (e) {
      return 'Unable to contact login server';
    }

    var responseInfo;
    try {
      responseInfo = json.decode(response.body);
    } catch (e) {
      return 'Bad response. Please notify server admins.';
    }

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

    retrieveTutorRequestData();

    notifyListeners();
    return 'Login successful!';
  }

  void logout() {
    _username = null;
    loginNotifier = true;
    tutorRequestData = [];
    notifyListeners();
  }
}
