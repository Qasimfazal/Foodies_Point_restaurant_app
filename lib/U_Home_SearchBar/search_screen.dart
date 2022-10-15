// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_restaurant_app/U_Home_Restaurants/restaurantDetail_Reserve%20your%20table_screen.dart';

// import '../constant.dart';
// import '../U_Home_foods/food_&_category_screen.dart';

// class Search_Screen extends StatefulWidget {
//   const Search_Screen({Key? key}) : super(key: key);

//   @override
//   _Search_ScreenState createState() => _Search_ScreenState();
// }

// class _Search_ScreenState extends State<Search_Screen> {
//   TextEditingController textEditingController = TextEditingController();
//   DatabaseReference databaseReference =
//       FirebaseDatabase.instance.reference().child("Restaurant");
//   DatabaseReference databaseReferenceFood =
//       FirebaseDatabase.instance.reference().child("Foods");
//   List foodList = [];
//   List rList = [];
//   String search = "";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(0),
//         child: AppBar(
//           backgroundColor: Color(0xFFFFFFFF),
//           elevation: 0,
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       child: Row(
//                         children: [
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Icon(Icons.search),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Expanded(
//                             child: TextField(
//                               textInputAction: TextInputAction.search,
//                               decoration: InputDecoration(
//                                   hintText: "search for restaurants?",
//                                   border: InputBorder.none),
//                               onSubmitted: (value) {
//                                 setState(() {
//                                   search = value.toString();
//                                 });
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: Text("Cancel")),
//                   SizedBox(
//                     width: 10,
//                   ),
//                 ],
//               ),
//             ),
//             search.isEmpty
//                 ? Container()
//                 : StreamBuilder(
//                     stream: databaseReference
//                         .orderByChild("rName")
//                         .startAt(search)
//                         .endAt(search + "\uf8ff")
//                         .onValue,
//                     builder: (context, AsyncSnapshot<Event> snapshot) {
//                       if (snapshot.hasData) {
//                         foodList.clear();
//                         DataSnapshot dataSnapshot = snapshot.data!.snapshot;
//                         if (dataSnapshot.value != null) {
//                           Map<dynamic, dynamic> values = dataSnapshot.value;
//                           values.forEach((key, value) {
//                             foodList.add(value);
//                           });
//                           return ListView.builder(
//                             shrinkWrap: true,
//                             itemCount: foodList.length,
//                             itemBuilder: (context, index) {
//                               if (true) {
//                                 return Padding(
//                                   padding: EdgeInsets.all(4.0),
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       if (Constant.type == "reserveTable") {
//                                         Navigator.of(context).push(
//                                             MaterialPageRoute(
//                                                 builder: (context) {
//                                           return RestaurantDetailScreen(
//                                               rImageURl: foodList[index]
//                                                   ['rImageURl'],
//                                               rName: foodList[index]['rName'],
//                                               rDes: foodList[index]['rDes'],
//                                               rAddress: foodList[index]
//                                                   ['rAddress'],
//                                               rPhoneNo: foodList[index]
//                                                   ['rPhoneNo'],
//                                               rOpenCloseTime: foodList[index]
//                                                   ['rOpenCloseTime'],
//                                               restaurantID: foodList[index]
//                                                   ['rKey']);
//                                         }));
//                                       } else {
//                                         Constant.rKey = foodList[index]['rKey'];
//                                         Navigator.of(context).push(
//                                             MaterialPageRoute(
//                                                 builder: (context) {
//                                           return FoodCategoryScreen(
//                                               restaurantID: foodList[index]
//                                                   ['rKey']);
//                                         }));
//                                       }
//                                     },
//                                     child: Card(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10.0),
//                                       ),
//                                       clipBehavior: Clip.antiAliasWithSaveLayer,
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           FadeInImage(
//                                             placeholder: AssetImage(
//                                                 'images/image_large.png'),
//                                             image: NetworkImage(
//                                                 foodList[index]['rImageURl']),
//                                             height: 180.0,
//                                             width: double.infinity,
//                                             fit: BoxFit.cover,
//                                           ),
//                                           Container(
//                                             margin: EdgeInsets.all(12.0),
//                                             child: Column(
//                                               children: [
//                                                 Row(
//                                                   children: [
//                                                     Expanded(
//                                                       child: Column(
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: [
//                                                           Text(
//                                                             foodList[index]
//                                                                 ['rName'],
//                                                             style: TextStyle(
//                                                                 fontSize: 16.0,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold),
//                                                           ),
//                                                           SizedBox(
//                                                             height: 4.0,
//                                                           ),
//                                                           Text(
//                                                             foodList[index]
//                                                                 ['rDes'],
//                                                             style: TextStyle(
//                                                               fontSize: 14.0,
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               } else {
//                                 return Container();
//                               }
//                             },
//                           );
//                         } else {
//                           return Container(
//                             child: Text("Not found"),
//                           );
//                         }
//                       } else {
//                         return Container(
//                           child: Center(
//                             child: CircularProgressIndicator(
//                               valueColor:
//                                   AlwaysStoppedAnimation<Color>(Colors.red),
//                             ),
//                           ),
//                         );
//                       }
//                     },
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/U_Home_Restaurants/restaurantDetail_Reserve%20your%20table_screen.dart';

import '../constant.dart';
import '../U_Home_foods/food_&_category_screen.dart';

class Search_Screen extends StatefulWidget {
  const Search_Screen({Key? key}) : super(key: key);

  @override
  _Search_ScreenState createState() => _Search_ScreenState();
}

class _Search_ScreenState extends State<Search_Screen> {
  TextEditingController textEditingController = TextEditingController();
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("Restaurant");
  DatabaseReference databaseReferenceFood =
      FirebaseDatabase.instance.reference().child("Foods");
  List foodList = [];
  List rList = [];
  String search = "";
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.search),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              textInputAction: TextInputAction.search,
                              decoration: InputDecoration(
                                  hintText: "search for restaurants?",
                                  border: InputBorder.none),
                              onSubmitted: (value) {
                                setState(() {
                                  search = value.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel")),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            search.isEmpty
                ? Container()
                : StreamBuilder(
                    stream: databaseReference
                        .orderByChild("rName")
                        .startAt(search)
                        .endAt(search + "\uf8ff")
                        .onValue,
                    builder: (context, AsyncSnapshot<Event> snapshot) {
                      if (snapshot.hasData) {
                        foodList.clear();
                        DataSnapshot dataSnapshot = snapshot.data!.snapshot;
                        if (dataSnapshot.value != null) {
                          Map<dynamic, dynamic> values = dataSnapshot.value;
                          values.forEach((key, value) {
                            foodList.add(value);
                          });
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: foodList.length,
                            itemBuilder: (context, index) {
                              if (true) {
                                return Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (Constant.type == "reserveTable") {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return RestaurantDetailScreen(
                                              rImageURl: foodList[index]
                                                  ['rImageURl'],
                                              rName: foodList[index]['rName'],
                                              rDes: foodList[index]['rDes'],
                                              rAddress: foodList[index]
                                                  ['rAddress'],
                                              rPhoneNo: foodList[index]
                                                  ['rPhoneNo'],
                                              rOpenCloseTime: foodList[index]
                                                  ['rOpenCloseTime'],
                                              restaurantID: foodList[index]
                                                  ['rKey']);
                                        }));
                                      } else {
                                        Constant.rKey = foodList[index]['rKey'];
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return FoodCategoryScreen(
                                              restaurantID: foodList[index]
                                                  ['rKey']);
                                        }));
                                      }
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FadeInImage(
                                            placeholder: AssetImage(
                                                'images/image_large.png'),
                                            image: NetworkImage(
                                                foodList[index]['rImageURl']),
                                            height: 180.0,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                          Container(
                                            margin: EdgeInsets.all(12.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            foodList[index]
                                                                ['rName'],
                                                            style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            height: 4.0,
                                                          ),
                                                          Text(
                                                            foodList[index]
                                                                ['rDes'],
                                                            style: TextStyle(
                                                              fontSize: 14.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          );
                        } else {
                          return Container(
                            child: Text("Not found"),
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
          ],
        ),
      ),
    );
  }
}
