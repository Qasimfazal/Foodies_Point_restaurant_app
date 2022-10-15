import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/constant.dart';

class FoodDetailScreen extends StatefulWidget {
  final String fName;
  final String fPrice;
  final String fCookTime;
  final String fImageURl;
  final String fKey;
  final String fRemainingQuantity;
  final String rID;
  const FoodDetailScreen(
      {Key? key,
      required this.fName,
      required this.fPrice,
      required this.fCookTime,
      required this.fImageURl,
      required this.fKey,
      required this.fRemainingQuantity,
      required this.rID})
      : super(key: key);

  @override
  _FoodDetailScreenState createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  bool isChecked = false;
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("Ingredient");
  DatabaseReference databaseReferenceFood =
      FirebaseDatabase.instance.reference().child("Foods");
  DatabaseReference databaseReferenceTable =
      FirebaseDatabase.instance.reference().child("Tables");
  DatabaseReference databaseReferenceOrderTable =
      FirebaseDatabase.instance.reference().child("OrderTable");
  DatabaseReference databaseReferenceTableOrder =
      FirebaseDatabase.instance.reference().child("TableOrder");
  DatabaseReference databaseReferenceOrderFood =
      FirebaseDatabase.instance.reference().child("OrderFood");
  DatabaseReference databaseReferenceBookFood =
      FirebaseDatabase.instance.reference().child("BookFood");
  DatabaseReference databaseReferenceUserCard =
      FirebaseDatabase.instance.reference().child("UserCard");
  DatabaseReference databaseReferenceCheckAvailable =
      FirebaseDatabase.instance.reference().child("CheckAvailable");

  FirebaseAuth auth = FirebaseAuth.instance;
  List ingredientList = [];
  String dataCollect = "";

