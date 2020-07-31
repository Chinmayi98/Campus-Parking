
import 'package:flutter/material.dart';
import 'package:testing/ui/widgets/app_bar.dart';

import 'change_password_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const String route = '/forgot-password';

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKeySendOTP = GlobalKey<FormState>();
  final _formKeyVerifyOTP = GlobalKey<FormState>();

 // UserServices _userServices = UserServices();

  String _email;
  String _otp;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Forgot Password',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Please provide your id and click on Send to get reset code on your registered device. Provide your code and hit Verify Code button after which you will be able to update your password',
                ),
              ),

              SizedBox(height: 25),

              // Username
              Form(
                key: _formKeySendOTP,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'ID',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Provide an email id';
                          }
                          _formKeySendOTP.currentState.save();
                          return null;
                        },
                        onSaved: (value) => _email = value,
                      ),
                    ),

                    // Send Code button
                    Container(
                      height: 55,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RaisedButton(
                        onPressed: () async {
                          // if (_formKeySendOTP.currentState.validate()) {
                          //   _formKeySendOTP.currentState.save();
                          //   var request = GeneratePasswordResetOtpRequest(
                          //       emailId: _email);
                          //   var response = await _userServices
                          //       .resetPasswordRequest(request);
                         // }
                        },
                        child: Text(
                          'Send Code',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 25),

              // Provide Code
              Form(
                key: _formKeyVerifyOTP,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Code',
                        ),
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Provide an OTP sent to your email address';
                        //   }
                        //   _formKeyVerifyOTP.currentState.save();
                        //   return null;
                        // },
                        onSaved: (value) => _otp = value,
                      ),
                    ),

                    // Verify Code button
                    Container(
                      height: 55,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RaisedButton(
                        onPressed: () async {
                          if (_formKeyVerifyOTP.currentState.validate()) {
                            _formKeySendOTP.currentState.save();
                            _formKeyVerifyOTP.currentState.save();
                            // print(_email);
                            // print(_otp);
                            // var request = VerifyPasswordResetOtpRequest(
                            //     emailId: _email, otp: _otp);
                            // var response = await _userServices
                            //     .verifyPasswordResetOTP(request);
                            //if (response) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChangePasswordPage(_email)));
                            }
                          //}
                        },
                        child: Text(
                          'Verify Code',
                          style: TextStyle(fontSize: 18),
                        ), 
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
