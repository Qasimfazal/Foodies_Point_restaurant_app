import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/Restaurant/restaurant_login_screen.dart';
import 'package:flutter_restaurant_app/User/user_login_screen.dart';

class Join_Us extends StatefulWidget {
  const Join_Us({Key? key}) : super(key: key);

  @override
  _Join_UsState createState() => _Join_UsState();
}

class _Join_UsState extends State<Join_Us> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFF5F5F5),
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 60.0),
            height: 420.0,
            child: Column(
              children: [
                Image(
                  image: AssetImage('images/logo.jpeg'),
                  width: 220.0,
                  height: 220.0,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Join Us",
                  style: TextStyle(color: Colors.grey, fontSize: 24.0),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return LoginScreen();
                      }));
                    },
                    child: Padding(
                      padding: EdgeInsets.all(17.0),
                      child: Text(
                        "As a User",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
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
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return Restaurant_login();
                      }));
                    },
                    child: Padding(
                      padding: EdgeInsets.all(17.0),
                      child: Text(
                        "As a Restaurant",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
