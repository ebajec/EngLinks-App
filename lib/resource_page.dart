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

Uri resourcesFirstYear = Uri.https("englinks.ca", "/resources");

class ResourceData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        FeatureTitle(
          'Textbook Resources',
          textSize: 22,
          spacing: 0,
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

        //Learning resources stuff
        FeatureTitle('Resources', textSize: 22),
        Container(
          padding: EdgeInsets.all(16),
          child: InkWell(
            child: Text(
              "Check out our website!",
              style:
                  TextStyle(color: Colors.purple, fontWeight: FontWeight.w500),
            ),
            onTap: () => launchUrl(resourcesFirstYear),
          ),
        ),
      ],
    );
  }
}
