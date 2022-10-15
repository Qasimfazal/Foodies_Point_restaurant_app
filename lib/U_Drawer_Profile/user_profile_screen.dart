import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/constant.dart';

class User_Profile_Screen extends StatefulWidget {
  const User_Profile_Screen({Key? key}) : super(key: key);

  @override
  _User_Profile_ScreenState createState() => _User_Profile_ScreenState();
}

class _User_Profile_ScreenState extends State<User_Profile_Screen> {
  TextEditingController textEditingControllerFirstName =
      TextEditingController();
  TextEditingController textEditingControllerLastName = TextEditingController();
  TextEditingController textEditingControllerAddress = TextEditingController();
  TextEditingController textEditingControllerPhone = TextEditingController();

  String userName = "";
  String phoneNumber = "";
  String address = "";
  String userLast = "";
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("User");
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    final User? user = auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      Constant.userID = user.uid;
      databaseReference.child(uid).onValue.listen((event) {
        setState(() {
          userName = event.snapshot.value['uFirstName'];
          userLast = event.snapshot.value['uLastName'];
          address = event.snapshot.value['uAddress'];
          phoneNumber = event.snapshot.value['uPhone'];
          textEditingControllerFirstName.text = userName;
          textEditingControllerAddress.text = address;
          textEditingControllerPhone.text = phoneNumber;
          textEditingControllerLastName.text = userLast;
        });
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
          backgroundColor: Color(0xFFFFFFFF),
          elevation: 0,
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            height: 60.0,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 18.0,
                      color: Colors.black,
                    )),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "Profile",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Color(0xFFF5F5F5),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: TextFormField(
                      controller: textEditingControllerFirstName,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Color(0xFFD1413A),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            width: 1,
                          ),
                        ),
                        hintStyle: TextStyle(
                          color: Color(0xFF666666),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "First Name*",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: TextFormField(
                      controller: textEditingControllerLastName,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Color(0xFFD1413A),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            width: 1,
                          ),
                        ),
                        hintStyle: TextStyle(
                          color: Color(0xFF666666),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Last Name*",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: TextFormField(
                      controller: textEditingControllerAddress,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Color(0xFFD1413A),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            width: 1,
                          ),
                        ),
                        hintStyle: TextStyle(
                          color: Color(0xFF666666),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Address*",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: TextFormField(
                      controller: textEditingControllerPhone,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Color(0xFFD1413A),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            width: 1,
                          ),
                        ),
                        hintStyle: TextStyle(
                          color: Color(0xFF666666),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Phone*",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        margin: EdgeInsets.all(18.0),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            databaseReference
                .child(Constant.userID)
                .child("uFirstName")
                .set(textEditingControllerFirstName.text);
            databaseReference
                .child(Constant.userID)
                .child("uLastName")
                .set(textEditingControllerLastName.text);
            databaseReference
                .child(Constant.userID)
                .child("uAddress")
                .set(textEditingControllerAddress.text);
            databaseReference
                .child(Constant.userID)
                .child("uPhone")
                .set(textEditingControllerPhone.text);
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Profile Updated')));
          },
          child: Padding(
            padding: EdgeInsets.all(14.0),
            child: Text(
              "Save & Continue",
              style: TextStyle(fontSize: 18),
            ),
          ),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor:
                MaterialStateProperty.all<Color>(Color(0xFFD1413A)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: Color(0xFFD1413A)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
