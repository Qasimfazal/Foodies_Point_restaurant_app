import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/U_Home%20update%20Table/update_table_seat_screen.dart';
import 'package:flutter_restaurant_app/U_checkout/checkout_ReserveTable&Food_screen.dart';
import 'package:flutter_restaurant_app/constant.dart';
//import 'package:flutter_restaurant_app/U_Home%20update/update_table_seat_screen.dart';
import 'package:intl/intl.dart';
import '../U_Home_foods/food_&_category_screen.dart';

class AddMoreFoodScreen extends StatefulWidget {
  final String uID;
  final String tKey;
  final String restaurantID;
  final String rUID;
  final String placeOrder;
  const AddMoreFoodScreen(
      {Key? key,
      required this.uID,
      required this.tKey,
      required this.restaurantID,
      required this.rUID,
      required this.placeOrder})
      : super(key: key);

  @override
  _AddMoreFoodScreenState createState() => _AddMoreFoodScreenState();
}

class _AddMoreFoodScreenState extends State<AddMoreFoodScreen> {
  DatabaseReference? databaseReferenceTableOrder;

  DatabaseReference databaseReferenceUser =
      FirebaseDatabase.instance.reference().child("User");
  DatabaseReference? databaseReference;
  bool? isOrder;
  late String totalOrder;
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('MM-dd');
  final String formatted = formatter.format(now);
  @override
  void initState() {
    databaseReference = FirebaseDatabase.instance
        .reference()
        .child("OrderFood")
        .child(widget.uID)
        .child(widget.tKey);
    databaseReferenceTableOrder = FirebaseDatabase.instance
        .reference()
        .child("TableOrder")
        .child(widget.uID);
    databaseReferenceTableOrder!.onValue.listen((event) {
      setState(() {
        isOrder = event.snapshot.value[widget.tKey];
        print(isOrder);
      });
    });

    databaseReferenceUser.child(widget.uID).onValue.listen((event) {
      setState(() {
        totalOrder = event.snapshot.value['totalOrder'];
      });
    });
    super.initState();
  }

  List foodList = [];

  @override
  Widget build(BuildContext context) {
    if (isOrder == false) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Color(0xFFFFFFFF),
            elevation: 0,
          ),
        ),
        body: Container(
          color: Color(0xFFF5F5F5),
          child: Column(
            children: [
              Container(
                color: Colors.white,
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
                      "Add Your Food",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    "PKR " +
                                                        foodList[index]
                                                            ['fPrice'],
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                                SizedBox(
                                                  height: 4.0,
                                                ),
                                                foodList[index]
                                                            ['fIngredient'] ==
                                                        ""
                                                    ? Text(
                                                        "Ingredients: " + "no",
                                                        style: TextStyle(
                                                            fontSize: 12.0),
                                                        overflow: TextOverflow
                                                            .ellipsis)
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
                                                    style: TextStyle(
                                                        fontSize: 12.0),
                                                    overflow:
                                                        TextOverflow.ellipsis)
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
                                            databaseReference!
                                                .child(
                                                    foodList[index]['oFoodKey'])
                                                .remove();
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              GestureDetector(
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 6.0,
                                      ),
                                      Text(
                                        "Add Foods",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Constant.type = "addFood";
                                  Constant.userID = widget.uID;
                                  Constant.tKey = widget.tKey;
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return FoodCategoryScreen(
                                        restaurantID: widget.restaurantID);
                                  }));
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
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text("Order Total:"),
                                            ),
                                            // int.parse(totalOrder) >= 25 ?
                                            // Text("Rs. "+((count*0.10)+count).toString(), style: TextStyle(color: Colors.red),):
                                            // Text("Rs. "+((count*0.0)+count).toString(), style: TextStyle(color: Colors.red),),
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
                                              Constant.rUID = widget.rUID;
                                              Constant.userID = widget.uID;
                                              Constant.tKey = widget.tKey;
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return CheckOut_Screen();
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
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.white),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Color(0xFFD1413A)),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
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
    } else if (isOrder == true) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Color(0xFFFFFFFF),
            elevation: 0,
          ),
        ),
        body: Container(
          color: Color(0xFFF5F5F5),
          child: Column(
            children: [
              Container(
                color: Colors.white,
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
                      "Order Details",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    "PKR " +
                                                        foodList[index]
                                                            ['fPrice'],
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                                SizedBox(
                                                  height: 4.0,
                                                ),
                                                foodList[index]
                                                            ['fIngredient'] ==
                                                        ""
                                                    ? Text(
                                                        "Ingredients: " + "no",
                                                        style: TextStyle(
                                                            fontSize: 12.0),
                                                        overflow: TextOverflow
                                                            .ellipsis)
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
                                                    style: TextStyle(
                                                        fontSize: 12.0),
                                                    overflow:
                                                        TextOverflow.ellipsis)
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
                                            databaseReference!
                                                .child(
                                                    foodList[index]['oFoodKey'])
                                                .remove();
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              GestureDetector(
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 6.0,
                                      ),
                                      Text(
                                        "Add Foods",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Constant.type = "addFood";
                                  Constant.userID = widget.uID;
                                  Constant.tKey = widget.tKey;
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return FoodCategoryScreen(
                                        restaurantID: widget.restaurantID);
                                  }));
                                },
                              ),
                              GestureDetector(
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 6.0,
                                      ),
                                      Text(
                                        "Update Table Seats",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return UpdateTableSeat(
                                        tkey: widget.tKey,
                                        placeOrder: widget.placeOrder);
                                  }));
                                },
                              ),
                              Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Text(
                                      "You can only modify your order before 2 hours of your ordered time")),
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
    } else {
      return Scaffold(
        body: Container(
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          ),
        ),
      );
    }
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
