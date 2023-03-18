import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

/*This should mostly just be accessibility options and login settings. */
class OptionsPage extends StatefulWidget {
  const OptionsPage({super.key});

  @override
  State<OptionsPage> createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  @override
  Widget build(BuildContext context) {

    return MyApp();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      //theme: ThemeData(scaffoldBackgroundColor: Color.fromARGB(255, 255, 253, 255)),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: const MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  TextEditingController userNameEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 15, bottom: 0),
              child: Text("Login to EngLinks Account", style: TextStyle(fontSize: 22)),
            ),
          ),


          Padding(
            padding: EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 0),
            child: TextFormField(
              controller: userNameEmailController,
              decoration: InputDecoration(
                hintText: 'Username/Email',
                contentPadding: const EdgeInsets.only(left: 18, right: 18),
                border: OutlineInputBorder(),
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid username or email address';
                }else {
                  setState(() {
                    appState.setGlobUserEmail(value);
                  });
                }
                return null;
              },
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
            child: TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
                contentPadding: const EdgeInsets.only(left: 18, right: 18),
                border: OutlineInputBorder(),
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid password';
                }else {
                  setState(() {
                    appState.setGlobUserEmail(value);
                  });
                }
                return null;
              },
            ),
          ),

          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(bottom: 15),
            child: SizedBox(
              height: 40,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Attempting to log in...')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple, // Background color
                ),
                child: const Text('Login'),
              ),
            ),
          ),

          Divider(
            color: Colors.black, //color of divider
            height: 5, //height spacing of divider
            thickness: 3, //thickness of divider line
            indent: 15, //spacing at the start of divider
            endIndent: 15, //spacing at the end of divider
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 15, bottom: 0),
              child: Text("Accessibility Settings", style: TextStyle(fontSize: 22)),
            ),
          )

        ],
      ),
    );
  }
}

// Possibly useful unused code snippets VVV

/*
class DisplayLoginAndOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
/*
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username/Email',
                    hintText: 'Enter valid username or email address'),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
              child: TextField(

                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),

            Divider(
              color: Colors.black, //color of divider
              height: 5, //height spacing of divider
              thickness: 3, //thickness of divider line
              indent: 15, //spacing at the start of divider
              endIndent: 15, //spacing at the end of divider
            ),
*/
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 18, right: 18, top: 15, bottom: 0),
                child: Text("Accessibility Settings", style: TextStyle(fontSize: 22)),
              ),
            
            ),
          ],
        ),
      ),
    );
    
  }
}


return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),


      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.only(left:15.0,right: 15.0,top:5,bottom: 0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username/Email',
                    hintText: 'Enter valid username or email address'),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 20, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(

                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),

          ],
        ),
      ),
    );
*/
