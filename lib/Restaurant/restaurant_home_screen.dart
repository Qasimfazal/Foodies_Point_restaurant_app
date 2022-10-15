import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/R-Menu_Reviews/review_screen.dart';
import 'package:flutter_restaurant_app/R_Add%20Restaurant/add_restaurant_screen.dart';
import 'package:flutter_restaurant_app/R_Menu_Food%20Order/foodorder_screen.dart';
import 'package:flutter_restaurant_app/R_Menu_Stock%20Report/stock_report_screen.dart';
import 'package:flutter_restaurant_app/R_Menu_Stock%20Management/stock_management_screen.dart';
import 'package:flutter_restaurant_app/R_Menu_Table%20Order/table_order_screen.dart';
import '../R_add_Categories/categories_screen.dart';
import '../R_Add_Foods/food_categories_screnn.dart';
import '../R_Add_Tables/tables_screen.dart';
import '../join_us.dart';

class Restaurant_Home extends StatefulWidget {
  const Restaurant_Home({Key? key}) : super(key: key);

  @override
  _Restaurant_HomeState createState() => _Restaurant_HomeState();
}

class _Restaurant_HomeState extends State<Restaurant_Home> {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("Restaurant");
  DatabaseReference databaseReferenceFood =
      FirebaseDatabase.instance.reference().child("Foods");

  List restaurantList = [];

  @override
  //snackbar / popup update your food quantity
  void initState() {
    final User? user = auth.currentUser;
    String uid = user!.uid;
    databaseReferenceFood.onValue.listen((event) {
      var data = event.snapshot.value;
      // bool forEachDone=false;
      data.forEach((key, values) {
        if (uid == values['uID']) {
          if (int.parse(values['fQuantity']) >=
              int.parse(values['fRemainingQuantity'])) {
            // if(!forEachDone){
            //   forEachDone=true;

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Update your food " +
                    values['fName'] +
                    ". " +
                    "Product Quantity is " +
                    values['fQuantity'] +
                    " and available quantity is " +
                    values['fRemainingQuantity'])));
            // }
          }
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant Home"),
        brightness: Brightness.dark,
        actions: [
          //MENU
          PopupMenuButton(onSelected: (items) async {
            switch (items) {
              case 1:
                await FirebaseAuth.instance.signOut().whenComplete(() {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return Join_Us();
                  }));
                });
                break;
              case 2:
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return TableOrder_Screen();
                }));
                break;
              case 3:
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return FoodOrder_Screen();
                }));
                break;
              case 4:
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Stock_Management_Screen();
                }));
                break;
              case 5:
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Stock_Report();
                }));
                break;
              case 6:
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Review_Screen();
                }));
                break;
            }
          }, itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: Text("Logout"),
                value: 1,
              ),
              PopupMenuItem(
                child: Text("Table Order"),
                value: 2,
              ),
              PopupMenuItem(
                child: Text("Food Order"),
                value: 3,
              ),
              PopupMenuItem(
                child: Text("Stock Management"),
                value: 4,
              ),
              PopupMenuItem(
                child: Text("Stock Report"),
                value: 5,
              ),
              PopupMenuItem(
                child: Text("Reviews"),
                value: 6,
              ),
            ];
          })
        ],
      ),
      body: Container(
        child: Container(
          //show restaurant
          child: StreamBuilder(
            stream: databaseReference.onValue,
            builder: (context, AsyncSnapshot<Event> snapshot) {
              if (snapshot.hasData) {
                final User? user = auth.currentUser;
                String uid = user!.uid;
                restaurantList.clear();
                DataSnapshot dataSnapshot = snapshot.data!.snapshot;
                if (dataSnapshot.value != null) {
                  Map<dynamic, dynamic> values = dataSnapshot.value;
                  values.forEach((key, value) {
                    restaurantList.add(value);
                  });
                }
                return ListView.builder(
                  itemCount: restaurantList.length,
                  itemBuilder: (context, index) {
                    if (uid == restaurantList[index]['uID']) {
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
                                    restaurantList[index]['rImageURl']),
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
                                      restaurantList[index]['rName'],
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 4.0,
                                    ),
                                    Text(
                                      restaurantList[index]['rDes'],
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                    SizedBox(
                                      height: 4.0,
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
                                          restaurantList[index]['rAddress'],
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
                                          Icons.phone,
                                          size: 14,
                                        ),
                                        SizedBox(
                                          width: 6.0,
                                        ),
                                        Text(
                                          restaurantList[index]['rPhoneNo'],
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
                                          restaurantList[index]
                                              ['rOpenCloseTime'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0),
                                        ),
                                      ],
                                    ),
                                    //
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      height: 6.0,
                                    ),
                                    //ADD CATEGORIES
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return CategoriesScreen(
                                              restaurantID:
                                                  restaurantList[index]
                                                      ['rKey']);
                                        }));
                                      },
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
                                            "Add Categories",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6.0,
                                    ),
                                    //ADD TABLES
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return TableScreen(
                                              restaurantID:
                                                  restaurantList[index]
                                                      ['rKey']);
                                        }));
                                      },
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
                                            "Add Tables",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6.0,
                                    ),
                                    //ADD FOODS
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return FoodCategoriesScreen(
                                              restaurantID:
                                                  restaurantList[index]
                                                      ['rKey']);
                                        }));
                                      },
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
                                    SizedBox(
                                      height: 6.0,
                                    ),
                                    // GestureDetector(
                                    //   onTap: (){
                                    //     databaseReference.child(restaurantList[index]['rKey']).remove().then((value){
                                    //       ScaffoldMessenger.of(context).showSnackBar(
                                    //           SnackBar(content: Text("Item remove")));
                                    //     });
                                    //   },
                                    //   child: Container(
                                    //     height: 50.0,
                                    //     child:  Row(
                                    //       mainAxisAlignment: MainAxisAlignment.center,
                                    //       children: [
                                    //         Icon(Icons.delete,size: 16,),
                                    //         SizedBox(width: 6.0,),
                                    //         Text("Remove",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
                                    //       ],
                                    //     ),
                                    //   ),
                                    //
                                    // ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                );
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
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Add_Restaurant_Screen();
            }));
            // Add your onPressed code here!
          },
          child: const Icon(Icons.add),
          backgroundColor: Color(0xFFD1413A)),
    );
  }
}