  var temArray = [];
  String valuesData = "";
  late Map<dynamic, dynamic> values;
  int count = 1;
  String? cardID;
  bool forEachDone = false;
  @override
  void initState() {
    final User? user = auth.currentUser;
    String uid = user!.uid;
    databaseReferenceUserCard.child(uid).onValue.listen((event) {
      setState(() {
        cardID = event.snapshot.value['cardID'];
        print(cardID);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Color(0xFFF5F5F5),
          elevation: 0,
          brightness: Brightness.light,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 100.0),
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 220.0,
                    child: Stack(
                      children: [
                        FadeInImage(
                          width: double.infinity,
                          height: double.infinity,
                          placeholder: AssetImage('images/image_large.png'),
                          image: NetworkImage(widget.fImageURl),
                          fit: BoxFit.cover,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.grey,
                                        )),
                                  ),
                                )),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  margin: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Icon(
                                        Icons.favorite_border,
                                        color: Colors.grey,
                                      )),
                                )),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.all(10.0),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Text(
                              widget.fCookTime + " min",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          child: Text(
                            widget.fName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "PKR",
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.grey),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                Icon(Icons.delivery_dining),
                                Text(
                                  "  Rs. " + widget.fPrice,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.0),
                                )
                              ],
                            )),
                        Divider(
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Add Your Ingredients",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  )),
              Container(
                margin: EdgeInsets.all(8.0),
                child: StreamBuilder(
                  stream: databaseReference.onValue,
                  builder: (context, AsyncSnapshot<Event> snapshot) {
                    if (snapshot.hasData) {
                      ingredientList.clear();
                      DataSnapshot dataSnapshot = snapshot.data!.snapshot;
                      if (dataSnapshot.value != null) {
                        values = dataSnapshot.value;
                        values.forEach((key, value) {
                          ingredientList.add(value);
                        });
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: ingredientList.length,
                        itemBuilder: (context, index) {
                          if (widget.fKey == ingredientList[index]['fKey']) {
                            return Padding(
                              padding: EdgeInsets.all(0.0),
                              child: GestureDetector(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CheckboxListTile(
                                        title: Text(ingredientList[index]
                                                ['iName']
                                            .toString()),
                                        value: ingredientList[index]
                                            ['isSelected'],
                                        onChanged: (val) {
                                          setState(() {
                                            databaseReference
                                                .child(ingredientList[index]
                                                    ['iKey'])
                                                .child('isSelected')
                                                .set(val);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return SizedBox();
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
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 80.0,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: Center(
                  child: Container(
                    width: 120.0,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              count++;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "+",
                              style: TextStyle(fontSize: 29.0),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Center(
                                child: Text(count.toString(),
                                    style: TextStyle(fontSize: 20.0)))),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (count > 1) count--;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("-", style: TextStyle(fontSize: 50.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      values.forEach((key, value) {
                        if (value['isSelected'] == true) {
                          temArray.add(value['iName']);
                          databaseReference
                              .child(value['iKey'])
                              .child('isSelected')
                              .set(false);
                        }
                      });
                      setState(() {
                        valuesData = temArray.join(",");
                      });

                      if (count > int.parse(widget.fRemainingQuantity)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Stock is not available')));
                      } else {
                        if (Constant.type == "reserveTable") {
                          String updateQuantity =
                              (int.parse(widget.fRemainingQuantity) - count)
                                  .toString();
                          databaseReferenceFood
                              .child(widget.fKey)
                              .child("fRemainingQuantity")
                              .set(updateQuantity);
                          databaseReferenceTable
                              .child(Constant.tKey)
                              .child("isAvailable")
                              .set("1");
                          String autoID =
                              databaseReferenceCheckAvailable.push().key;
                          databaseReferenceCheckAvailable.child(autoID).set({
                            'tImageURl': Constant.tImage,
                            'tSeat': Constant.tSeat,
                            'tKey': Constant.tKey,
                            'tDate': Constant.selectDate,
                            'tTime': Constant.selectTime,
                            'restaurantID': Constant.rrID,
                            'uID': Constant.userID,
                            'autoID': autoID,
                          }).then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Table resrved successfully')));
                          });
                          // Order Table
                          databaseReferenceOrderTable
                              .child(Constant.userID)
                              .child(Constant.tKey)
                              .set({
                            'tImageURl': Constant.tImage,
                            'tno': Constant.tno,
                            'rUID': Constant.rUID,
                            'rImageURl': Constant.rImageURl,
                            'restaurantName': Constant.rName,
                            'rKey': Constant.restaurantID,
                            'rAddress': Constant.rAddress,
                            'rDes': Constant.rDes,
                            'tSeat': Constant.tSeat,
                            'tDate': Constant.selectDate,
                            'tTime': Constant.selectTime,
                            'uID': Constant.userID,
                            'tKey': Constant.tKey,
                            'checkID': autoID,
                            'placeOrder': "null",
                          }).then((value) {
                            databaseReferenceTableOrder
                                .child(Constant.userID)
                                .child(Constant.tKey)
                                .set(false);
                            String autoID2 =
                                databaseReferenceOrderFood.push().key;
                            databaseReferenceOrderFood
                                .child(Constant.userID)
                                .child(Constant.tKey)
                                .child(autoID2)
                                .set({
                              'fImageURl': widget.fImageURl,
                              'fName': widget.fName,
                              'fPrice': widget.fPrice,
                              'fCookedTime': widget.fCookTime,
                              'fIngredient': temArray.join(","),
                              'fQuantity': count.toString().trim(),
                              'tPrice': (count * int.parse(widget.fPrice))
                                  .toString()
                                  .trim(),
                              'oFoodKey': autoID2.toString().trim(),
                              'uID': Constant.userID,
                              'tKey': Constant.tKey,
                            }).then((value) {
                              temArray.clear();

                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Booked')));
                            });
                          });
                        } else if (Constant.type == "addFood") {
                          String autoID2 =
                              databaseReferenceOrderFood.push().key;
                          databaseReferenceOrderFood
                              .child(Constant.userID)
                              .child(Constant.tKey)
                              .child(autoID2)
                              .set({
                            'fImageURl': widget.fImageURl,
                            'fName': widget.fName,
                            'fPrice': widget.fPrice,
                            'fCookedTime': widget.fCookTime,
                            'fIngredient': temArray.join(","),
                            'fQuantity': count.toString().trim(),
                            'tPrice': (count * int.parse(widget.fPrice))
                                .toString()
                                .trim(),
                            'oFoodKey': autoID2.toString().trim(),
                            'uID': Constant.userID,
                            'tKey': Constant.tKey,
                          }).then((value) {
                            temArray.clear();
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Food Booked')));
                          });
                        } else if (Constant.type == "foodOrder") {
                          String autoID2 =
                              databaseReferenceOrderFood.push().key;
                          databaseReferenceBookFood
                              .child(Constant.userID)
                              .child(cardID.toString())
                              .child(autoID2)
                              .set({
                            'fImageURl': widget.fImageURl,
                            'fName': widget.fName,
                            'fPrice': widget.fPrice,
                            'fCookedTime': widget.fCookTime,
                            'fIngredient': temArray.join(","),
                            'fQuantity': count.toString().trim(),
                            'tPrice': (count * int.parse(widget.fPrice))
                                .toString()
                                .trim(),
                            'oFoodKey': autoID2.toString().trim(),
                            'uID': Constant.userID,
                            'rKey': Constant.rKey
                          }).then((value) {
                            databaseReferenceUserCard
                                .child(Constant.userID)
                                .child('rID')
                                .set(widget.rID);
                            temArray.clear();
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Food is Booked')));
                          });
                        }
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Constant.type == "reserveTable"
                          ? Text(
                              "Book Now",
                              style: TextStyle(fontSize: 18),
                            )
                          : Text(
                              "Order Now",
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
                )),
          ],
        ),
      ),
    );
  }
}
