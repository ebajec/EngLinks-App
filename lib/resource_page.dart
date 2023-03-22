import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'my_styles.dart';

/*Learning resources stuff.  Should mostly be links. */
class ResourcePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
   return MaterialApp(
    title : 'Resources Page',
    theme : ThemeData(

      primarySwatch : Colors.purple,
    ),
    home : ResourceData(),
   );

   
    return GlobDisplay();
     
  }
}

class ResourceData extends StatelessWidget{
  

@override 
Widget build(BuildContext context){
return Scaffold(
  body: Padding(
    padding: const EdgeInsets.all(8.0),
    child : Column(
    children : <Widget>[
      Text('Textbook Resources', style: TextStyle(fontSize :40, color : Colors.purple, fontWeight : FontWeight.w900),),
      Container(
        padding : EdgeInsets.all(20),
        child : Text ('The EngLinks goal is to offer quality educational resources to engineering students with no charge to engineering students. Any learning resources that could be seen as useful to engineering students will happily be taken by EngLinks and published.  Furthermore, any old textbooks that could be donated by the university would be greatly appreciated. '),),
      Container( 
    padding : EdgeInsets.all(20),
    child : Text('Hours of Operation', style : TextStyle(fontSize : 40, color : Colors.purple, fontWeight : FontWeight.w900),),),  
      Container(
        padding : EdgeInsets.all(20),
        child: Text('Monday to Thursday- 5:00 PM to 11:00 PM\nSaturday - 11:30 AM to 7:00 PM\nSunday-11:30 AM to 11:00 PM'),),

    ],
  ),
  ),
  );
}
}




  
