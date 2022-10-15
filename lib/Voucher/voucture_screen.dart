import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/constant.dart';

class Voucture_Screen extends StatefulWidget {
  const Voucture_Screen({Key? key}) : super(key: key);

  @override
  _Voucture_ScreenState createState() => _Voucture_ScreenState();
}

class _Voucture_ScreenState extends State<Voucture_Screen> {
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
                  "Voucture",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          int.parse(Constant.totalOrder) >= 25
              ? Padding(
                  padding: EdgeInsets.all(20),
                  child: Card(
                      child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Discount",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text("Home Foodies"),
                              Text("Foods & Tables Booking"),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "10%",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffD1413A)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Continue"),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xffD1413A),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
                )
              : Container(
                  child: Text("No Vouture"),
                )
        ],
      ),
    );
  }
}
