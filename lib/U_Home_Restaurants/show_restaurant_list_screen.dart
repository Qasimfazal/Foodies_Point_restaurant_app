import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/U_Drawer_Cart/orders_table_screen.dart_Review%20Ratingdailog.dart';
import 'package:flutter_restaurant_app/U_Home_Restaurants/restaurantDetail_Reserve%20your%20table_screen.dart';

import '../constant.dart';
import '../U_Home_foods/food_&_category_screen.dart';

class ShowRestaurantListScreen extends StatefulWidget {
  const ShowRestaurantListScreen({Key? key}) : super(key: key);

  @override
  _ShowRestaurantListScreenState createState() =>
      _ShowRestaurantListScreenState();
}

class _ShowRestaurantListScreenState extends State<ShowRestaurantListScreen> {
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("Restaurant");
  List restaurantList = [];
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
                    "Restaurants",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(8.0),
                child: StreamBuilder(
                  stream: databaseReference.onValue,
                  builder: (context, AsyncSnapshot<Event> snapshot) {
                    if (snapshot.hasData) {
                      restaurantList.clear();
                      DataSnapshot dataSnapshot = snapshot.data!.snapshot;
                      if (dataSnapshot.value != null) {
                        Map<dynamic, dynamic> values = dataSnapshot.value;
                        values.forEach((key, value) {
                          restaurantList.add(value);
                        });
                      }
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: restaurantList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(4.0),
                            child: GestureDetector(
                              onTap: () {
                                if (Constant.type == "reserveTable") {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return RestaurantDetailScreen(
                                        rImageURl: restaurantList[index]
                                            ['rImageURl'],
                                        rName: restaurantList[index]['rName'],
                                        rDes: restaurantList[index]['rDes'],
                                        rAddress: restaurantList[index]
                                            ['rAddress'],
                                        rPhoneNo: restaurantList[index]
                                            ['rPhoneNo'],
                                        rOpenCloseTime: restaurantList[index]
                                            ['rOpenCloseTime'],
                                        restaurantID: restaurantList[index]
                                            ['rKey']);
                                  }));
                                } else {
                                  Constant.rKey = restaurantList[index]['rKey'];
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return FoodCategoryScreen(
                                        restaurantID: restaurantList[index]
                                            ['rKey']);
                                  }));
                                }
                              },
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
                                          restaurantList[index]['rImageURl']),
                                      height: 180.0,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            restaurantList[index]['rName'],
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 4.0,
                                          ),
                                          Text(
                                            restaurantList[index]['rDes'],
                                            style: TextStyle(fontSize: 14.0),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 4.0,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Dialog mdialog = Dialog(
                                                child: RatingDialogBody(
                                                    dialogContext: context,
                                                    rUID: restaurantList[index]
                                                        ['uID']),
                                              );
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return mdialog;
                                                  });
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 0, right: 0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: Text("Reviews")),
                                                  Icon(Icons.navigate_next,
                                                      color: Colors.grey),
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
                            ),
                          );
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
            )
          ],
        ),
      ),
    );
  }
}
