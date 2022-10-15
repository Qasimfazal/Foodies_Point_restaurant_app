import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'food_detail_&_Add your ingredients_screen.dart';

class SeeAllFoodScreen extends StatefulWidget {
  const SeeAllFoodScreen({Key? key}) : super(key: key);

  @override
  _SeeAllFoodScreenState createState() => _SeeAllFoodScreenState();
}

class _SeeAllFoodScreenState extends State<SeeAllFoodScreen> {
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("Foods");
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
                    "Foods ",
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
                child: StreamBuilder(
                  stream: databaseReference.onValue,
                  builder: (context, AsyncSnapshot<Event> snapshot) {
                    if (snapshot.hasData) {
                      foodList.clear();
                      DataSnapshot dataSnapshot = snapshot.data!.snapshot;
                      if (dataSnapshot.value != null) {
                        Map<dynamic, dynamic> values = dataSnapshot.value;
                        values.forEach((key, value) {
                          foodList.add(value);
                        });
                      }
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: foodList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(4.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return FoodDetailScreen(
                                      fName: foodList[index]['fName'],
                                      fPrice: foodList[index]['fPrice'],
                                      fCookTime: foodList[index]['fCookTime'],
                                      fImageURl: foodList[index]['fImageURl'],
                                      fKey: foodList[index]['fKey'],
                                      fRemainingQuantity: foodList[index]
                                          ['fRemainingQuantity'],
                                      rID: foodList[index]['uID']);
                                }));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 180.0,
                                      child: Stack(
                                        children: [
                                          FadeInImage(
                                            width: double.infinity,
                                            height: double.infinity,
                                            placeholder: AssetImage(
                                                'images/image_large.png'),
                                            image: NetworkImage(
                                                foodList[index]['fImageURl']),
                                            fit: BoxFit.cover,
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                              child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.all(10.0),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Colors.white,
                                                    ),
                                                    child: Padding(
                                                        padding:
                                                            EdgeInsets.all(5.0),
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
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                color: Colors.white,
                                              ),
                                              margin: EdgeInsets.all(10.0),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 5.0),
                                              child: Text(
                                                foodList[index]['fCookTime'] +
                                                    " min",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12.0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
                                              foodList[index]['fName'],
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17.0),
                                            ),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                          ),
                                          SizedBox(
                                            height: 2.0,
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              "PKR",
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                          Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.delivery_dining),
                                                  Text(
                                                    "  Rs. " +
                                                        foodList[index]
                                                            ['fPrice'],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 10.0),
                                                  )
                                                ],
                                              )),
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
            ),
          ],
        ),
      ),
    );
  }
}
