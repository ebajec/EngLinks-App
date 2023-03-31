import 'package:englinks_app/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'app_state.dart';
import 'my_widgets.dart';

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
      content:
          const Text('Sorry, but you must be logged in to use this feature.'),
      actions: <Widget>[
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

    return Center(
      child: Column(
        children: [
          SizedBox(height: 15),
          AlignedText(
            text: 'Tutor Requests',
            style: MyTextStyles.titleMedium(context),
            alignment: Alignment.centerLeft,
          ),
          AlignedBar(width: accentBarWidth, color: accentBarColor),
          SizedBox(height: 10),
          WideButton(
            label: 'Request a tutor',
            height: 50,
            textStyle: MyTextStyles.bold(context, 18),
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
          )
        ],
      ),
    );
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

  Map<String, String> formData = {
    'user': '',
    'name': '',
    'course': '',
    'freq': '',
    'comment': ''
  };

  String? _email;

  List<String> _courses = ['APSC 111', 'APSC 112'];
  List<String> _tutorTimes = [
    'Just Once',
    'Weekly',
    'Bi-weekly',
    'Monthly',
    'Bi-Monthly'
  ];

  String? _selectedCourse;
  String? _selectedTutorTime;

  Future<String> postTutorRequest(
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

  bool validateName(String name) {
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

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    double screenWidth = MediaQuery.of(context).size.width;

    TextStyle boldCaption = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      fontFamily: 'Helvetica',
      color: Color.fromARGB(255, 65, 65, 65),
    );

    _formKey.currentState?.activate();
    _formKey.currentState?.save();

    formData['user'] = appState.retrieveUsername()!;

    return Scaffold(
      appBar: AppBar(title: Text('Request a tutor')),
      body: Center(
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
                      AlignedText(
                        alignment: Alignment.centerLeft,
                        text: 'Enter your name',
                        style: boldCaption,
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
                          if (!validateName(value)) {
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
                      AlignedText(
                        alignment: Alignment.centerLeft,
                        text: 'Enter your email',
                        style: boldCaption,
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
                      AlignedText(
                        alignment: Alignment.centerLeft,
                        text: 'Choose a course',
                        style: boldCaption,
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
                      AlignedText(
                        alignment: Alignment.centerLeft,
                        text: 'Choose a tutoring frequency',
                        style: boldCaption,
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
                      AlignedText(
                        alignment: Alignment.centerLeft,
                        text: 'Additional comments',
                        style: boldCaption,
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
              //submission button
              Padding(
                padding: const EdgeInsets.all(18),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String formDataJSON = json.encode(formData);

                      var url =
                          Uri.http(appState.serverURL, 'recieve_tutor_request');

                      var response =
                          await postTutorRequest(url, formDataJSON, context);

                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(response)));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.secondary,
                    onPrimary: Colors.white,
                    shadowColor: Theme.of(context).colorScheme.outline,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0)),
                    minimumSize: Size(100, 50),
                  ),
                  child: const Text('Submit request'),
                ),
              ),
            ],
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
