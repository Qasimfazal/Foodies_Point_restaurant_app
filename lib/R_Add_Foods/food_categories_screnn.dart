import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'food_screen.dart';

class FoodCategoriesScreen extends StatefulWidget {
  final String restaurantID;
  FoodCategoriesScreen({Key? key, required this.restaurantID})
      : super(key: key);

  @override
  _FoodCategoriesScreenState createState() => _FoodCategoriesScreenState();
}

class _FoodCategoriesScreenState extends State<FoodCategoriesScreen> {
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("Category");
  List categoryList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("Food Category"),
      ),
      body: Container(
        child: StreamBuilder(
          stream: databaseReference.onValue,
          builder: (context, AsyncSnapshot<Event> snapshot) {
            if (snapshot.hasData) {
              categoryList.clear();
              DataSnapshot dataSnapshot = snapshot.data!.snapshot;
              if (dataSnapshot.value != null) {
                Map<dynamic, dynamic> values = dataSnapshot.value;
                values.forEach((key, value) {
                  categoryList.add(value);
                });
              }
              return ListView.builder(
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  if (widget.restaurantID == categoryList[index]['rKey']) {
                    return Padding(
                      padding: EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return FoodScreen(
                                restaurantID: widget.restaurantID,
                                categoryID: categoryList[index]['cKey'],
                                cName: categoryList[index]['cName']);
                          }));
                        },
                        child: Card(
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Row(
                            children: [
                              FadeInImage(
                                placeholder:
                                    AssetImage('images/image_large.png'),
                                image: NetworkImage(
                                    categoryList[index]['cImageURl']),
                                height: 80.0,
                                width: 80.0,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Expanded(
                                  child: Text(
                                categoryList[index]['cName'],
                                style: TextStyle(fontSize: 18.0),
                              )),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.grey,
                                size: 35,
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                            ],
                          ),
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
    );
  }
}
