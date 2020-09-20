import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './homepage.dart';

class Post extends StatefulWidget {
  final String username;
  Post({Key key, this.username}) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _content = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.home,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            final user1 = _auth.currentUser;
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Homepage(
                      user: user1,
                    )));
          },
        ),
        backgroundColor: Colors.red[900],
        title: Text(
          "Quora Clone",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 30),
              //Text("${widget.value}"),
              Text(
                "Share your experience!",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[900],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 310),
                child: Text(
                  "Title :",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[900],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  controller: _title,
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 290),
                child: Text(
                  "Content :",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[900],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  controller: _content,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _postContent(_title.text, _content.text, widget.username);
                    }
                  },
                  child: Text(
                    'Post',
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _postContent(String t, String c, String u) async {
    CollectionReference users = FirebaseFirestore.instance.collection("Users");
    users.add({"title": t, "content": c, "username": u});
    final user2 = _auth.currentUser;
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Homepage(
              user: user2,
            )));
    return;
  }
}

/*
  onPressed: () {
          final user1 = _auth.currentUser;
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => Homepage(
                    user: user1,
                  )));
        },
 */

/*Center(
        child: RaisedButton(
          padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
          onPressed: () {
            final user1 = _auth.currentUser;
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Homepage(
                      user: user1,
                    )));
          },
          child: Text(
            'Home',
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
      ),*/
