import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/U_Drawer_Cart/user_order_TAB_foodorder_reserveTable&foodscreen.dart';
import 'package:flutter_restaurant_app/U_Drawer_About/about_screen.dart';
import 'package:flutter_restaurant_app/U_Home_Restaurants/restaurantDetail_Reserve%20your%20table_screen.dart';
import 'package:flutter_restaurant_app/U_Home_SearchBar/search_screen.dart';
import 'package:flutter_restaurant_app/join_us.dart';
import 'package:flutter_restaurant_app/U_Drawer_History/order_history_screen.dart';
import 'package:flutter_restaurant_app/U_Home_foods/see_all_food_screen.dart';
import 'package:flutter_restaurant_app/U_Home_Restaurants/show_restaurant_list_screen.dart';
import 'package:flutter_restaurant_app/U_Drawer_Profile/user_profile_screen.dart';
import '../U_Home_Carousel Slider/carousel_slider.dart';
import '../constant.dart';
import '../U_Home_foods/food_detail_&_Add your ingredients_screen.dart';

class User_Home extends StatefulWidget {
  User_Home({Key? key}) : super(key: key);

  @override
  _User_HomeState createState() => _User_HomeState();
}

class _User_HomeState extends State<User_Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("Restaurant");
  DatabaseReference databaseReferenceFood =
      FirebaseDatabase.instance.reference().child("Foods");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Color(0xFFFFFFFF),
          elevation: 0,
        ),
      ),
      //Drawer
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 180.0,
                color: Color(0xFFF5F5F5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Image(
                      image: AssetImage('images/logo.jpeg'),
                      height: 120.0,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Hi! " + Constant.name,
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Icon(
                        Icons.home_outlined,
                        size: 20.0,
                        color: Color(0xFFD1413A),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      "Home",
                      style: TextStyle(fontSize: 14),
                    ))
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return User_Order();
                  }));
                },
                child: Row(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        size: 20.0,
                        color: Color(0xFFD1413A),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      "Cart",
                      style: TextStyle(fontSize: 14),
                    ))
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return User_Profile_Screen();
                  }));
                },
                child: Row(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Icon(
                        Icons.person_outline,
                        size: 20.0,
                        color: Color(0xFFD1413A),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      "Profile",
                      style: TextStyle(fontSize: 14),
                    ))
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return Order_History_Screen();
                  }));
                },
                child: Row(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Icon(
                        Icons.history,
                        size: 20.0,
                        color: Color(0xFFD1413A),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      "History",
                      style: TextStyle(fontSize: 14),
                    ))
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return About_Screen();
                  }));
                },
                child: Row(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Icon(
                        Icons.info_outline,
                        size: 20.0,
                        color: Color(0xFFD1413A),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      "About",
                      style: TextStyle(fontSize: 14),
                    ))
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await FirebaseAuth.instance.signOut().whenComplete(() {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return Join_Us();
                    }));
                  });
                },
                child: Row(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Icon(
                        Icons.logout,
                        size: 20.0,
                        color: Color(0xFFD1413A),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      "Logout",
                      style: TextStyle(fontSize: 14),
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      //
      body: Column(
        children: [
          //Appbar Menu Icon and text
          Container(
            color: Colors.white,
            height: 60.0,
            child: Row(
              children: [
                SizedBox(
                  width: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    if (_scaffoldKey.currentState!.isDrawerOpen) {
                      _scaffoldKey.currentState!.openEndDrawer();
                    } else {
                      _scaffoldKey.currentState!.openDrawer();
                    }
                  },
                  child: Icon(
                    Icons.menu_outlined,
                    size: 20.0,
                    color: Color(0xFFD1413A),
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                GestureDetector(
                    onTap: () {
                      if (_scaffoldKey.currentState!.isDrawerOpen) {
                        _scaffoldKey.currentState!.openEndDrawer();
                      } else {
                        _scaffoldKey.currentState!.openDrawer();
                      }
                    },
                    child: Text(
                      "FOOD FOOIES POINT ",
                      style:
                          TextStyle(color: Color(0xFFD1413A), fontSize: 16.0),
                    )),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // InkWell(
                    //child: Icon(
                    // Icons.shopping_cart_outlined,
                    // size: 20.0,
                    // color: Color(0xFFD1413A),
                    //),
                    //onTap: () {
                    // Navigator.pop(context);
                    // Navigator.of(context)
                    //    .push(MaterialPageRoute(builder: (context) {
                    //  return User_Order();
                    //}));
                    //},
                    //),
                    //SizedBox(
                    //  width: 20.0,
                    //),
                  ],
                ))
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Color(0xFFF5F5F5),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              //Hi+constant.name ,Thinking of foods and restaurants ,Image

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hi! " + Constant.name,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  Text(
                                    "Thinking of Food And Restaurants? ",
                                    style: TextStyle(
                                        fontSize: 13.0, color: Colors.black),
                                  ),
                                ],
                              )),
                          Image(
                            image: AssetImage('images/food.png'),
                            width: 100.0,
                            height: 100.0,
                          ),
                        ],
                      ),
                    ),

                    //SearchBar Search for restaurants

                    GestureDetector(
                      onTap: () {
                        Constant.type = "reserveTable";
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return Search_Screen();
                        }));
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search_sharp,
                                  color: Color(0xFFD1413A),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  "Search for restaurants",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                            padding: EdgeInsets.all(12.0),
                          ),
                        ),
                      ),
                    ),
                    //Image Carousel Slider
                    Container(
                      child: AspectRatio(
                        aspectRatio: 1.5,
                        child: Carousel_Slider(),
                      ),
                    ),
                    //
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: AspectRatio(
                        aspectRatio: 3 / 1,
                        // foodis point, image in card
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Container(
                            color: Color(0xFFD29B88),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Text(
                                              "FOODIES POINT",
                                              style: TextStyle(
                                                  // fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Image(
                                  image: AssetImage('images/f2.png'),
                                  width: 200.0,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    //
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1.4 / 1,
                              //Food Order
                              child: GestureDetector(
                                onTap: () {
                                  Constant.type = "foodOrder";
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return ShowRestaurantListScreen();
                                  }));
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Container(
                                    color: Color(0xFFE79E33),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Padding(
                                          child: Text(
                                            "Foods Order",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          padding: EdgeInsets.all(12.0),
                                        ),
                                        Expanded(
                                          child: Image(
                                            image: AssetImage('images/f3.png'),
                                            fit: BoxFit.fitHeight,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          //RESERVE TABLE AND FOOD

                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1.4 / 1,
                              child: GestureDetector(
                                onTap: () {
                                  Constant.type = "reserveTable";
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return ShowRestaurantListScreen();
                                  }));
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Container(
                                    color: Color(0xFFD1413A),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Padding(
                                          child: Text(
                                            "Reserve Table & Food",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          padding: EdgeInsets.all(12.0),
                                        ),
                                        Expanded(
                                          child: Image(
                                            image: AssetImage('images/f4.png'),
                                            fit: BoxFit.fitHeight,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //RESTAURANTS  see all
                    Container(
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Restaurants",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Constant.type = "reserveTable";
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return ShowRestaurantListScreen();
                                      }));
                                    },
                                    child: Padding(
                                      child: Text(
                                        "See all",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      padding: EdgeInsets.all(8.0),
                                    ),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 20.0)),
                          Container(
                              height: 240.0,
                              margin: EdgeInsets.all(8.0),
                              child: StreamBuilder(
                                  stream: databaseReference.onValue,
                                  builder:
                                      (context, AsyncSnapshot<Event> snapshot) {
                                    List restaurantList = [];
                                    if (snapshot.hasData) {
                                      DataSnapshot dataSnapshot =
                                          snapshot.data!.snapshot;
                                      if (dataSnapshot.value != null) {
                                        Map<dynamic, dynamic> values =
                                            dataSnapshot.value;
                                        values.forEach((key, value) {
                                          restaurantList.add(value);
                                        });
                                      }
                                      return ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          itemCount: restaurantList.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Constant.type =
                                                          "reserveTable";
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return RestaurantDetailScreen(
                                                            rImageURl: restaurantList[index]
                                                                ['rImageURl'],
                                                            rName:
                                                                restaurantList[index]
                                                                    ['rName'],
                                                            rDes:
                                                                restaurantList[index]
                                                                    ['rDes'],
                                                            rAddress: restaurantList[index]
                                                                ['rAddress'],
                                                            rPhoneNo:
                                                                restaurantList[
                                                                        index][
                                                                    'rPhoneNo'],
                                                            rOpenCloseTime:
                                                                restaurantList[
                                                                        index][
                                                                    'rOpenCloseTime'],
                                                            restaurantID:
                                                                restaurantList[index]
                                                                    ['rKey']);
                                                      }));
                                                    },
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
                                                        child: Container(
                                                          width: 230.0,
                                                          child: FadeInImage(
                                                            placeholder: AssetImage(
                                                                'images/image_large.png'),
                                                            image: NetworkImage(
                                                                restaurantList[
                                                                        index][
                                                                    'rImageURl']),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        )),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      width: 230.0,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            height: 5.0,
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        8.0),
                                                            child: Text(
                                                              restaurantList[
                                                                      index]
                                                                  ['rAddress'],
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 2.0,
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              restaurantList[
                                                                      index]
                                                                  ['rName'],
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      17.0),
                                                            ),
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        8.0),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              ],
                                            );
                                          });
                                    } else {
                                      return Container(
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.red),
                                          ),
                                        ),
                                      );
                                    }
                                  })),
                        ],
                      ),
                    ),
                    //foods see all
                    Container(
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Constant.type = "foodOrder";
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return SeeAllFoodScreen();
                              }));
                            },
                            child: Padding(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Foods",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "See all",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 20.0)),
                          ),
                          Container(
                              height: 230.0,
                              margin: EdgeInsets.all(8.0),
                              child: StreamBuilder(
                                  stream: databaseReferenceFood.onValue,
                                  builder:
                                      (context, AsyncSnapshot<Event> snapshot) {
                                    List foodList = [];
                                    String? data;
                                    if (snapshot.hasData) {
                                      DataSnapshot dataSnapshot =
                                          snapshot.data!.snapshot;
                                      if (dataSnapshot.value != null) {
                                        Map<dynamic, dynamic> values =
                                            dataSnapshot.value;
                                        values.forEach((key, value) {
                                          foodList.add(value);
                                        });
                                      }
                                      return ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          itemCount: foodList.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            /// Is pr kam karna ha
                                            DatabaseReference
                                                databaseReferenceCategory =
                                                FirebaseDatabase.instance
                                                    .reference()
                                                    .child("Category");
                                            databaseReferenceCategory
                                                .child(foodList[index]['cKey'])
                                                .once()
                                                .then((snapshot) {
                                              data = snapshot.value['cName'];
                                              print(data);
                                            });
                                            ///////////////////////
                                            return GestureDetector(
                                              onTap: () {
                                                Constant.type = "foodOrder";
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return FoodDetailScreen(
                                                      fName: foodList[index]
                                                          ['fName'],
                                                      fPrice: foodList[index]
                                                          ['fPrice'],
                                                      fCookTime: foodList[index]
                                                          ['fCookTime'],
                                                      fImageURl: foodList[index]
                                                          ['fImageURl'],
                                                      fKey: foodList[index]
                                                          ['fKey'],
                                                      fRemainingQuantity: foodList[
                                                              index][
                                                          'fRemainingQuantity'],
                                                      rID: foodList[index]
                                                          ['uID']);
                                                }));
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 160,
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
                                                        child: Container(
                                                            child: Stack(
                                                          children: [
                                                            FadeInImage(
                                                              width: 230.0,
                                                              height: double
                                                                  .infinity,
                                                              placeholder:
                                                                  AssetImage(
                                                                      'images/image_large.png'),
                                                              image: NetworkImage(
                                                                  foodList[
                                                                          index]
                                                                      [
                                                                      'fImageURl']),
                                                              fit: BoxFit.cover,
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: Container(
                                                                width: 230.0,
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child:
                                                                        Container(
                                                                      margin: EdgeInsets
                                                                          .all(
                                                                              10.0),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      child: Padding(
                                                                          padding: EdgeInsets.all(5.0),
                                                                          child: Icon(
                                                                            Icons.favorite_border,
                                                                            color:
                                                                                Colors.grey,
                                                                          )),
                                                                    )),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment: Alignment
                                                                  .bottomRight,
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              14),
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                margin: EdgeInsets
                                                                    .all(10.0),
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10.0),
                                                                height: 24,
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      foodList[index]
                                                                              [
                                                                              'fCookTime'] +
                                                                          " min",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              12.0),
                                                                    )),
                                                              ),
                                                            ),
                                                          ],
                                                        ))),
                                                  ),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        width: 230.0,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height: 5.0,
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                foodList[index]
                                                                    ['fName'],
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        17.0),
                                                              ),
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                            ),
                                                            SizedBox(
                                                              height: 2.0,
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                              child: Text(
                                                                "PKR",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12.0,
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                            ),
                                                            Container(
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            8.0),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(Icons
                                                                        .delivery_dining),
                                                                    Text(
                                                                      "  Rs. " +
                                                                          foodList[index]
                                                                              [
                                                                              'fPrice'],
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              10.0),
                                                                    )
                                                                  ],
                                                                )),
                                                          ],
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            );
                                          });
                                    } else {
                                      return Container(
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.red),
                                          ),
                                        ),
                                      );
                                    }
                                  })),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
