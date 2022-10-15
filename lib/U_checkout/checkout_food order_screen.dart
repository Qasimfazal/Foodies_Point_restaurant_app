import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constant.dart';

class Check_Out_Food_Screen extends StatefulWidget {
  final String cardID;
  final String rID;
  Check_Out_Food_Screen({Key? key, required this.cardID, required this.rID})
      : super(key: key);

  @override
  _Check_Out_Food_ScreenState createState() => _Check_Out_Food_ScreenState();
}

class _Check_Out_Food_ScreenState extends State<Check_Out_Food_Screen> {
  TextEditingController textEditingControllerName = new TextEditingController();
  TextEditingController textEditingControllerAddress =
      new TextEditingController();
  TextEditingController textEditingControllerEmail =
      new TextEditingController();
  TextEditingController textEditingControllerPhone =
      new TextEditingController();
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("ResturantFoodOrder");
  DatabaseReference databaseReferenceHistory =
      FirebaseDatabase.instance.reference().child("HistoryFoodOrder");
  DatabaseReference databaseReferenceUserCard =
      FirebaseDatabase.instance.reference().child("UserCard");
  final DateFormat formatter = DateFormat('MM/dd/yyyy');
  final formKey = GlobalKey<FormState>();
  DatabaseReference databaseReferenceUser =
      FirebaseDatabase.instance.reference().child("User");
  FirebaseAuth auth = FirebaseAuth.instance;
  late String totalOrder;
  @override
  void initState() {
    final User? user = auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      databaseReferenceUser.child(uid).onValue.listen((event) {
        setState(() {
          totalOrder = event.snapshot.value['totalOrder'];
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String createDate = formatter.format(DateTime.now());
    print(createDate);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Color(0xFFFFFFFF),
          elevation: 0,
        ),
      ),
      body: Container(
        color: Color(0xFFF5F5F5),
        child: Column(
          children: [
            Container(
              color: Colors.white,
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
                    "Checkout",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "Booking Address",
                            style: TextStyle(fontSize: 17.0),
                          )),
                    ),
                    Padding(
                        padding: EdgeInsets.all(8.0), child: Text("* Name")),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                        validator: validName,
                        controller: textEditingControllerName,
                        keyboardType: TextInputType.emailAddress,
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
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          fillColor: Color(0xFFFFFFFF),
                          filled: true,
                          hintText: "Name",
                          contentPadding:
                              new EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("* Address Line")),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                        validator: validaddress,
                        controller: textEditingControllerAddress,
                        keyboardType: TextInputType.emailAddress,
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
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          fillColor: Color(0xFFFFFFFF),
                          filled: true,
                          hintText: "Address Line",
                          contentPadding:
                              new EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(8.0), child: Text("* Email")),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                        validator: validEmail,
                        controller: textEditingControllerEmail,
                        keyboardType: TextInputType.emailAddress,
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
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          fillColor: Color(0xFFFFFFFF),
                          filled: true,
                          hintText: "xxxx@xyz.com",
                          contentPadding:
                              new EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(8.0), child: Text("* Phone")),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                        validator: validPhone,
                        controller: textEditingControllerPhone,
                        keyboardType: TextInputType.number,
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
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          fillColor: Color(0xFFFFFFFF),
                          filled: true,
                          hintText: "+00000000000",
                          contentPadding:
                              new EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100.0,
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
      bottomSheet: Container(
        margin: EdgeInsets.all(10.0),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              databaseReference.push().set({
                'name': textEditingControllerName.text.toString(),
                'address': textEditingControllerAddress.text.toString(),
                'email': textEditingControllerEmail.text.toString(),
                'phone': textEditingControllerPhone.text.toString(),
                'dates': formatter.format(DateTime.now()).toString(),
                'uID': Constant.userID,
                'rID': widget.rID,
                'cardID': widget.cardID,
                'rFoodOrderKey': databaseReference.push().key
              });
              databaseReferenceHistory.push().set({
                'name': textEditingControllerName.text.toString(),
                'address': textEditingControllerAddress.text.toString(),
                'email': textEditingControllerEmail.text.toString(),
                'phone': textEditingControllerPhone.text.toString(),
                'dates': formatter.format(DateTime.now()).toString(),
                'uID': Constant.userID,
                'rID': widget.rID,
                'cardID': widget.cardID,
                'rFoodOrderKey': databaseReference.push().key
              });
              databaseReferenceUserCard
                  .child(Constant.userID)
                  .child('cardID')
                  .set(databaseReferenceUserCard.push().key);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Save & Continue')));
              String updateOrder = (int.parse(totalOrder) + 1).toString();
              final User? user = auth.currentUser;
              String uid = user!.uid;
              databaseReferenceUser
                  .child(uid)
                  .child("totalOrder")
                  .set(updateOrder);
            }
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

  String? validName(String? value) {
    if (value!.isEmpty) {
      return "Please enter name";
    } else {
      return null;
    }
  }

  String? validaddress(String? value) {
    if (value!.isEmpty) {
      return "Please enter address";
    } else {
      return null;
    }
  }

  String? validPhone(String? value) {
    if (value!.isEmpty) {
      return "Please enter phone";
    } else {
      return null;
    }
  }
}
