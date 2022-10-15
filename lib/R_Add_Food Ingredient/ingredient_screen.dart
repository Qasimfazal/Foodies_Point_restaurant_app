import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/R_Add_Food%20Ingredient/add_ingredient_screen.dart';

class IngredientScreen extends StatefulWidget {
  final String fKey;
  const IngredientScreen({Key? key, required this.fKey}) : super(key: key);

  @override
  _IngredientScreenState createState() => _IngredientScreenState();
}

class _IngredientScreenState extends State<IngredientScreen> {
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("Ingredient");
  List ingredientList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("Ingredient"),
      ),
      body: Container(
        child: StreamBuilder(
          stream: databaseReference.onValue,
          builder: (context, AsyncSnapshot<Event> snapshot) {
            if (snapshot.hasData) {
              ingredientList.clear();
              DataSnapshot dataSnapshot = snapshot.data!.snapshot;
              if (dataSnapshot.value != null) {
                Map<dynamic, dynamic> values = dataSnapshot.value;
                values.forEach((key, value) {
                  ingredientList.add(value);
                });
              }
              return ListView.builder(
                itemCount: ingredientList.length,
                itemBuilder: (context, index) {
                  if (widget.fKey == ingredientList[index]['fKey']) {
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
                              margin: EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                ingredientList[index]['iName'],
                                                style:
                                                    TextStyle(fontSize: 18.0),
                                              ))),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                            onTap: () {
                                              databaseReference
                                                  .child(ingredientList[index]
                                                      ['iKey'])
                                                  .remove()
                                                  .then((value) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            "Item remove")));
                                              });
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              size: 18,
                                            )),
                                      ),
                                    ],
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
              return AddIngredientScreen(fKey: widget.fKey);
            }));
            // Add your onPressed code here!
          },
          child: const Icon(Icons.add),
          backgroundColor: Color(0xFFD1413A)),
    );
  }
}
