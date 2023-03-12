import 'package:englinks_app/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

/* Tutoring page will need to have input boxes for the user and a button to send
the tutor request.  In _TutorPageState, before the build() method, some control 
flow will need to assess whether or not the user is logged in. */
class TutorPage extends StatefulWidget {
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
        Center(child: TutorForm()),
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

// Define a corresponding State class.
// This class holds data related to the form.
class TutorFormState extends State<TutorForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
              width: screenWidth * 0.9,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required.';
                      }
                      return null;
                    },
                  ),
                ],
              )),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
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
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
