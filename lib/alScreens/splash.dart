// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ichat_app/alScreens/home.dart';
import 'package:ichat_app/alScreens/login.dart';
import 'package:ichat_app/allConstants/color_constants.dart';
import 'package:provider/provider.dart';
import 'package:ichat_app/allProviders/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      checkSignedIn();
    });
  }

  Future<void> checkSignedIn() async {
    // WidgetsFlutterBinding.ensureInitialized();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var email = prefs.getString('email');
    // print(email);
    Auth authProvider = context.read<Auth>();
    bool isLoggedIn = await authProvider.isLoggedIn();
    if (isLoggedIn //&& email == null
    ) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              "images/splash.png",
              width: 300,
              height: 300,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Your favourite chat app, but better.",
              style: TextStyle(color: ColorConstants.themeColor),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 20,
              height: 20,
              child:
                  CircularProgressIndicator(color: ColorConstants.themeColor),
            ),
          ],
        ),
      ),
    );
  }
}
