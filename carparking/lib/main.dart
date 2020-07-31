import 'package:flutter/material.dart';
import 'package:testing/services/auth.dart';
import 'package:testing/ui/pages/change_password_page.dart';
import 'package:testing/ui/pages/contact_us_page.dart';
import 'package:testing/ui/pages/forgot_password_page.dart';
import 'package:testing/ui/pages/map_page.dart';
import 'package:testing/ui/pages/ticket_page.dart';
import 'package:testing/ui/pages/user_home_page.dart';
import 'ui/pages/Parking.dart';
//import 'ui/pages/forgot_password_page.dart';
import 'ui/pages/login_page.dart';
import 'ui/pages/signup_page.dart';
import 'ui/pages/profile_page.dart';
import 'ui/pages/violationPage.dart';
import 'ui/pages/reportPage.dart';

import 'package:provider/provider.dart';
import 'package:testing/models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // var sharedPreference = await SharedPreferences.getInstance();
  //String token = sharedPreference.getString('cp_token');

  runApp(StreamProvider<User>.value(
    value: AuthService().user,
      child: MaterialApp(
      title: 'Campus Parking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: LoginPage(),
      routes: {
        // Login and signup related
        LoginPage.route: (context) => LoginPage(),
        ForgotPasswordPage.route: (context) => ForgotPasswordPage(),
        SignUpPage.route: (context) => SignUpPage(),
        //ChangePasswordPage.route: (context) => ChangePasswordPage(),
        UserHomePage.route: (context) => UserHomePage(),
        Parking.route: (context) => Parking(),
        profilePage.route: (context) => profilePage(),
        mapPage.route: (context) => mapPage(),
        ContactUs.route: (context) => ContactUs(),
        ticket.route: (context) => ticket(),
        reportPage.route : (context) => reportPage(),
        ViolationPage.route : (context) => ViolationPage(),
      },
    ),
  ));
}
