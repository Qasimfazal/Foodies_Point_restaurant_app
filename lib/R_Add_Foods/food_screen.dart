import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/R_Add_Food%20Ingredient/ingredient_screen.dart';

import 'add_food_screen.dart';

class FoodScreen extends StatefulWidget {
  final String restaurantID;
  final String categoryID;
  final String cName;

  FoodScreen(
      {Key? key,
      required this.restaurantID,
      required this.categoryID,
      required this.cName})
      : super(key: key);

  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("Foods");
  List foodList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(widget.cName),
      ),
      body: Container(
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
                itemCount: foodList.length,
                itemBuilder: (context, index) {
                  if (widget.categoryID == foodList[index]['cKey']) {
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
                              placeholder: AssetImage('images/image_large.png'),
                              image: NetworkImage(foodList[index]['fImageURl']),
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
                                    foodList[index]['fName'],
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  Text(
                                    "RS -/" + foodList[index]['fPrice'],
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
                                            Icons
                                                .production_quantity_limits_sharp,
                                            size: 14,
                                          )),
                                      SizedBox(
                                        width: 6.0,
                                      ),
                                      Flexible(
                                          child: Text(
                                        foodList[index]['fQuantity'],
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
                                        Icons.access_time,
                                        size: 14,
                                      ),
                                      SizedBox(
                                        width: 6.0,
                                      ),
                                      Text(
                                        foodList[index]['fCookTime'] + " min",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 6.0,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return IngredientScreen(
                                            fKey: foodList[index]['fKey']);
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
                                          "Add Food Ingredients",
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
                                  GestureDetector(
                                    onTap: () {
                                      databaseReference
                                          .child(foodList[index]['fKey'])
                                          .remove()
                                          .then((value) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text("Item remove")));
                                      });
                                    },
                                    child: Container(
                                      height: 50.0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.delete,
                                            size: 16,
                                          ),
                                          SizedBox(
                                            width: 6.0,
                                          ),
                                          Text(
                                            "Remove",
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
                  } else {
                    return Container();
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
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return AddFoodScreen(
                  restaurantID: widget.restaurantID,
                  categoryID: widget.categoryID);
            }));
            // Add your onPressed code here!
          },
          child: const Icon(Icons.add),
          backgroundColor: Color(0xFFD1413A)),
    );
  }
}
