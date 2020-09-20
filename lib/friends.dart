import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './homepage.dart';

class Friends extends StatefulWidget {
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  FirebaseAuth _auth = FirebaseAuth.instance;

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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("NewUsers").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.red[900]),
              ));
            }
            return ListView(
              children: snapshot.data.docs.map((document) {
                return Center(
                  child: Container(
                    // padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        )),
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: 60,
                    child: ListView(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.account_circle,
                            size: 30,
                          ),
                          trailing: IconButton(
                              icon: Icon(
                                Icons.person_add,
                                size: 30,
                              ),
                              onPressed: () {}),
                          title: Text(
                            document.data()['username'],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
