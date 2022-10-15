import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShowFoodOrder_Screen extends StatefulWidget {
  final String uID;
  final String cardID;
  ShowFoodOrder_Screen({Key? key, required this.uID, required this.cardID})
      : super(key: key);

  @override
  _ShowFoodOrder_ScreenState createState() => _ShowFoodOrder_ScreenState();
}

class _ShowFoodOrder_ScreenState extends State<ShowFoodOrder_Screen> {
  DatabaseReference? databaseReference;
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference databaseReferenceUser =
      FirebaseDatabase.instance.reference().child("User");
  late String totalOrder;
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('MM-dd');
  final String formatted = formatter.format(now);
  @override
  void initState() {
    databaseReferenceUser.child(widget.uID).onValue.listen((event) {
      setState(() {
        totalOrder = event.snapshot.value['totalOrder'];
      });
    });
    databaseReference = FirebaseDatabase.instance
        .reference()
        .child("BookFood")
        .child(widget.uID)
        .child(widget.cardID);
    super.initState();
  }

  List foodList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
        brightness: Brightness.dark,
      ),
      body: Container(
        color: Color(0xFFF5F5F5),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: StreamBuilder(
                  stream: databaseReference!.onValue,
                  builder: (context, AsyncSnapshot<Event> snapshot) {
                    double count = 0;
                    if (snapshot.hasData) {
                      foodList.clear();
                      DataSnapshot dataSnapshot = snapshot.data!.snapshot;
                      if (dataSnapshot.value != null) {
                        Map<dynamic, dynamic> values = dataSnapshot.value;
                        values.forEach((key, value) {
                          foodList.add(value);
                          count = count + double.parse(value['tPrice']);
                        });

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: foodList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 4.0),
                                  child: Row(
                                    children: [
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: FadeInImage(
                                          placeholder: AssetImage(
                                              'images/image_large.png'),
                                          image: NetworkImage(
                                              foodList[index]['fImageURl']),
                                          fit: BoxFit.cover,
                                          width: 80.0,
                                          height: 80.0,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8.0,
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                foodList[index]['fName'],
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                  "PKR " +
                                                      foodList[index]['fPrice'],
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                              SizedBox(
                                                height: 4.0,
                                              ),
                                              foodList[index]['fIngredient'] ==
                                                      ""
                                                  ? Text("Ingredients: " + "no",
                                                      style: TextStyle(
                                                          fontSize: 12.0),
                                                      overflow:
                                                          TextOverflow.ellipsis)
                                                  : Text(
                                                      "Ingredients: " +
                                                          foodList[index]
                                                              ['fIngredient'],
                                                      style: TextStyle(
                                                          fontSize: 12.0)),
                                              Text(
                                                  "Quantity: " +
                                                      foodList[index]
                                                          ['fQuantity'],
                                                  style:
                                                      TextStyle(fontSize: 12.0),
                                                  overflow:
                                                      TextOverflow.ellipsis)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            Container(
                              margin: EdgeInsets.all(12.0),
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text("Subtotal:"),
                                          ),
                                          Text("Rs. " + count.toString()),
                                        ],
                                      ),
                                      _getDiscount(count),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text("Tax:"),
                                          ),
                                          Text("Rs. " + "0.0"),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text("Order Total:"),
                                          ),
                                          _getTotalOrder(count),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      } else {
                        return Container(
                          child: Center(
                              child: Container(
                            height: 200,
                            child: Center(child: Text("No Food Added")),
                          )),
                        );
                      }
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

  Widget _getDiscount(double count) {
    if (formatted == "03-23") {
      return Row(
        children: [
          Expanded(
            child: Text("Discount Vouture 15%:"),
          ),
          Text("Rs. " + (count * 0.15).toString()),
        ],
      );
    } else if (formatted == "08-14") {
      return Row(
        children: [
          Expanded(
            child: Text("Discount Vouture 20%:"),
          ),
          Text("Rs. " + (count * 0.20).toString()),
        ],
      );
    } else {
      if (int.parse(totalOrder) >= 25) {
        return Row(
          children: [
            Expanded(
              child: Text("Discount Vouture 10%:"),
            ),
            Text("Rs. " + (count * 0.10).toString()),
          ],
        );
      } else {
        return Row(
          children: [
            Expanded(
              child: Text("Discount Vouture  0%:"),
            ),
            Text("Rs. " + (count * 0.0).toString()),
          ],
        );
      }
    }
  }

  Widget _getTotalOrder(double count) {
    if (formatted == "03-23") {
      return Text(
        "Rs. " + (count - (count * 0.15)).toString(),
        style: TextStyle(color: Colors.red),
      );
    } else if (formatted == "08-14") {
      return Text(
        "Rs. " + (count - (count * 0.20)).toString(),
        style: TextStyle(color: Colors.red),
      );
    } else {
      if (int.parse(totalOrder) >= 25) {
        return Text(
          "Rs. " + (count - (count * 0.10)).toString(),
          style: TextStyle(color: Colors.red),
        );
      } else {
        return Text(
          "Rs. " + (count - (count * 0.0)).toString(),
          style: TextStyle(color: Colors.red),
        );
      }
    }
  }
}
