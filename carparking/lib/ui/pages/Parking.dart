import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing/ui/pages/user_home_page.dart';
import 'package:testing/ui/widgets/app_bar.dart';

class Parking extends StatefulWidget {
  static const String route = '/parking';

  @override
  _ParkingState createState() => _ParkingState();
}

class _ParkingState extends State<Parking> {
  final _formKeySendOTP = GlobalKey<FormState>();
  final _formKeyVerifyOTP = GlobalKey<FormState>();

  String _email;
  String _otp;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white, width: 2, style: BorderStyle.solid)),
          padding: EdgeInsets.all(16.0),
          //onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          )),
    );
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
                  'Parking Area',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Occupy or vacate a slot',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                //alignment: Alignment.centerRight,
                //alignment: Alignment.centerRight,
                //padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonTheme(
                        minWidth: 150.0,
                        height: 50.0,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(Parking.route);
                          },
                          color: Colors.red[400],
                          //blue[700],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.grey)),
                          splashColor: Colors.red,
                          child: Row(
                            children: [
                              Icon(
                                Icons.directions_car,
                                size: 40.0,
                                color: Colors.black54,
                              ),
                              Text('Occupy', style: TextStyle(fontSize: 25.0)),
                            ],
                          ),
                        ),
                      ),
                      ButtonTheme(
                        minWidth: 150.0,
                        height: 50.0,
                        child: RaisedButton(
                          onPressed: () {
                            // Navigator.pop(context);
                            Navigator.of(context).pushReplacementNamed(UserHomePage.route);
                          },
                          color: Colors.teal[300],
                          //blue[700],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.grey)),
                          splashColor: Colors.green,
                          child: Row(
                            children: [
                              Icon(
                                Icons.assignment_turned_in,
                                size: 40.0,
                                color: Colors.black54,
                              ),
                              Text('Vacate', style: TextStyle(fontSize: 25.0)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(' Available slots: ',
                      style: TextStyle(
                        color: Colors.grey[100],
                        fontSize: 20,
                        fontFamily: 'SourceSansPro',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(' 7 ',
                      style: TextStyle(
                        color: Colors.grey[100],
                        fontSize: 20,
                        fontFamily: 'SourceSansPro',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * .75,
                    child: Table(
                      children: [
                        TableRow(children: [
                          buildButton("1", 1, Colors.green[300]),
                          buildButton("2", 1, Colors.blue[300]),
                          buildButton("3", 1, Colors.blue[300]),
                          buildButton("4", 1, Colors.red[300]),
                        ]),
                        TableRow(children: [
                          buildButton("5", 1, Colors.green[300]),
                          buildButton("6", 1, Colors.green[300]),
                          buildButton("7", 1, Colors.red[300]),
                          buildButton("8", 1, Colors.green[300]),
                        ]),
                        TableRow(children: [
                          buildButton("9", 1, Colors.green[300]),
                          buildButton("10", 1, Colors.red[300]),
                          buildButton("11", 1, Colors.green[300]),
                          buildButton("12", 1, Colors.green[300]),
                        ]),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonTheme(
                    minWidth: 150.0,
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        // Navigator.pop(context);
                        Navigator.of(context).pushReplacementNamed(UserHomePage.route);
                      },
                      color: Colors.blueAccent,
                      //blue[700],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.grey)),
                      splashColor: Colors.green,
                      child: Row(
                        children: [
                          Icon(
                            Icons.lock,
                            size: 40.0,
                            color: Colors.black54,
                          ),
                          Text('Reserve', style: TextStyle(fontSize: 25.0)),
                        ],
                      ),
                    ),
                  ),


                ],
              ),
            ],
          ),
        ));
  }
}
