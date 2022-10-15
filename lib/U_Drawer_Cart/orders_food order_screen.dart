import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/U_checkout/checkout_food%20order_screen.dart';
//import 'package:flutter_restaurant_app/U_checkout%20foam/check_out_food_screen.dart';
import 'package:flutter_restaurant_app/constant.dart';
import 'package:intl/intl.dart';

class OrderFood extends StatefulWidget {
  const OrderFood({Key? key}) : super(key: key);

  @override
  _OrderFoodState createState() => _OrderFoodState();
}

class _OrderFoodState extends State<OrderFood> {
  DatabaseReference databaseReference = FirebaseDatabase.instance
      .reference()
      .child("BookFood")
      .child(Constant.userID);
  DatabaseReference databaseReferenceUserCard =
      FirebaseDatabase.instance.reference().child("UserCard");
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference databaseReferenceUser =
      FirebaseDatabase.instance.reference().child("User");
  String? cardID;
  String? rID;
  late String totalOrder;
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('MM-dd');
  final String formatted = formatter.format(now);

  @override
  void initState() {
    final User? user = auth.currentUser;
    String uid = user!.uid;
    databaseReferenceUserCard.child(uid).onValue.listen((event) {
      setState(() {
        cardID = event.snapshot.value['cardID'];
        rID = event.snapshot.value['rID'];
      });
    });

    databaseReferenceUser.child(uid).onValue.listen((event) {
      setState(() {
        totalOrder = event.snapshot.value['totalOrder'];
      });
    });
    super.initState();
  }

  List foodList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Container(
        color: Color(0xFFF5F5F5),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: StreamBuilder(
            stream: databaseReference.child(cardID.toString()).onValue,
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
                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: foodList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 4.0),
                              child: Row(
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: FadeInImage(
                                      placeholder:
                                          AssetImage('images/image_large.png'),
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
                                            foodList[index]['fName'] +
                                                formatted,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                              "PKR " +
                                                  foodList[index]['fPrice'],
                                              style:
                                                  TextStyle(color: Colors.red),
                                              overflow: TextOverflow.ellipsis),
                                          SizedBox(
                                            height: 4.0,
                                          ),
                                          foodList[index]['fIngredient'] == ""
                                              ? Text("Ingredients: " + "no",
                                                  style:
                                                      TextStyle(fontSize: 12.0),
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
                                                  foodList[index]['fQuantity'],
                                              style: TextStyle(fontSize: 12.0),
                                              overflow: TextOverflow.ellipsis)
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Icon(
                                      Icons.delete,
                                      size: 25,
                                      color: Colors.grey,
                                    ),
                                    onTap: () {
                                      databaseReference
                                          .child(cardID.toString())
                                          .child(foodList[index]['oFoodKey'])
                                          .remove();
                                    },
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
                                      // Expanded(
                                      //  child: Text("Tax:"),
                                      // ),
                                      // Text("Rs. " + "0.0"),
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
                                    height: 15.0,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return Check_Out_Food_Screen(
                                              cardID: cardID.toString(),
                                              rID: rID.toString());
                                        }));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          "Proceed to Checkout",
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
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            side: BorderSide(
                                                color: Color(0xFFD1413A)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Container(
                    child: Center(
                        child: Container(
                      height: 200,
                      child: Center(child: Text("No Food Order")),
                    )),
                  );
                }
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
