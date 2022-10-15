import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/constant.dart';

import 'orders_ reserve table&food_ADD YOUR FOOD_screen.dart';
//import 'package:flutter_restaurant_app/U_Drawer_Cart/user_add_more_food_screen.dart';

class OrderTable extends StatefulWidget {
  const OrderTable({Key? key}) : super(key: key);

  @override
  _OrderTableState createState() => _OrderTableState();
}

class _OrderTableState extends State<OrderTable> {
  FirebaseAuth auth = FirebaseAuth.instance;
  List orderTableList = [];
  DatabaseReference databaseReferenceOrderTable =
      FirebaseDatabase.instance.reference().child("OrderTable");
  DatabaseReference databaseReferenceOrderFood =
      FirebaseDatabase.instance.reference().child("OrderFood");
  DatabaseReference databaseReferenceTables =
      FirebaseDatabase.instance.reference().child("Tables");
  DatabaseReference databaseReferenceCheckAvailable =
      FirebaseDatabase.instance.reference().child("CheckAvailable");

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    String uid = user!.uid;
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.reference().child("OrderTable").child(uid);
    return Scaffold(
      body: Container(
        color: Color(0xFFF5F5F5),
        child: Container(
          child: StreamBuilder(
            stream: databaseReference.onValue,
            builder: (context, AsyncSnapshot<Event> snapshot) {
              if (snapshot.hasData) {
                orderTableList.clear();
                DataSnapshot dataSnapshot = snapshot.data!.snapshot;
                if (dataSnapshot.value != null) {
                  Map<dynamic, dynamic> values = dataSnapshot.value;
                  values.forEach((key, value) {
                    orderTableList.add(value);
                  });
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: orderTableList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FadeInImage(
                                placeholder:
                                    AssetImage('images/image_large.png'),
                                image: NetworkImage(
                                    orderTableList[index]['rImageURl']),
                                height: 180.0,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                margin: EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      orderTableList[index]['restaurantName'],
                                      style: TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 4.0,
                                    ),
                                    Text(
                                      orderTableList[index]['rDes'],
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                    SizedBox(
                                      height: 4.0,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Constant.tSeat =
                                            orderTableList[index]['tSeat'];
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return AddMoreFoodScreen(
                                              uID: orderTableList[index]['uID'],
                                              tKey: orderTableList[index]
                                                  ['tKey'],
                                              restaurantID:
                                                  orderTableList[index]['rKey'],
                                              rUID: orderTableList[index]
                                                  ['rUID'],
                                              placeOrder: orderTableList[index]
                                                  ['placeOrder']);
                                        }));
                                      },
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
                                                  orderTableList[index]
                                                      ['tImageURl']),
                                              height: 50.0,
                                              width: 50.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.0,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                orderTableList[index]['tSeat'],
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "Table no. " +
                                                    orderTableList[index]
                                                        ['tno'],
                                                style:
                                                    TextStyle(fontSize: 12.0),
                                              ),
                                              Text(
                                                'Available',
                                                style:
                                                    TextStyle(fontSize: 12.0),
                                              ),
                                            ],
                                          )),
                                          Icon(
                                            Icons.navigate_next,
                                            color: Colors.grey,
                                            size: 35,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4.0,
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Dialog dialog = Dialog(
                                          child: RatingDialogBody(
                                              dialogContext: context,
                                              rUID: orderTableList[index]
                                                  ['rUID']),
                                        );
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return dialog;
                                            });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 8.0, right: 8.0),
                                        child: Row(
                                          children: [
                                            Expanded(child: Text("Reviews")),
                                            Icon(Icons.navigate_next,
                                                color: Colors.grey),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      height: 4.0,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(top: 4.0),
                                            child: Icon(
                                              Icons.location_on_rounded,
                                              size: 14,
                                            )),
                                        SizedBox(
                                          width: 6.0,
                                        ),
                                        Flexible(
                                            child: Text(
                                          orderTableList[index]['rAddress'],
                                          style: TextStyle(fontSize: 14.0),
                                        )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 6.0,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.date_range,
                                          size: 14,
                                        ),
                                        SizedBox(
                                          width: 6.0,
                                        ),
                                        Text(
                                          orderTableList[index]['tDate'],
                                          style: TextStyle(fontSize: 14.0),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 6.0,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          size: 14,
                                        ),
                                        SizedBox(
                                          width: 6.0,
                                        ),
                                        Text(
                                          orderTableList[index]['tTime'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 6.0,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        databaseReferenceOrderTable
                                            .child(uid)
                                            .child(
                                                orderTableList[index]['tKey'])
                                            .remove();
                                        databaseReferenceOrderFood
                                            .child(uid)
                                            .child(
                                                orderTableList[index]['tKey'])
                                            .remove();
                                        databaseReferenceTables
                                            .child(
                                                orderTableList[index]['tKey'])
                                            .child('isAvailable')
                                            .set("0");
                                        databaseReferenceCheckAvailable
                                            .child(orderTableList[index]
                                                ['checkID'])
                                            .remove();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text('Order Cancel')));
                                      },
                                      child: Container(
                                        height: 50.0,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Container(
                    child: Center(
                        child: Container(
                      height: 200,
                      child: Center(child: Text("No Table Reserve")),
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
}

class RatingDialogBody extends StatefulWidget {
  final BuildContext dialogContext;
  final String rUID;

  const RatingDialogBody(
      {Key? key, required this.dialogContext, required this.rUID})
      : super(key: key);

  @override
  _RatingDialogBodyState createState() => _RatingDialogBodyState();
}

class _RatingDialogBodyState extends State<RatingDialogBody> {
  double rating = 0.0;
  DatabaseReference databaseReferenceReview =
      FirebaseDatabase.instance.reference().child("Review");

  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Your Rating"),
                StarRating(
                  starCount: 5,
                  rating: rating,
                  onRatingChanged: (rating) {
                    setState(() {
                      this.rating = rating;
                    });
                  },
                  color: Colors.red,
                ),
              ],
            ),
            SizedBox(
              height: 6.0,
            ),
            TextField(
              minLines: 5,
              maxLines: null,
              controller: _messageController,
              keyboardType: TextInputType.multiline,
              autofocus: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  // border: InputBorder.none,
                  hintText: "Your comment",
                  hintStyle: TextStyle(fontSize: 14)),
            ),
            SizedBox(
              height: 6.0,
            ),
            Container(
              height: 45.0,
              width: double.maxFinite,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    String autoID = databaseReferenceReview.push().key;
                    databaseReferenceReview.child(autoID).set({
                      'rating': rating,
                      'userName': Constant.name,
                      'rUID': widget.rUID,
                      'rKey': autoID.toString().trim(),
                      'userMessage': _messageController.text.toString()
                    }).then((value) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Review submitted successfully')));
                      Navigator.pop(widget.dialogContext);
                    });
                  },
                  child: Text("Add Review")),
            ),
          ],
        ),
      ),
    );
  }
}

typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;
  final Color color;

  StarRating(
      {this.starCount = 5,
      this.rating = .0,
      required this.onRatingChanged,
      required this.color});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = new Icon(
        Icons.star_border,
        color: Theme.of(context).buttonColor,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = new Icon(
        Icons.star_half,
        color: color,
      );
    } else {
      icon = new Icon(
        Icons.star,
        color: color,
      );
    }
    return new InkResponse(
      onTap:
          onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
        mainAxisSize: MainAxisSize.min,
        children:
            new List.generate(starCount, (index) => buildStar(context, index)));
  }
}
