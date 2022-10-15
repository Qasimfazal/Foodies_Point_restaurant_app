import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/R_Menu_Table%20Order/show_table_order_details_screen.dart';

class TableOrder_Screen extends StatefulWidget {
  const TableOrder_Screen({Key? key}) : super(key: key);

  @override
  _TableOrder_ScreenState createState() => _TableOrder_ScreenState();
}

class _TableOrder_ScreenState extends State<TableOrder_Screen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("PlaceOrder").child('Table');
  List tableOrderList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("Table Orders"),
      ),
      body: Container(
        child: Container(
          child: StreamBuilder(
            stream: databaseReference.onValue,
            builder: (context, AsyncSnapshot<Event> snapshot) {
              if (snapshot.hasData) {
                final User? user = auth.currentUser;
                String uid = user!.uid;
                tableOrderList.clear();
                DataSnapshot dataSnapshot = snapshot.data!.snapshot;
                if (dataSnapshot.value != null) {
                  Map<dynamic, dynamic> values = dataSnapshot.value;
                  values.forEach((key, value) {
                    tableOrderList.add(value);
                  });
                }
                return ListView.builder(
                  itemCount: tableOrderList.length,
                  itemBuilder: (context, index) {
                    if (uid == tableOrderList[index]['rUID']) {
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
                                  return ShowTableOrder_Screen(
                                      userID: tableOrderList[index]['userID'],
                                      tKey: tableOrderList[index]['tKey']);
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
                                                tableOrderList[index]
                                                    ['userName'],
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
                                                tableOrderList[index]
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
                                        'Country : ',
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                tableOrderList[index]
                                                    ['country'],
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.grey),
                                              ))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Zip Code : ',
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                tableOrderList[index]
                                                    ['zipCode'],
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.grey),
                                              ))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Table no : ',
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                tableOrderList[index]['tno'],
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.grey),
                                              ))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Table : ',
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                tableOrderList[index]['tSeat'],
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
                                                tableOrderList[index]['email'],
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
                                                tableOrderList[index]['phone'],
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
