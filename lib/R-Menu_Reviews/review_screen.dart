import 'package:dart_sentiment/dart_sentiment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/U_Drawer_Cart/orders_table_screen.dart_Review%20Ratingdailog.dart';

//import 'order_table_screen.dart';

class Review_Screen extends StatefulWidget {
  const Review_Screen({Key? key}) : super(key: key);

  @override
  _Review_ScreenState createState() => _Review_ScreenState();
}

class _Review_ScreenState extends State<Review_Screen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("Review");

  final sentiment = Sentiment();
  var Negitive = 0, positive = 0;
  List sentimentList = [];

  List restaurantList = [];
  var uid;
  getData() async {
    final User? user = auth.currentUser;
    setState(() {
      uid = user!.uid;
    });
    restaurantList.clear();
    sentimentList.clear();
    DataSnapshot dataSnapshot = await databaseReference.once();
    print(dataSnapshot.value);
    (dataSnapshot.value as Map<dynamic, dynamic>).forEach((key, value) {
      setState(() {
        if (uid == value['rUID']) {
          restaurantList.add(value);
          sentimentList.add(sentiment.analysis(value['userMessage']));
        }
      });
    });
    print(restaurantList.length);

    fillSentiments();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  fillSentiments() {
    for (var a in sentimentList) {
      // if (a['score'] == 1) {
      // setState(() {
      // //  terrible += 1;
      // });
      // }

      // }
      if (a['score'] <= 2) {
        setState(() {
          //average
          Negitive += 1;
        });
      }
      if (a['score'] >= 3 && a['score'] <= 5) {
        setState(() {
          //excellent
          positive += 1;
        });
      }
      print(a);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("Reviews"),
      ),
      body: Container(
        child: Container(
            child:
                // FutureBuilder(
                //   future: databaseReference.once(),
                //   builder: (context, AsyncSnapshot<DataSnapshot> snapshot){
                //     if(snapshot.hasData) {
                //       final User? user = auth.currentUser;
                //       String uid = user!.uid;
                //       restaurantList.clear();
                //       DataSnapshot dataSnapshot = snapshot.data!;
                //       if(dataSnapshot.value != null) {
                //         Map<dynamic, dynamic> values = dataSnapshot.value;
                //         values.forEach((key, value) {
                //        //   print(value);
                //           restaurantList.add(value);
                //           sentimentList.add(sentiment.analysis(value['userMessage']));
                //         });
                //       }
                //
                //       return
                Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Text('Terrible ' +
                // (terrible / restaurantList.length * 100).toString() +
                // '%'),
                Text('Negitive ' +
                    (Negitive / restaurantList.length * 100).toString() +
                    '%'),
                Text('positive' +
                    (positive / restaurantList.length * 100).toString() +
                    '%'),
              ],
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.85,
                child: ListView.builder(
                  itemCount: restaurantList.length,
                  itemBuilder: (context, index) {
                    if (uid == restaurantList[index]['rUID']) {
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
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 10),
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Theme.of(context).cardColor
                                    : Colors.white,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 50.0,
                                      height: 50.0,
                                      decoration: new BoxDecoration(
                                          shape: BoxShape.circle),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        child: Image.network(
                                            "https://i.pinimg.com/originals/7c/c7/a6/7cc7a630624d20f7797cb4c8e93c09c1.png"),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(restaurantList[index]
                                                    ['userName']),
                                                Container(
                                                  child: StarRating(
                                                    starCount: 5,
                                                    rating: double.parse(
                                                        restaurantList[index]
                                                                ['rating']
                                                            .toString()),
                                                    onRatingChanged:
                                                        (rating) {},
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(restaurantList[index]
                                              ['userMessage']),
                                          Divider(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ))
          ],
        )
            //   }else{
            //     return Container(
            //       child: Center(
            //         child:  CircularProgressIndicator(
            //           valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            //         ),
            //       ),
            //     );
            //   }
            // },
            //  ),
            ),
      ),
    );
  }
}
