
import 'package:flutter/material.dart';
import 'package:testing/ui/widgets/app_bar.dart';


import 'login_page.dart';

class ChangePasswordPage extends StatefulWidget {
  static const String route = '/change-password';

  String _emailId;

  ChangePasswordPage(this._emailId);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState(_emailId);
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  var _formKey = GlobalKey<FormState>();

  //UserServices _userServices = UserServices();

  String _password;
  String _repeatPassword;
  String _emailId;

  _ChangePasswordPageState(String _emailId) {
    this._emailId = _emailId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'Reset Password',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text('Please provide a new password and verify it'),
                ),
                SizedBox(height: 25),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'New Password',
                    ),
                    // validator: (value) {
                    //   if (value.isEmpty) {
                    //     return 'Provide your new password';
                    //   }
                    //   if (value.length < 6) {
                    //     return 'Password must be atleast 6 characters long';
                    //   }
                    //   _formKey.currentState.save();
                    //   return null;
                    // },
                    onSaved: (value) {
                      _password = value;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Verify Password',
                    ),
                    // validator: (value) {
                    //   if (value.isEmpty) {
                    //     return 'Verify your new password';
                    //   }
                    //   if (value != _password) {
                    //     return 'Passwords do not match';
                    //   }
                    //   _formKey.currentState.save();
                    //   return null;
                    // },
                    onSaved: (value) {
                      _repeatPassword = value;
                    },
                  ),
                ),
                Container(
                  height: 55,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    onPressed: () async {
                      // if (_formKey.currentState.validate()) {
                      //   _formKey.currentState.save();
                      //   var updatePasswordRequest = UpdatePasswordRequest(
                      //       emailId: _emailId,
                      //       newPassword: _password,
                      //       verifyNewPassword: _repeatPassword);
                      //   final result = await _userServices
                      //       .updatePassword(updatePasswordRequest);
                      //   if (result != null && result) {
                          Navigator.of(context)
                              .pushReplacementNamed(LoginPage.route);
                     //   }
                      },
                   // },
                    child: Text(
                      'Change Password',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
