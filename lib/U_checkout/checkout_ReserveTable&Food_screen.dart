import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/U_Drawer_Cart/orders_Reserve%20Table%20&%20Food_REVIEW_ORDER_screen.dart';
import 'package:flutter_restaurant_app/constant.dart';

class CheckOut_Screen extends StatefulWidget {
  const CheckOut_Screen({Key? key}) : super(key: key);

  @override
  _CheckOut_ScreenState createState() => _CheckOut_ScreenState();
}

class _CheckOut_ScreenState extends State<CheckOut_Screen> {
  final formKey = GlobalKey<FormState>();

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
                        controller: Constant.textEditingControllerUsername,
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
                        controller: Constant.textEditingControllerAddress,
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
                        padding: EdgeInsets.all(8.0), child: Text("* Country")),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                        validator: validCountry,
                        controller: Constant.textEditingControllerCountry,
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
                          hintText: "Country",
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
                        controller: Constant.textEditingControllerEmail,
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
                          hintText: "GeorgeFloyd@xyz.com",
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
                        controller: Constant.textEditingControllerPhoneNumber,
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
                          hintText: "+92 300 4865818",
                          contentPadding:
                              new EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("* ZIP Code")),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                        controller: Constant.textEditingControllerZipCode,
                        keyboardType: TextInputType.number,
                        maxLength: 5,
                        validator: validZipCode,
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
                          hintText: "ZIP Code",
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
            ))
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
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return ReviewOrder_Screen();
              }));
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

  String? validState(String? value) {
    if (value!.isEmpty) {
      return "Please enter state";
    } else {
      return null;
    }
  }

  String? validCountry(String? value) {
    if (value!.isEmpty) {
      return "Please enter country";
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

  String? validZipCode(String? value) {
    if (value!.isEmpty) {
      return "Please enter zip code";
    } else {
      return null;
    }
  }
}
