import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/progress_dialog.dart';

class ForgetPassword_Screen extends StatefulWidget {
  const ForgetPassword_Screen({Key? key}) : super(key: key);

  @override
  _ForgetPassword_ScreenState createState() => _ForgetPassword_ScreenState();
}

class _ForgetPassword_ScreenState extends State<ForgetPassword_Screen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _textEditingControllerEmail =
      new TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
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
                  "Forget Password",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Form(
            key: formKey,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30.0),
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    validator: validEmail,
                    controller: _textEditingControllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Color(0xFFD1413A),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          _forgetPassword();
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(17.0),
                        child: Text(
                          "Send",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFFD1413A)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(color: Color(0xFFD1413A)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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

  void _forgetPassword() {
    showDialog(
        context: context,
        builder: (context) {
          return Progress_Dialog(message: "Please wait...");
        });
    try {
      auth
          .sendPasswordResetEmail(
              email: _textEditingControllerEmail.text.toString().trim())
          .then((value) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Please check your email")));
      }).catchError((error) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      });
    } catch (error) {
      print(error);
    }
  }
}
