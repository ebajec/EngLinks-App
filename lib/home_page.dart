import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'my_widgets.dart';
import 'my_styles.dart';
import 'package:flutter/services.dart';

/* This page shouldn't be much, just a general description of app features. */
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    var iconPadding = const EdgeInsets.fromLTRB(12.0, 0, 12, 12);
    var nameStyle = TextStyle(color: Colors.black, fontSize: 16);

    String email_first_year = "englinks.firstyear@engsoc.queensu.ca";
    String email_upper_year = "englinks.upperyear@engsoc.queensu.ca";

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Welcome',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
          ),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: iconPadding,
                    child: Icon(Icons.school),
                  ),
                  Expanded(
                      child: DescriptionText(
                    title: 'Tutoring',
                    body:
                        'EngLinks offers one-on-one tutoring from experienced peers at competitive rates. Take your academic performance to the next level. ',
                  )),
                ],
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: iconPadding,
                    child: Icon(Icons.calendar_month),
                  ),
                  Expanded(
                    child: DescriptionText(
                        title: 'Events',
                        body:
                            'View our workshop calendars!  Workshops are offered in select courses during midterm and exam periods to review key concepts and solidify understanding of course material.'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: iconPadding,
                    child: Icon(Icons.book),
                  ),
                  Expanded(
                    child: DescriptionText(
                        title: 'Learning Resources',
                        body:
                            'EngLinks offers quality educational resources to student at no charge. This includes a textbook library located in the ILC, workbooks, and online resources to help students study.'),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
          FeatureTitle(
            'Contacts',
            textSize: 22,
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: ContactDisplay(
                    name: "Sasha Koch",
                    nameStyle: nameStyle,
                    email: email_first_year,
                    description: "EngLinks First-Year Manager",
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ContactDisplay(
                    name: "Hannah Lacey",
                    nameStyle: nameStyle,
                    email: email_upper_year,
                    description: "EngLinks Upper-Year Manager",
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
    ;
  }
}

class ContactDisplay extends StatelessWidget {
  const ContactDisplay({
    super.key,
    required this.nameStyle,
    required this.email,
    required this.name,
    required this.description,
  });

  final TextStyle nameStyle;
  final String email;
  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: nameStyle),
        Text(
          description,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        InkWell(
          child: Text(
            email,
            style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w500),
          ),
          onTap: () {
            Clipboard.setData(ClipboardData(text: email));
          },
        ),
      ],
    );
  }
}

class DescriptionText extends StatelessWidget {
  const DescriptionText({super.key, required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
              text: '$title:  ',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: body),
        ],
      ),
    );
  }
}
