import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing/services/auth.dart';
import 'package:testing/ui/pages/profile_page.dart';
import 'package:testing/ui/pages/map_page.dart';
import 'package:testing/ui/pages/ticket_page.dart';
import 'package:testing/ui/pages/reportPage.dart';
import 'Parking.dart';
import 'contact_us_page.dart';
import 'login_page.dart';
import 'package:testing/ui/widgets/app_bar.dart';

class UserHomePage extends StatefulWidget {
  //final String title;
  static const String route = '/user-home';
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

//UserHomePage({Key key, this.title}) : super(key: key);
class _UserHomePageState extends State<UserHomePage> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ApplicationBar(),
        body: SafeArea(
          child: ListView(
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Parking Areas',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'List of parking lots with available number of slots in each parking area',
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonTheme(
                            minWidth: 175.0,
                            height: 50.0,
                            child: RaisedButton(
                              splashColor: Colors.grey,
                              color: Colors.blueGrey,
                              onPressed: () async {
                                 Navigator.of(context).pushReplacementNamed(Parking.route);
                              },
                              child: Text('Parking lot 1',
                                  style: TextStyle(fontSize: 25.0)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '07',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonTheme(
                            minWidth: 175.0,
                            height: 50.0,
                            child: RaisedButton(
                              splashColor: Colors.grey,
                              color: Colors.blueGrey,
                              onPressed: () async {
                                // Navigator.of(context).pushReplacementNamed(UserHomePage.route);
                              },
                              child: Text('Parking lot 2',
                                  style: TextStyle(fontSize: 25.0)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '10',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonTheme(
                            minWidth: 175.0,
                            height: 50.0,
                            child: RaisedButton(
                              splashColor: Colors.grey,
                              color: Colors.blueGrey,
                              onPressed: () async {
                                // Navigator.of(context).pushReplacementNamed(UserHomePage.route);
                              },
                              child: Text('Parking lot 3',
                                  style: TextStyle(fontSize: 25.0)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '00',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonTheme(
                            minWidth: 175.0,
                            height: 50.0,
                            child: RaisedButton(
                              splashColor: Colors.grey,
                              color: Colors.blueGrey,
                              onPressed: () async {
                                // Navigator.of(context).pushReplacementNamed(UserHomePage.route);
                              },
                              child: Text('Parking lot 4',
                                  style: TextStyle(fontSize: 25.0)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '12',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ]),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[
                    Colors.black54,
                    Colors.blueGrey[500]
                  ])),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Material(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          child: Image.asset(
                            'assets/images/nwm_logo.png',
                            width: 100,
                            height: 100,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(0.01),
                          child: Text(
                            'Northwest Missouri State Univeristy',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                        )
                      ],
                    ),
                  )),
              CustomeListTile(Icons.person, 'Profile',
                  () => {Navigator.of(context).pushNamed(profilePage.route)}),
              CustomeListTile(Icons.map, 'Map',  () => {Navigator.of(context).pushNamed(mapPage.route)}), //mapPage
              CustomeListTile(Icons.report, 'Report', () => {Navigator.of(context).pushNamed(reportPage.route)}),
              CustomeListTile(Icons.question_answer, 'FAQ', () => {}),
              CustomeListTile(Icons.phone, 'Contact', () => {Navigator.of(context).pushNamed(ContactUs.route)}),
              CustomeListTile(Icons.gavel, 'Ticket', () => {Navigator.of(context).pushNamed(ticket.route)}),
              CustomeListTile(Icons.lock, 'Logout',
                  () async {
                    await _auth.signOut();
                    Navigator.of(context).pushNamed(LoginPage.route);
                    }
                    ),
            ],
          ),
        ));
  }
}

class CustomeListTile extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;
  CustomeListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
        child: InkWell(
          splashColor: Colors.blueGrey,
          onTap: onTap,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(text, style: TextStyle(fontSize: 16.0)),
                    ),
                  ],
                ),
                Icon(Icons.arrow_right)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
