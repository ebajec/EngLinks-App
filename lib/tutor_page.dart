import 'package:englinks_app/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'app_state.dart';
import 'my_widgets.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

/* Tutoring page will need to have input boxes for the user and a button to send
the tutor request.  In _TutorPageState, before the build() method, some control 
flow will need to assess whether or not the user is logged in. */
class TutorPage extends StatefulWidget {
  const TutorPage({super.key});

  @override
  State<TutorPage> createState() => _TutorPageState();
}

class _TutorPageState extends State<TutorPage> {
  Widget _loginPopupDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Sorry, but you must be logged in to use this feature.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Center(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    Color listBorderColor = Colors.grey;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          FeatureTitle('My requests', textSize: 22, spacing: 0),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              border: Border(
                top: BorderSide(width: 1.0, color: listBorderColor),
                bottom: BorderSide(width: 1.0, color: listBorderColor),
              ),
            ),
            height: 160,
            width: double.infinity,
            child: RequestList(),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            style: MyButtonStyles.rectButton(
                context, 28, 220, Theme.of(context).colorScheme.primary),
            onPressed: () {
              if (appState.isLoggedIn()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TutorForm(key: UniqueKey())),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => _loginPopupDialog(context),
                );
              }
            },
            child: Text(
              'Request a tutor',
              style: MyTextStyles.buttonLarge(context),
            ),
          )
        ],
      ),
    );
  }
}

class RequestList extends StatefulWidget {
  @override
  State<RequestList> createState() => _RequestListState();
}

class _RequestListState extends State<RequestList> {
  List<String> requestData = ['pee', 'poo', 'cock'];

  Widget _requestDeleteDialog(BuildContext context, int requestIndex) {
    var appState = context.watch<AppState>();

    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Are you sure you would like to cancel your request?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    appState.deleteTutorRequest(requestIndex);
                    Navigator.of(context).pop();
                  },
                  child: Text('Yes')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _requestViewDialog(BuildContext context, int index) {
    var appState = context.watch<AppState>();

    var data;
    Widget body;

    try {
      data = json.decode(appState.tutorRequestData[index]);
      body = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(data['course']),
          Text(data['freq']),
          Text(data['comment']),
        ],
      );
    } catch (e) {
      body = Text('There was an error loading request data');
    }

    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      content: body,
      actions: [
        Center(
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.close),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    int numRequests = appState.tutorRequestData.length;

    var bold = TextStyle(fontWeight: FontWeight.bold);

    if (numRequests > 0) {
      return ListView.separated(
        scrollDirection: Axis.horizontal,
        primary: false,
        padding: const EdgeInsets.all(16),
        itemCount: numRequests,
        itemBuilder: (BuildContext context, int index) {
          var data;

          //The try block is just for the case that a bad file gets placed in the
          //directory by accident
          try {
            data = json.decode(appState.tutorRequestData[index]);

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Color.fromARGB(255, 196, 196, 196),
                  width: 2,
                ),
              ),
              width: 150,
              child: Column(
                children: [
                  Text('${data['course']}',
                      style: MyTextStyles.bold(context, 16)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${data['freq']}'),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _requestViewDialog(context, index),
                            );
                          },
                          icon: Icon(
                            Icons.more_horiz,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _requestDeleteDialog(context, index),
                            );
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } catch (e) {}
        },
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: 10),
      );
    }

    return Center(child: Text('You have no active tutor requests.'));
  }
}

/*Form for tutor request data contains text fields for name, email, and comments,
as well as a drop down menu for courses and available times.  */
class TutorForm extends StatefulWidget {
  const TutorForm({super.key});

  @override
  TutorFormState createState() {
    return TutorFormState();
  }
}

