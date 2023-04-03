import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'my_styles.dart';
import 'package:flutter_linkify/flutter_linkify.dart';





/*Learning resources stuff.  Should mostly be links. */
class ResourcePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResourceData();
  }
}

class ResourceData extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            'Textbook Resources',
            style: TextStyle(
                fontSize: 40,
                color: Colors.purple,
                fontWeight: FontWeight.w900),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
                'The EngLinks goal is to offer quality educational resources to engineering students with no charge. Any learning resources that could be seen as useful to engineering students will happily be taken by EngLinks and published.  Furthermore, any old textbooks that could be donated by the university would be greatly appreciated. '),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Hours of Operation',
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.purple,
                  fontWeight: FontWeight.w900),
            ),
          ),
          Container( 
            padding : EdgeInsets.all(20),
            child: Text(
              'Monday to Thursday - 5:00 PM to 11:00 PM\n Saturday - 11:30 AM to 7:00 PM\n Sunday - 11:30 AM to 11:00 PM'
            ),
          ),
         Container(
          padding: EdgeInsets.all(20),
          child: Text(
            'Resources',
            style: TextStyle(
              fontSize: 40,
              color: Colors.purple,
              fontWeight: FontWeight.w900),
          ),
         ),
        Linkify(
          onOpen: (link) => print("Clicked ${link.url}!"),
          text: "First year resources : https://englinks.ca/resources/online-resources/first-year-resources/\n Upper Year Resources : https://englinks.ca/resources/online-resources/upper-year-resources/",
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: Text(
            'Contacts',
            style: TextStyle(
              fontSize: 40,
              color: Colors.purple,
              fontWeight: FontWeight.w900),
          ),
        ),
        

        SelectableLinkify(
          text: "First Year Contact : englinks.firstyear@engsoc.queensu.ca\nUpper Year Contact : englinks.upperyear@engsoc.queensu.ca",
        ),

        ],
      ),
    );
  }
}

