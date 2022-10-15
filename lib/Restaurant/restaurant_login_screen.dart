import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../forget_screen.dart';
import 'package:flutter_restaurant_app/progress_dialog.dart';
import 'package:flutter_restaurant_app/Restaurant/restaurant_home_screen.dart';
import 'package:flutter_restaurant_app/Restaurant/restaurant_register_screen.dart';

class Restaurant_login extends StatefulWidget {
  const Restaurant_login({Key? key}) : super(key: key);

  @override
  _Restaurant_loginState createState() => _Restaurant_loginState();
}

class _Restaurant_loginState extends State<Restaurant_login> {
  final formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  TextEditingController _textEditingControllerPassword =
      new TextEditingController();
  TextEditingController _textEditingControllerEmail =
      new TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("User");
  String os = Platform.operatingSystem; //in your code
  @override
  Widget build(BuildContext context) {
    print(os);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Color(0xFFF5F5F5),
          elevation: 0,
          brightness: Brightness.light,
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            width: double.infinity,
            height: 70.0,
            color: Color(0xFFF5F5F5),
            child: Row(
              children: [
                Container(
                  child: Text(
                    "Restaurant Login",
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: os == "ios"
                        ? Container()
                        : GestureDetector(
                            onTap: () {
                              SystemNavigator.pop();
                            },
                            child: Icon(
                              Icons.close,
                              size: 35,
                              color: Color(0xFFD1413A),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Color(0xFFF5F5F5),
              width: double.infinity,
              child: Center(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 30.0),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage('images/logo.jpeg'),
                            width: 220.0,
                            height: 220.0,
                          ),
                          SizedBox(
                            height: 80.0,
                          ),
                          TextFormField(
                            controller: _textEditingControllerEmail,
                            keyboardType: TextInputType.emailAddress,
                            validator: validEmail,
                            cursorColor: Color(0xFFD1413A),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Color(0xFF666666),
                              ),
                              hintStyle: TextStyle(
                                color: Color(0xFF666666),
                              ),
                              fillColor: Color(0xFFE6E4E4),
                              filled: true,
                              hintText: "Email",
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                            controller: _textEditingControllerPassword,
                            validator: validPassword,
                            obscureText: _isObscure,
                            cursorColor: Color(0xFFD1413A),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              suffixIcon: IconButton(
                                color: Color(0xFF666666),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                                icon: Icon(
                                  _isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Color(0xFF666666),
                              ),
                              hintStyle: TextStyle(
                                color: Color(0xFF666666),
                              ),
                              fillColor: Color(0xFFE6E4E4),
                              filled: true,
                              hintText: "Password",
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return ForgetPassword_Screen();
                              }));
                            },
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(vertical: 17.0),
                              child: Text(
                                "Forgot your password?",
                                textAlign: TextAlign.end,
                                style: TextStyle(color: Color(0xFF666666)),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  _signIn();
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.all(17.0),
                                child: Text(
                                  "Login",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xFFD1413A)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: BorderSide(color: Color(0xFFD1413A)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return RestaurantRegisterScreen();
                              }));
                            },
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account? ",
                                    style: TextStyle(color: Color(0xFF666666)),
                                  ),
                                  Text(
                                    "Sign Up",
                                    style: TextStyle(color: Color(0xFFD1413A)),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? validEmail(String? email) {
    if (email!.isEmpty) {
      return "Please enter email";
    } else {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
      if (!emailValid) {
        return "Please enter valid email";
      } else {
        return null;
      }
    }
  }

  String? validPassword(String? password) {
    if (password!.isEmpty) {
      return "Please enter password";
    } else {
      if (password.length <= 5) {
        return "Password length must be greater then 5";
      } else {
        return null;
      }
    }
  }

  void _signIn() {
    showDialog(
        context: context,
        builder: (context) {
          return Progress_Dialog(message: "Please wait...");
        });
    try {
      auth
          .signInWithEmailAndPassword(
              email: _textEditingControllerEmail.text.toString().trim(),
              password: _textEditingControllerPassword.text.toString().trim())
          .then((UserCredential userCredential) {
        if (userCredential != null) {
          final User? user = auth.currentUser;
          String uid = user!.uid;
          databaseReference.child(uid).once().then((DataSnapshot dataSnapshot) {
            setState(() {
              if (dataSnapshot.value['uType'] == "Restaurant") {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Login Successfully')));
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return Restaurant_Home();
                }));
                print("Login Successfully");
              } else {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('User not exist')));
              }
            });
          });
        }
      }).catchError((error) {
        print(error.toString());
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'There is no user record corresponding to this identifier')));
      });
    } catch (error) {
      print(error);
    }
  }
}
