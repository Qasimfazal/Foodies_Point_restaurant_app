import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/U-R_Show%20Details_food_order_details_screen.dart';

class Order_History_Screen extends StatefulWidget {
  const Order_History_Screen({Key? key}) : super(key: key);

  @override
  _Order_History_ScreenState createState() => _Order_History_ScreenState();
}

class _Order_History_ScreenState extends State<Order_History_Screen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("HistoryFoodOrder");
  List foodOrderList = [];
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
        child: Column(
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
                    "History",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: databaseReference.onValue,
                builder: (context, AsyncSnapshot<Event> snapshot) {
                  if (snapshot.hasData) {
                    final User? user = auth.currentUser;
                    String uid = user!.uid;
                    foodOrderList.clear();
                    DataSnapshot dataSnapshot = snapshot.data!.snapshot;
                    if (dataSnapshot.value != null) {
                      Map<dynamic, dynamic> values = dataSnapshot.value;
                      values.forEach((key, value) {
                        foodOrderList.add(value);
                      });
                    }
                    return ListView.builder(
                      itemCount: foodOrderList.length,
                      itemBuilder: (context, index) {
                        if (uid == foodOrderList[index]['uID']) {
                          return Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return ShowFoodOrder_Screen(
                                          uID: foodOrderList[index]['uID'],
                                          cardID: foodOrderList[index]
                                              ['cardID']);
                                    }));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'User name : ',
                                            style: TextStyle(fontSize: 14.0),
                                          ),
                                          Expanded(
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    foodOrderList[index]
                                                        ['name'],
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.grey),
                                                  ))),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Address :',
                                            style: TextStyle(fontSize: 14.0),
                                          ),
                                          Expanded(
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    foodOrderList[index]
                                                        ['address'],
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.grey),
                                                  ))),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Email : ',
                                            style: TextStyle(fontSize: 14.0),
                                          ),
                                          Expanded(
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    foodOrderList[index]
                                                        ['email'],
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.grey),
                                                  ))),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Phone : ',
                                            style: TextStyle(fontSize: 14.0),
                                          ),
                                          Expanded(
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    foodOrderList[index]
                                                        ['phone'],
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.grey),
                                                  ))),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Date : ',
                                            style: TextStyle(fontSize: 14.0),
                                          ),
                                          Expanded(
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    foodOrderList[index]
                                                        ['dates'],
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.grey),
                                                  ))),
                                        ],
                                      ),
                                      Center(
                                          child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                "Show Details",
                                                style: TextStyle(fontSize: 20),
                                              )))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    );
                  } else {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        ),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
