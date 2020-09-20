import 'package:flutter/material.dart';
import 'package:quora_clone2/register.dart';
import 'package:quora_clone2/login.dart';

class FirebaseAuthDemo extends StatefulWidget {
  @override
  _FirebaseAuthDemoState createState() => _FirebaseAuthDemoState();
}

class _FirebaseAuthDemoState extends State<FirebaseAuthDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 50),
          Container(
            child: Center(
              child: Image(
                image: AssetImage("images/quora.png"),
                height: 130,
                width: 130,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              "Quora Clone",
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[900]),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                color: Colors.red[900],
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                onPressed: () => _pushPage(context, Login()),
                child: Text(
                  "Log In",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              SizedBox(width: 20),
              RaisedButton(
                color: Colors.red[900],
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                onPressed: () => _pushPage(context, Register()),
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}

//onPressed: () => _pushPage(context, Register()),
//   onPressed: () => _pushPage(context, Login()),
