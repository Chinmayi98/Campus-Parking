import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing/ui/widgets/app_bar.dart';

// ignore: camel_case_types
class mapPage extends StatefulWidget {
  static const String route = '/map';

  @override
  _mapPageState createState() => _mapPageState();
}

// ignore: camel_case_types
class _mapPageState extends State<mapPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ApplicationBar(),
        body: SafeArea(
          child: ListView(children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                'University Map',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Zoom in and out for better view',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/images/map.jpg'),
              ),
            ),
          ]),
        ));
  }
}
