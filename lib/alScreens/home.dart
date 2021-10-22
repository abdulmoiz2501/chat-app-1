import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ichat_app/alScreens/SearchPage.dart';
import 'package:ichat_app/alScreens/login.dart';
import 'package:ichat_app/alScreens/settings.dart';
import 'package:ichat_app/allConstants/color_constants.dart';
import 'package:ichat_app/allModels/popup.dart';
import 'package:ichat_app/allModels/user_chat.dart';
import 'package:ichat_app/allProviders/auth.dart';
import '../main.dart';
import 'package:provider/src/provider.dart';

class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final ScrollController listScrollController = ScrollController();

  int _limit = 20;
  int _limitIncrement = 20;
  String _textSearch = "";
  bool isLoading = false;

  late Auth auth;
  // late Home home;
  late String currentUserId;

  List<PopupChoices> choices = <PopupChoices>[
    PopupChoices(title: 'Settings', icon: Icons.settings),
    PopupChoices(title: 'Sign out', icon: Icons.exit_to_app),
  ];

  // ignore: non_constant_identifier_names
  Future<void> SignOut() async {
    auth.SignOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  void onItemMenuPress(PopupChoices choice) {
    if (choice.title == "Sign out") {
      SignOut();
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SettingsPage()));
    }
  }

  Widget buildPopupMenu() {
    return PopupMenuButton<PopupChoices>(
        icon: const Icon(
          Icons.more_vert,
          color: Colors.grey,
        ),
        onSelected: onItemMenuPress,
        itemBuilder: (BuildContext context) {
          return choices.map((PopupChoices choice) {
            return PopupMenuItem<PopupChoices>(
              value: choice,
              child: Row(
                children: <Widget>[
                  Icon(
                    choice.icon,
                    color: ColorConstants.primaryColor,
                  ),
                  Container(
                    width: 10,
                  ),
                  Text(
                    choice.title,
                    style: const TextStyle(
                      color: ColorConstants.primaryColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList();
        });
  }

  @override
  void initState() {
    super.initState();
    auth = context.read<Auth>();
    //  home = context.read<Home>();

    if (auth.getUserId()?.isNotEmpty == true) {
      currentUserId = auth.getUserId()!;
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPage(),),
          (Route<dynamic> route) => false);
    }
    listScrollController.addListener(scrollListener);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
       },
        backgroundColor: ColorConstants.primaryColor,
        child: Icon(Icons.search),
      ),
      backgroundColor: isWhite ? Colors.white : Colors.black87,
      appBar: AppBar(
        backgroundColor: isWhite ? Colors.white : Colors.black87,
        leading: IconButton(
          icon: Switch(
            value: isWhite,
            onChanged: (value) {
              setState(() {
                isWhite = value;
                print(isWhite);
              });
            },
            activeTrackColor: Colors.grey,
            activeColor: Colors.white,
            inactiveTrackColor: Colors.grey,
            inactiveThumbColor: Colors.black45,
          ),
          onPressed: () => "",
        ),
        actions: <Widget>[
          buildPopupMenu(),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [

          ],
        ),

      ),
    );
  }
}
