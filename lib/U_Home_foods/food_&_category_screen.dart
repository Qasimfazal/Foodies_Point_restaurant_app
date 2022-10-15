import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/constant.dart';

import 'food_detail_&_Add your ingredients_screen.dart';

class FoodCategoryScreen extends StatefulWidget {
  final String restaurantID;
  const FoodCategoryScreen({Key? key, required this.restaurantID})
      : super(key: key);

  @override
  _FoodCategoryScreenState createState() => _FoodCategoryScreenState();
}

class _FoodCategoryScreenState extends State<FoodCategoryScreen> {
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("Category");
  DatabaseReference databaseReferenceFood =
      FirebaseDatabase.instance.reference().child("Foods");
  List categoryList = [];
  List cKeyList = [];
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
            Stack(
              children: [
                Image(
                  image: AssetImage('images/foods.jpg'),
                  width: double.infinity,
                  height: 200.0,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: double.infinity,
                  height: 200.0,
                  color: Colors.black.withOpacity(0.5),
                ),
                Container(
                  width: double.infinity,
                  height: 200.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Food Menu",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Foodie Point",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.all(9.0),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                child: StreamBuilder(
                  stream: databaseReference.onValue,
                  builder: (context, AsyncSnapshot<Event> snapshot) {
                    if (snapshot.hasData) {
                      categoryList.clear();
                      DataSnapshot dataSnapshot = snapshot.data!.snapshot;
                      if (dataSnapshot.value != null) {
                        Map<dynamic, dynamic> values = dataSnapshot.value;
                        values.forEach((key, value) {
                          if (widget.restaurantID == value['rKey']) {
                            categoryList.add(value['cName']);
                            cKeyList.add(value['cKey']);
                          }
                        });
                      }
                      return DefaultTabController(
                          length: categoryList.length,
                          child: Scaffold(
                            appBar: PreferredSize(
                              preferredSize: Size.fromHeight(48),
                              child: AppBar(
                                elevation: 0,
                                backgroundColor: Colors.white,
                                bottom: PreferredSize(
                                  preferredSize: Size.fromHeight(0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: TabBar(
                                      labelColor: Colors.red,
                                      unselectedLabelColor: Colors.black,
                                      indicatorColor: Colors.red,
                                      isScrollable: true,
                                      indicatorSize: TabBarIndicatorSize.label,
                                      tabs: List<Widget>.generate(
                                          categoryList.length, (index) {
                                        return Tab(
                                          text: categoryList[index],
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            body: TabBarView(
                              children: List<Widget>.generate(
                                  categoryList.length, (int index) {
                                return StreamBuilder(
                                    stream: databaseReferenceFood.onValue,
                                    builder: (context,
                                        AsyncSnapshot<Event> snapshot) {
                                      if (snapshot.hasData) {
                                        foodList.clear();
                                        DataSnapshot dataSnapshot =
                                            snapshot.data!.snapshot;
                                        Map<dynamic, dynamic> values =
                                            dataSnapshot.value;
                                        values.forEach((key, value) {
                                          if (cKeyList[index] ==
                                              value['cKey']) {
                                            foodList.add(value);
                                          }
                                        });
                                        return ListView.builder(
                                            physics: BouncingScrollPhysics(),
                                            itemCount: foodList.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return FoodDetailScreen(
                                                            fName:
                                                                foodList[index]
                                                                    ['fName'],
                                                            fPrice:
                                                                foodList[index]
                                                                    ['fPrice'],
                                                            fCookTime: foodList[
                                                                    index]
                                                                ['fCookTime'],
                                                            fImageURl: foodList[
                                                                    index]
                                                                ['fImageURl'],
                                                            fKey:
                                                                foodList[index]
                                                                    ['fKey'],
                                                            fRemainingQuantity:
                                                                foodList[index][
                                                                    'fRemainingQuantity'],
                                                            rID: foodList[index]
                                                                ['uID']);
                                                      }));
                                                    },
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 15.0,
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  foodList[
                                                                          index]
                                                                      ['fName'],
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                SizedBox(
                                                                  height: 2.0,
                                                                ),
                                                                Text(
                                                                    foodList[index]
                                                                            [
                                                                            'fCookTime'] +
                                                                        " min",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14.0),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis),
                                                                SizedBox(
                                                                  height: 8.0,
                                                                ),
                                                                Text(
                                                                    "Rs. " +
                                                                        foodList[index]
                                                                            [
                                                                            'fPrice'],
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 10),
                                                          child: Card(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            clipBehavior: Clip
                                                                .antiAliasWithSaveLayer,
                                                            child: FadeInImage(
                                                              placeholder:
                                                                  AssetImage(
                                                                      'images/image_large.png'),
                                                              image: NetworkImage(
                                                                  foodList[
                                                                          index]
                                                                      [
                                                                      'fImageURl']),
                                                              fit: BoxFit.cover,
                                                              width: 90.0,
                                                              height: 90.0,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 15.0,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    child: Divider(
                                                      height: 0.5,
                                                      color: Colors.grey,
                                                    ),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15),
                                                  )
                                                ],
                                              );
                                            });
                                      } else {
                                        return Container();
                                      }
                                    });
                              }),
                            ),
                          ));
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
