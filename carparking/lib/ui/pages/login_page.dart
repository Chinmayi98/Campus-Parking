import 'package:flutter/material.dart';
import 'package:testing/ui/pages/Parking.dart';
import 'package:testing/ui/pages/signup_page.dart';
import 'package:testing/ui/pages/user_home_page.dart';
import 'package:testing/ui/widgets/app_bar.dart';
import 'forgot_password_page.dart';

import 'package:testing/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:testing/models/user.dart';
import 'package:testing/shared/loading.dart';
import 'package:testing/services/database.dart';

class LoginPage extends StatefulWidget {
  static const String route = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  bool loading = false;
 // UserServices _userServices = UserServices();

  String _email = '';
  String _password = '';
  String _error = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        appBar: ApplicationBar(),
        body: SafeArea(
            child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Campus Parking',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 20),
                  ),
                ),

                // Username
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email Id',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Provide an email id';
                      }
                      _formKey.currentState.save();
                      return null;
                    },
                    onChanged: (value) {
                      setState(() => _email = value);
                    },
                    // onSaved: (value) {
                    //   _email = value;
                    // },
                  ),
                ),

                // Password
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Provide your password';
                      }
                      _formKey.currentState.save();
                      return null;
                    },
                    onChanged: (value) {
                      setState(() => _password = value);
                    },
                    // onSaved: (value) {
                    //   _password = value;
                    // },
                  ),
                ),

                // Login button
                Container(
                  height: 55,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    onPressed: () async { 
                      if(_formKey.currentState.validate()){
                        setState(() => loading = true);
                        dynamic result = await _auth.signInWithEmailAndPassword(_email, _password);
                        if(result == null){
                            setState(() {
                              _error = 'Could not log in';
                              loading = false;
                            });
                          } 
                          else {
                            Navigator.of(context)
                             .pushReplacementNamed(UserHomePage.route);
                          }
                      }
                      // Navigator.of(context)
                      //      .pushReplacementNamed(UserHomePage.route);
                    //   dynamic result = await _auth.signInAnon();
                    //   if (result == null) {
                    //     print('Error signing in');
                    //   }
                    //   else {
                    //     print('Signed In');
                    //     print(result.uid);
                    //     Navigator.of(context)
                    //         .pushReplacementNamed(UserHomePage.route);
                      },
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                  Text(
                    _error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                    textAlign: TextAlign.center,
                  ),

                // Signup information
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                        onPressed: () => Navigator.of(context)
                            .pushNamed(ForgotPasswordPage.route),
                        child: Text('Forgot Password')),
                    FlatButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed(SignUpPage.route),
                        child: Text('Sign Up'))
                  ],
                ))
              ],
            ),
          ),
        )));
  }
}
