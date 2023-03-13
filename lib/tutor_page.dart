import 'package:englinks_app/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

/* Tutoring page will need to have input boxes for the user and a button to send
the tutor request.  In _TutorPageState, before the build() method, some control 
flow will need to assess whether or not the user is logged in. */
class TutorPage extends StatefulWidget {
  const TutorPage({super.key});

  @override
  State<TutorPage> createState() => _TutorPageState();
}

class _TutorPageState extends State<TutorPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Text('Request a Tutor', style: MyTextStyles.titleMedium(context)),
        Center(child: TutorForm(key: UniqueKey())),
      ],
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

  String? _name;
  String? _email;
  String? _course;
  String? _tutorFrequency;
  String? _comment;

  List<String> _courses = ['APSC 111', 'APSC 112'];
  List<String> _tutorTimes = ['Weekly', 'Bi-weekly'];

  String? _selectedCourse;
  String? _selectedTutorTime;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    TextStyle boldCaption = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      fontFamily: 'Helvetica',
      color: Color.fromARGB(255, 65, 65, 65),
    );

    _formKey.currentState?.activate();
    _formKey.currentState?.save();

    return Form(
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
                        _name = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required.';
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
                      labelText: 'NetID@queensu.ca',
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
                        _course = value;
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
                      _tutorFrequency = value;
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
                      _comment ??= '';
                    },
                    onChanged: (value) {
                      setState(() {
                        _comment = value;
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
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  String formData = '''{
                    '"name":"${_name!}",
                    "course":"${_course!}",
                    "freq":"${_tutorFrequency!}",
                    "comment":"${_comment!}" 
                  }''';

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(formData)),
                  );
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
    );
  }
}

class AlignedText extends StatelessWidget {
  final String text;
  final AlignmentGeometry alignment;
  final TextStyle style;

  const AlignedText({
    Key? key,
    required this.text,
    required this.alignment,
    this.style = const TextStyle(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text, style: style),
      ),
    );
  }
}

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
