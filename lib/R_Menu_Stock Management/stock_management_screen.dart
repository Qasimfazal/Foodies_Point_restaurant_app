import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/R_Menu_Stock%20Management/update_stock_screen.dart';

class Stock_Management_Screen extends StatefulWidget {
  const Stock_Management_Screen({Key? key}) : super(key: key);

  @override
  _Stock_Management_ScreenState createState() =>
      _Stock_Management_ScreenState();
}

class _Stock_Management_ScreenState extends State<Stock_Management_Screen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("Foods");
  List foodList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("Stock Management"),
      ),
      body: Container(
        color: Color(0xFFF5F5F5),
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: StreamBuilder(
                  stream: databaseReference.onValue,
                  builder: (context, AsyncSnapshot<Event> snapshot) {
                    if (snapshot.hasData) {
                      final User? user = auth.currentUser;
                      String uid = user!.uid;
                      foodList.clear();
                      DataSnapshot dataSnapshot = snapshot.data!.snapshot;
                      if (dataSnapshot.value != null) {
                        Map<dynamic, dynamic> values = dataSnapshot.value;
                        values.forEach((key, value) {
                          if (uid == value['uID']) {
                            foodList.add(value);
                          }
                        });
                      }
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: foodList.length,
                        itemBuilder: (context, index) {
                          if (int.parse(foodList[index]['fQuantity']) >=
                              int.parse(
                                  foodList[index]['fRemainingQuantity'])) {
                            return Padding(
                              padding: EdgeInsets.all(4.0),
                              child: GestureDetector(
                                onTap: () {},
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Container(
                                      color: Colors.red[100],
                                      child: Row(
                                        children: [
                                          FadeInImage(
                                            placeholder: AssetImage(
                                                'images/image_large.png'),
                                            image: NetworkImage(
                                                foodList[index]['fImageURl']),
                                            height: 100.0,
                                            width: 100.0,
                                            fit: BoxFit.cover,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          foodList[index]
                                                              ['fName'],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 17.0),
                                                        ),
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                      ),
                                                      SizedBox(
                                                        height: 2.0,
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          "Product Quantity: " +
                                                              foodList[index]
                                                                  ['fQuantity'],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12.0),
                                                        ),
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: Text(
                                                          "Available Quantity: " +
                                                              foodList[index][
                                                                  'fRemainingQuantity'],
                                                          style: TextStyle(
                                                              fontSize: 12.0,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                          child: Row(
                                                            children: [
                                                              Icon(Icons
                                                                  .delivery_dining),
                                                              Text(
                                                                "  Rs. " +
                                                                    foodList[
                                                                            index]
                                                                        [
                                                                        'fPrice'],
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        10.0),
                                                              )
                                                            ],
                                                          )),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return Update_Stock_Screen(
                                                      fKey: foodList[index]
                                                          ['fKey']);
                                                }));
                                              },
                                              child: Icon(Icons.edit)),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsets.all(4.0),
                              child: GestureDetector(
                                onTap: () {},
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Row(
                                      children: [
                                        FadeInImage(
                                          placeholder: AssetImage(
                                              'images/image_large.png'),
                                          image: NetworkImage(
                                              foodList[index]['fImageURl']),
                                          height: 100.0,
                                          width: 100.0,
                                          fit: BoxFit.cover,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        foodList[index]
                                                            ['fName'],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17.0),
                                                      ),
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8.0),
                                                    ),
                                                    SizedBox(
                                                      height: 2.0,
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        "Product Quantity: " +
                                                            foodList[index]
                                                                ['fQuantity'],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12.0),
                                                      ),
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8.0),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8.0),
                                                      child: Text(
                                                        "Available Quantity: " +
                                                            foodList[index][
                                                                'fRemainingQuantity'],
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                    Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons
                                                                .delivery_dining),
                                                            Text(
                                                              "  Rs. " +
                                                                  foodList[
                                                                          index]
                                                                      [
                                                                      'fPrice'],
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      10.0),
                                                            )
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    )),
                              ),
                            );
                          }
                        },
                      );
                    } else {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.red),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
