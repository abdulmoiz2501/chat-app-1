import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ichat_app/allProviders/auth.dart';
import 'package:ichat_app/allWidgets/loading_view.dart';
import 'package:provider/provider.dart';
import 'package:ichat_app/allProviders/auth.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context);
    switch (auth.status) {
      case Status.authError:
        Fluttertoast.showToast(msg: "Sign in failed.");
        break;
      case Status.authCancelled:
        Fluttertoast.showToast(msg: "Sign in cancelled.");
        break;
      case Status.authenticated:
        Fluttertoast.showToast(msg: "Signed in successfully.");
        break;
      default:
        break;
    }
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset("images/back.png"),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: () async {
                bool isSuccess = await auth.SignIn();
                if (isSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                }
              },
              child: Image.asset("images/google_login.jpg"),
            ),
          ),
          Positioned(
            child: auth.status == Status.authenticating ? LoadingView() : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
