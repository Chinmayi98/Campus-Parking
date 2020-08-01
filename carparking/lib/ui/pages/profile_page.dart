
import 'package:flutter/material.dart';
import 'package:testing/ui/widgets/app_bar.dart';

class profilePage extends StatefulWidget {
  static const String route = '/profile-page';

  @override
  _profilePageState createState() => _profilePageState();
  
  
  }
  
  class _profilePageState extends State<profilePage> {
//    final _formKeySendOTP = GlobalKey<FormState>();
//  final _formKeyVerifyOTP = GlobalKey<FormState>();
    @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor:Colors.grey[900],
        appBar: ApplicationBar(),
        body: SafeArea(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
           CircleAvatar(
                radius:50.0,
              //  backgroundColor: Colors.blueAccent,
                  backgroundImage: AssetImage('assets/images/user.jpg'),
              ),
           Text('User Name',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'DancingScript',
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                )
              ),
            SizedBox(
              height:30.0,
              width:150.0,
              child: Divider(
                color: Colors.grey[600]
              )
            ),
            Card(
                color: Colors.black26,
                margin:EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                child: ListTile(
                  leading: Icon(
                    Icons.motorcycle,
                    size: 50.0,
                    color: Colors.grey[400],
                  ),
                   title: Text('CLE-371',
                        style: TextStyle(
                          color: Colors.grey[100],
                          fontSize: 25,
                          fontFamily: 'SourceSansPro',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    subtitle:Text('Vehicle number',
                      style: TextStyle(
                        color: Colors.grey[100],
                        fontSize: 15,
                        fontFamily: 'SourceSansPro',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            ),
            Card(

             color: Colors.black26,
             //padding: EdgeInsets.all(10.0),
             margin:EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
             child: ListTile(
               leading:
                 Icon(
                     Icons.gavel,
                     size: 50.0,
                     color: Colors.grey[400],
                 ),
             title: Text('02',
               style: TextStyle(
                 color: Colors.grey[100],
                 fontSize: 25,
                 fontFamily: 'SourceSansPro',
                 fontWeight: FontWeight.bold,
               ),
             ),
             subtitle:Text('Number of tickets',
               style: TextStyle(
                 color: Colors.grey[100],
                 fontSize: 15,
                 fontFamily: 'SourceSansPro',
                 fontWeight: FontWeight.bold,
               ),
             ),
           ),
      ),
            Card(

              color: Colors.black26,
              //padding: EdgeInsets.all(10.0),
              margin:EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
              child: ListTile(
                leading:
                Icon(
                  Icons.event_seat,
                  size: 50.0,
                  color: Colors.grey[400],
                ),
                title: Text('2 Wheeler',
                  style: TextStyle(
                    color: Colors.grey[100],
                    fontSize: 25,
                    fontFamily: 'SourceSansPro',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle:Text('Vehicle type',
                  style: TextStyle(
                    color: Colors.grey[100],
                    fontSize: 15,
                    fontFamily: 'SourceSansPro',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ]
        )
        ),

    );
  }
}
