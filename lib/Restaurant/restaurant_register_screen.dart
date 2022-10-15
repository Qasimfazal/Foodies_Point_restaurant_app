import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/progress_dialog.dart';

class RestaurantRegisterScreen extends StatefulWidget {
  const RestaurantRegisterScreen({Key? key}) : super(key: key);

  @override
  _RestaurantRegisterScreenState createState() =>
      _RestaurantRegisterScreenState();
}

class _RestaurantRegisterScreenState extends State<RestaurantRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true, _isObscureConfirm = true;
  TextEditingController _textEditingControllerFirstName =
      new TextEditingController();
  TextEditingController _textEditingControllerLastName =
      new TextEditingController();
  TextEditingController _textEditingControllerPhone =
      new TextEditingController();
  TextEditingController _textEditingControllerAddress =
      new TextEditingController();
  TextEditingController _textEditingControllerPassword =
      new TextEditingController();
  TextEditingController _textEditingControllerConfirmPassword =
      new TextEditingController();
  TextEditingController _textEditingControllerEmail =
      new TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("User");
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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            width: double.infinity,
            height: 70.0,
            color: Color(0xFFF5F5F5),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back_ios),
                ),
                Container(
                  child: Text(
                    "Restaurant Register",
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
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
              child: Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Form(
                    key: _formKey,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 30.0),
                      width: double.infinity,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _textEditingControllerFirstName,
                            validator: validUserName,
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
                              prefixIcon: Icon(
                                Icons.person,
                                color: Color(0xFF666666),
                              ),
                              hintStyle: TextStyle(
                                color: Color(0xFF666666),
                              ),
                              fillColor: Color(0xFFE6E4E4),
                              filled: true,
                              hintText: "First name",
                            ),
                          ),
                          SizedBox(
                            height: 14.0,
                          ),
                          TextFormField(
                            controller: _textEditingControllerLastName,
                            validator: validLastName,
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
                              prefixIcon: Icon(
                                Icons.person,
                                color: Color(0xFF666666),
                              ),
                              hintStyle: TextStyle(
                                color: Color(0xFF666666),
                              ),
                              fillColor: Color(0xFFE6E4E4),
                              filled: true,
                              hintText: "Last name",
                            ),
                          ),
                          SizedBox(
                            height: 14.0,
                          ),
                          TextFormField(
                            controller: _textEditingControllerEmail,
                            validator: validEmail,
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
                              prefixIcon: Icon(
                                Icons.email,
                                color: Color(0xFF666666),
                              ),
                              hintStyle: TextStyle(
                                color: Color(0xFF666666),
                              ),
                              fillColor: Color(0xFFE6E4E4),
                              filled: true,
                              hintText: "Email Address",
                            ),
                          ),
                          SizedBox(
                            height: 14.0,
                          ),
                          TextFormField(
                            controller: _textEditingControllerPhone,
                            validator: validPhone,
                            keyboardType: TextInputType.phone,
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
                                Icons.phone,
                                color: Color(0xFF666666),
                              ),
                              hintStyle: TextStyle(
                                color: Color(0xFF666666),
                              ),
                              fillColor: Color(0xFFE6E4E4),
                              filled: true,
                              hintText: "Phone:",
                            ),
                          ),
                          SizedBox(
                            height: 14.0,
                          ),
                          TextFormField(
                            controller: _textEditingControllerAddress,
                            validator: validAddress,
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
                              prefixIcon: Icon(
                                Icons.location_city,
                                color: Color(0xFF666666),
                              ),
                              hintStyle: TextStyle(
                                color: Color(0xFF666666),
                              ),
                              fillColor: Color(0xFFE6E4E4),
                              filled: true,
                              hintText: "Address",
                            ),
                          ),
                          SizedBox(
                            height: 14.0,
                          ),
                          TextFormField(
                            validator: validPassword,
                            controller: _textEditingControllerPassword,
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
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Color(0xFF666666),
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
                              hintStyle: TextStyle(
                                color: Color(0xFF666666),
                              ),
                              fillColor: Color(0xFFE6E4E4),
                              filled: true,
                              hintText: "Password",
                            ),
                          ),
                          SizedBox(
                            height: 14.0,
                          ),
                          TextFormField(
                            validator: validConfirmPassword,
                            controller: _textEditingControllerConfirmPassword,
                            obscureText: _isObscureConfirm,
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
                                    _isObscureConfirm = !_isObscureConfirm;
                                  });
                                },
                                icon: Icon(
                                  _isObscureConfirm
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
                              hintText: "Confirm Password",
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  if (_textEditingControllerPassword.text !=
                                      _textEditingControllerConfirmPassword
                                          .text) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Password not match')));
                                  } else {
                                    _signIn();
                                  }
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.all(17.0),
                                child: Text(
                                  "Register",
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
                            height: 40.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text("Already have an account"),
                            ),
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

  String? validUserName(String? username) {
    if (username!.isEmpty) {
      return "Please enter first name";
    } else {
      return null;
    }
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

  String? validPhone(String? phone) {
    if (phone!.isEmpty) {
      return "Please enter phone number";
    } else {
      return null;
    }
  }

  String? validAddress(String? address) {
    if (address!.isEmpty) {
      return "Please enter your address";
    } else {
      return null;
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

  String? validConfirmPassword(String? password) {
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
          .createUserWithEmailAndPassword(
              email: _textEditingControllerEmail.text.toString().trim(),
              password: _textEditingControllerPassword.text.toString().trim())
          .then((UserCredential userCredential) {
        if (userCredential != null) {
          final User? user = auth.currentUser;
          final uid = user!.uid;
          databaseReference.child(uid).set({
            'uFirstName':
                _textEditingControllerFirstName.text.toString().trim(),
            'uLastName': _textEditingControllerLastName.text.toString().trim(),
            'uEmail': _textEditingControllerEmail.text.toString().trim(),
            'uPhone': _textEditingControllerPhone.text.toString().trim(),
            'uAddress': _textEditingControllerAddress.text.toString().trim(),
            'uPassword': _textEditingControllerPassword.text.toString().trim(),
            'uImage': 'null',
            'uType': 'Restaurant',
            'uID': uid,
          });
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Register Successfully')));
          print("Register Successfully");
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
      }).catchError((error) {
        print(error.toString());
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User already register')));
      });
    } catch (error) {
      print(error);
    }
  }

  String? validLastName(String? lastname) {
    if (lastname!.isEmpty) {
      return "Please enter last name";
    } else {
      return null;
    }
  }
}
