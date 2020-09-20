import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quora_clone2/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quora_clone2/login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //final TextEditingController _repasswordController = TextEditingController();

  //bool _isSuccess;
  // String _userEmail;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
              key: _formKey,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.red[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        controller: _displayName,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                            labelText: 'Email', prefixIcon: Icon(Icons.email)),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock)),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        obscureText: true,
                      ),
                      // TextFormField(
                      //   controller: _repasswordController,
                      //   decoration: const InputDecoration(
                      //       labelText: 'Re-Enter Password'),
                      //   validator: (String value) {
                      //     if (_passwordController != _repasswordController) {
                      //       return 'Passwords must match';
                      //     }
                      //     return null;
                      //   },
                      //   obscureText: true,
                      // ),
                      SizedBox(height: 20),
                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            _registerAccount();
                          }
                        },
                        child: Text(
                          'SignUp',
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
                            "Already a user?",
                            style: TextStyle(
                                color: Colors.red[900],
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            },
                            child: Text(
                              "Login",
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
              )),
        ),
      ),
    );
  }

  Future<void> _registerAccount() async {
    final User user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    ))
        .user;

    if (user != null) {
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      await user.updateProfile(displayName: _displayName.text);

      CollectionReference newusers =
          FirebaseFirestore.instance.collection("NewUsers");
      newusers.add({"username": _displayName.text});

      final user1 = _auth.currentUser;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Homepage(
                user: user1,
              )));
    }
    // else {
    //   _isSuccess = false;
    // }
  }
}

/*
() async {
                            if (_formKey.currentState.validate()) {
                              _registerAccount();
                            }
                            
                            
                            */
