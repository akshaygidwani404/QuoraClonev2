import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quora_clone2/register.dart';

import 'homepage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Builder(builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              withEmailPassword(),
            ],
          ),
        );
      }),
    );
  }

  Widget withEmailPassword() {
    return Form(
        key: _formKey,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40),
                Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.red[900],
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      labelText: 'Email', prefixIcon: Icon(Icons.email)),
                  validator: (value) {
                    if (value.isEmpty) return 'Please enter some text';
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      labelText: 'Password', prefixIcon: Icon(Icons.lock)),
                  validator: (value) {
                    if (value.isEmpty) return 'Please enter some text';
                    return null;
                  },
                  obscureText: true,
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _signInWithEmailAndPassword();
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  color: Colors.red[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New to this App?",
                      style: TextStyle(
                          color: Colors.red[900],
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => Register()));
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.red[900],
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signInWithEmailAndPassword() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ))
          .user;
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return Homepage(
          user: user,
        );
      }));
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Failed to sign in with Email & Password"),
      ));
    }
  }

  // void _signOut() async {
  //   await _auth.signOut();
  // }
}

/*
onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _signInWithEmailAndPassword();
                      }
                    },


 */
