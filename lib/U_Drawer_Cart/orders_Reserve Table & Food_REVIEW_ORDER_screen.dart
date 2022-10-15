import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/U_checkout/order_place_screen.Congratulation.dart';

import '../constant.dart';

class ReviewOrder_Screen extends StatefulWidget {
  const ReviewOrder_Screen({Key? key}) : super(key: key);

  @override
  _ReviewOrder_ScreenState createState() => _ReviewOrder_ScreenState();
}

class _ReviewOrder_ScreenState extends State<ReviewOrder_Screen> {
  DatabaseReference databaseReferencePlaceOrder =
      FirebaseDatabase.instance.reference().child("PlaceOrder").child("Table");
  DatabaseReference databaseReferenceOrderTable =
      FirebaseDatabase.instance.reference().child("OrderTable");
  DatabaseReference? databaseReferenceTableOrder;
  DatabaseReference? databaseReference;
  bool? isOrder;

  DatabaseReference databaseReferenceUser =
      FirebaseDatabase.instance.reference().child("User");
  FirebaseAuth auth = FirebaseAuth.instance;
  late String totalOrder;

  @override
  void initState() {
    final User? user = auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      databaseReferenceUser.child(uid).onValue.listen((event) {
        setState(() {
          totalOrder = event.snapshot.value['totalOrder'];
        });
      });
    }
    databaseReference = FirebaseDatabase.instance
        .reference()
        .child("OrderFood")
        .child(Constant.userID)
        .child(Constant.tKey);
    databaseReferenceTableOrder = FirebaseDatabase.instance
        .reference()
        .child("TableOrder")
        .child(Constant.userID);
    databaseReferenceTableOrder!.onValue.listen((event) {
      setState(() {
        isOrder = event.snapshot.value[Constant.tKey];
        print(isOrder);
      });
    });
    super.initState();
  }

  List foodList = [];
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
                    "Review Order",
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
                                      int.parse(totalOrder) >= 25
                                          ? Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      "Discount Vouture  10%:"),
                                                ),
                                                Text("Rs. " +
                                                    (count * 0.10).toString()),
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      "Discount Vouture  0%:"),
                                                ),
                                                Text("Rs. " +
                                                    (count * 0.0).toString()),
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
                                          int.parse(totalOrder) >= 25
                                              ? Text(
                                                  "Rs. " +
                                                      ((count * 0.10) + count)
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                )
                                              : Text(
                                                  "Rs. " +
                                                      ((count * 0.0) + count)
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
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
      bottomSheet: Container(
        margin: EdgeInsets.all(10.0),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            String autoID = databaseReferencePlaceOrder.push().key;
            databaseReferencePlaceOrder.child(autoID).set({
              'userName':
                  Constant.textEditingControllerUsername.text.toString(),
              'address': Constant.textEditingControllerAddress.text.toString(),
              'country': Constant.textEditingControllerCountry.text.toString(),
              'email': Constant.textEditingControllerEmail.text.toString(),
              'phone':
                  Constant.textEditingControllerPhoneNumber.text.toString(),
              'zipCode': Constant.textEditingControllerZipCode.text.toString(),
              'userID': Constant.userID,
              'tno': Constant.tno,
              'rUID': Constant.rUID,
              'tKey': Constant.tKey,
              'tSeat': Constant.tSeat,
              'pID': autoID,
            }).then((value) {
              DatabaseReference databaseReferenceTableOrder = FirebaseDatabase
                  .instance
                  .reference()
                  .child("TableOrder")
                  .child(Constant.userID);
              databaseReferenceTableOrder.child(Constant.tKey).set(true);
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return OrderPlace_Screen();
              }));
            });
            databaseReferenceOrderTable
                .child(Constant.userID)
                .child(Constant.tKey)
                .child("placeOrder")
                .set(autoID);
            String updateOrder = (int.parse(totalOrder) + 1).toString();
            final User? user = auth.currentUser;
            String uid = user!.uid;
            databaseReferenceUser
                .child(uid)
                .child("totalOrder")
                .set(updateOrder);
          },
          child: Padding(
            padding: EdgeInsets.all(14.0),
            child: Text(
              "Place Order",
              style: TextStyle(fontSize: 18),
            ),
          ),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
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
    );
  }
}
