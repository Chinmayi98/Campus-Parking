import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing/main.dart';
import 'package:testing/ui/pages/user_home_page.dart';
import 'package:testing/ui/widgets/app_bar.dart';
//class Parking extends StatelessWidget {

class ticket extends StatefulWidget {
  static const String route = '/ticket';

  @override
  _ticketState createState() => _ticketState();
}

class _ticketState extends State<ticket> {
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
                  'Tickets',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Raise or drop a ticket',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Vehicle Number',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Reason for ticket',
                  ),

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonTheme(
                      minWidth: 150.0,
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          // Navigator.pop(context);
                          Navigator.of(context).pushReplacementNamed(UserHomePage.route);
                        },
                        color: Colors.teal[400],
                        //blue[700],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.grey)),
                        splashColor: Colors.green,
                        child: Row(
                          children: [

                            Text('Raise / Drop', style: TextStyle(fontSize: 25.0)),
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
                        color: Colors.red[400],
                        //blue[700],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.grey)),
                        splashColor: Colors.green,
                        child: Row(
                          children: [

                            Text('Cancel', style: TextStyle(fontSize: 25.0)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
