//import 'dart:html';
//import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quora_clone2/firebaseAuthDemo.dart';
import 'package:quora_clone2/friends.dart';
import './post.dart';

class Homepage extends StatefulWidget {
  final User user;

  const Homepage({Key key, this.user}) : super(key: key);
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseAuth _auth = FirebaseAuth.instance;

  bool isSwitched = false;

  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Quora Clone",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Colors.red[900],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var dispname = widget.user.displayName;
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Post(
                      username: dispname,
                    )),
          );
        },
        backgroundColor: Colors.red[900],
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.red[900],
        notchMargin: 5.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                size: 30.0,
                color: Colors.white,
              ),
              onPressed: () {
                controller.animateTo(
                  0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
            ),
            SizedBox(width: 120),
            IconButton(
              icon: Icon(
                Icons.people,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Friends()));
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    child: Icon(
                      Icons.person,
                      size: 35,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.grey[500],
                    radius: 40,
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.user.displayName,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.user.email,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.red[900],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.brightness_6,
              ),
              title: Text(
                "Dark Mode",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red[900],
                ),
              ),
              trailing: Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                    //print(isSwitched);
                  });
                },
                // activeTrackColor: Colors.grey[500],
                activeColor: Colors.grey[900],
              ),
            ),
            ListTile(
              title: Text(
                "Logout",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red[900],
                ),
              ),
              leading: Icon(
                Icons.power_settings_new,
              ),
              onTap: () {
                _signOut().whenComplete(() {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => FirebaseAuthDemo()));
                });
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Users").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.red[900]),
              ));
            }
            return ListView(
              controller: controller,
              children: snapshot.data.docs.map((document) {
                return Center(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red[900], width: 2),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        )),
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            document.data()['username'] + "\n",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          document.data()['title'] + "\n",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.red[900],
                          ),
                        ),
                        Text(
                          document.data()['content'],
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }),
      backgroundColor: Colors.grey[300],
    );
  }

  Future _signOut() async {
    await _auth.signOut();
  }
}

/*

Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                widget.user.displayName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Container(
              child: OutlineButton(
                child: Text("LogOut"),
                onPressed: () {
                  _signOut().whenComplete(() {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => FirebaseAuthDemo()));
                  });
                },
              ),
            ),
          ],
        ),
      ),



 */
//document.data()['content'],
