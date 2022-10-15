import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/U-R_Show%20Details_food_order_details_screen.dart';

class FoodOrder_Screen extends StatefulWidget {
  const FoodOrder_Screen({Key? key}) : super(key: key);

  @override
  _FoodOrder_ScreenState createState() => _FoodOrder_ScreenState();
}

class _FoodOrder_ScreenState extends State<FoodOrder_Screen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("ResturantFoodOrder");
  List foodOrderList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("Food Order"),
      ),
      body: Container(
        child: Container(
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
                    if (uid == foodOrderList[index]['rID']) {
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
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return ShowFoodOrder_Screen(
                                      uID: foodOrderList[index]['uID'],
                                      cardID: foodOrderList[index]['cardID']);
                                }));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'User name : ',
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                foodOrderList[index]['name'],
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
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                foodOrderList[index]['address'],
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
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                foodOrderList[index]['email'],
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
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                foodOrderList[index]['phone'],
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
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                foodOrderList[index]['dates'],
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
        ),
      ),
    );
  }
}