class TutorFormState extends State<TutorForm> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCourse;
  String? _selectedTutorTime;
  String? _email;

  Map<String, String> formData = {
    'user': '',
    'name': '',
    'course': '',
    'freq': '',
    'comment': ''
  };

  List<String> _courses = [];

  List<String> _tutorTimes = [
    'Just Once',
    'Weekly',
    'Bi-weekly',
    'Monthly',
    'Bi-Monthly'
  ];

  Future<String> _postTutorRequest(
      Uri url, Object? body, BuildContext context) async {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Sending request...')));

    try {
      var response = await http.post(url, body: body);
      return response.body;
    } catch (e) {
      return 'Unable to contact server';
    }
  }

  bool _validateName(String name) {
    int commas = 0;
    int validChars = 0;

    int i = 0;
    do {
      String c = name[i];

      //check character
      if (c == ',') {
        if (validChars == 0) {
          return false;
        }

        commas++;
        validChars = 0;
      } else if (c != ' ') {
        validChars++;
      }

      //fail conditions
      if (commas > 1) {
        return false;
      }

      i++;
    } while (i < name.length);

    return (validChars > 0) && (commas == 1);
  }

  void _loadCourseData() async {
    var data =
        await DefaultAssetBundle.of(context).loadString("assets/courses.csv");

    setState(() {
      var courseList = data.split(',');
      _courses = courseList;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCourseData();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    TextStyle boldCaption = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      fontFamily: 'Helvetica',
      color: Color.fromARGB(255, 65, 65, 65),
    );
    double screenWidth = MediaQuery.of(context).size.width;

    _formKey.currentState?.activate();
    _formKey.currentState?.save();

    formData['user'] = appState.retrieveUsername()!;

    return Scaffold(
      appBar: AppBar(title: Text('Request a tutor')),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                //This SizedBox is all the input
                SizedBox(
                    width: screenWidth * 0.9,
                    child: Column(
                      children: [
                        //Input for name
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AlignedText(
                            alignment: Alignment.centerLeft,
                            text: 'Enter your name',
                            style: boldCaption,
                          ),
                        ),
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              formData['name'] = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required.';
                            }
                            if (!_validateName(value)) {
                              return 'Separate first and last names with a comma.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'First, Last',
                            border: OutlineInputBorder(),
                          ),
                        ),

                        //Input for queens email
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AlignedText(
                            alignment: Alignment.centerLeft,
                            text: 'Enter your email',
                            style: boldCaption,
                          ),
                        ),
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              _email = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'example@queensu.ca',
                            border: OutlineInputBorder(),
                          ),
                        ),

                        //Dropdown list for courses
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AlignedText(
                            alignment: Alignment.centerLeft,
                            text: 'Choose a course',
                            style: boldCaption,
                          ),
                        ),
                        FormDropdownInput<String?>(
                          onSaved: (value) {
                            setState(() {
                              if (value != null) formData['course'] = value;
                            });
                          },
                          value: _selectedCourse,
                          items: _courses,
                          onChanged: (value) {
                            setState(() {
                              _selectedCourse = value;
                            });
                          },
                          errorText: 'No course was selected!',
                          hintText: 'Select course...',
                        ),

                        //Dropdown list for tutoring frequency
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AlignedText(
                            alignment: Alignment.centerLeft,
                            text: 'Choose a tutoring frequency',
                            style: boldCaption,
                          ),
                        ),
                        FormDropdownInput<String?>(
                          onSaved: (value) {
                            if (value != null) formData['freq'] = value;
                          },
                          value: _selectedTutorTime,
                          items: _tutorTimes,
                          onChanged: (value) {
                            setState(() {
                              _selectedTutorTime = value;
                            });
                          },
                          errorText: 'No times were selected!',
                          hintText: 'Select frequency...',
                        ),

                        //additional comments box
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AlignedText(
                            alignment: Alignment.centerLeft,
                            text: 'Additional comments',
                            style: boldCaption,
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            String? comment = formData['comment'];
                            if (comment != '' && comment!.length > 1024) {
                              return 'Character limit is 1024';
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              formData['comment'] = value;
                            });
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'Enter comments...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    )),
                SizedBox(height: 30),
                //submission button
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String formDataJSON = json.encode(formData);

                      var url =
                          Uri.http(appState.serverURL, 'recieve_tutor_request');

                      var response =
                          await _postTutorRequest(url, formDataJSON, context);

                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(response)));

                      appState.retrieveTutorRequestData();
                    }
                  },
                  style: MyButtonStyles.rectButton(
                    context,
                    40,
                    100,
                    Theme.of(context).colorScheme.primary,
                  ),
                  child: Text('Submit request',
                      style: MyTextStyles.buttonLarge(context)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class FormDropdownInput<T> extends StatelessWidget {
  final List<T> items;
  final String hintText;
  final String errorText;
  final T value;
  final void Function(T?)? onChanged;
  final void Function(T?)? onSaved;
  String? Function(T?)? validator;

  String _getLabel(T val) {
    return val as String;
  }

  FormDropdownInput({
    this.hintText = 'Select an option',
    this.errorText = 'No item was selected',
    this.items = const [],
    required this.value,
    required this.onChanged,
    this.onSaved,
  }) {
    validator = (value) {
      if (value == null || _getLabel(value).isEmpty) {
        return errorText;
      }
      return null;
    };
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      value: value,
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(_getLabel(item)),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
      onSaved: onSaved,
    );
  }
}
