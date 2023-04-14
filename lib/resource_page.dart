import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'app_state.dart';
import 'my_styles.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'my_widgets.dart';

/*Learning resources stuff.  Should mostly be links. */
class ResourcePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResourceData();
  }
}

Uri resourcesFirstYear =
    Uri.http("englinks.ca/resources/online-resources/first-year-resources/");

class ResourceData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          FeatureTitle(
            'Textbook Resources',
            textSize: 22,
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
                'The EngLinks goal is to offer quality educational resources to engineering students with no charge. Any learning resources that could be seen as useful to engineering students will happily be taken by EngLinks and published.  Furthermore, any old textbooks that could be donated by the university would be greatly appreciated. '),
          ),
          FeatureTitle(
            'Hours of Operation',
            textSize: 22,
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
                'Monday to Thursday - 5:00 PM to 11:00 PM\n Saturday - 11:30 AM to 7:00 PM\n Sunday - 11:30 AM to 11:00 PM'),
          ),
          FeatureTitle('Resources', textSize: 22),
          InkWell(
            child: Text("First year resources"),
            onTap: () => launchUrl(resourcesFirstYear),
          ),
          //Linkify(
          //  onOpen: (link) => print("Clicked ${link.url}!"),

          //  text:
          //      "First year resources : https://englinks.ca/resources/online-resources/first-year-resources/\n Upper Year Resources : https://englinks.ca/resources/online-resources/upper-year-resources/",
          //),
          FeatureTitle(
            'Contacts',
            textSize: 22,
          ),
          SelectableLinkify(
            text:
                "First Year Contact : englinks.firstyear@engsoc.queensu.ca\nUpper Year Contact : englinks.upperyear@engsoc.queensu.ca",
          ),
        ],
      ),
    );
  }
}
