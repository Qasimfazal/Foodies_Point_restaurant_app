import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/join_us.dart';
import 'package:flutter_restaurant_app/Restaurant/restaurant_home_screen.dart';
import 'package:flutter_restaurant_app/User/user_home_screen.dart';
import 'constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("User");

  @override
  void initState() {
    final User? user = auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      databaseReference.child(uid).once().then((DataSnapshot dataSnapshot) {
        setState(() {
          if (dataSnapshot.value['uType'] == 'User') {
            Constant.name = dataSnapshot.value['uFirstName'];
            Constant.uLastName = dataSnapshot.value['uLastName'];
            Constant.uAddress = dataSnapshot.value['uAddress'];
            Constant.uPhone = dataSnapshot.value['uPhone'];
            Constant.userID = dataSnapshot.value['uID'];
            Constant.totalOrder = dataSnapshot.value['totalOrder'];
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return User_Home();
            }));
          } else if (dataSnapshot.value['uType'] == 'Restaurant') {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return Restaurant_Home();
            }));
          }
        });
      });
    } else {
      Timer(Duration(seconds: 4), () {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return Join_Us();
        }));
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Color(0xFFF5F5F5),
          elevation: 0,
          brightness: Brightness.light,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFFF5F5F5),
        child: Center(
          child: Container(
            width: double.infinity,
            height: 350.0,
            color: Color(0xFFF5F5F5),
            child: Column(
              children: [
                Image(
                  image: AssetImage('images/logo.jpeg'),
                  width: 250.0,
                  height: 250.0,
                ),
                SizedBox(
                  height: 50.0,
                ),
                CircularProgressIndicator(
                  color: Color(0xFFD1413A),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
