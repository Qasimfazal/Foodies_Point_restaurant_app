import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'add_categories_screen.dart';

class CategoriesScreen extends StatefulWidget {
  final String restaurantID;
  CategoriesScreen({Key? key, required this.restaurantID}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("Category");
  List categoryList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("Categories"),
      ),
      body: Container(
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
                      categoryList.add(value);
                    }
                  });
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1 / 1.4),
                  itemCount: categoryList.length,
                  itemBuilder: (context, index) {
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
                              image: NetworkImage(
                                  categoryList[index]['cImageURl']),
                              height: 150.0,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Container(
                                margin: EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Text(
                                      categoryList[index]['cName'],
                                      style: TextStyle(fontSize: 18.0),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        databaseReference
                                            .child(categoryList[index]['cKey'])
                                            .remove()
                                            .then((value) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content:
                                                      Text("Item remove")));
                                        });
                                      },
                                      child: Container(
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
                                ))
                          ],
                        ),
                      ),
                    );
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
              return AddCategoriesScreen(restaurantID: widget.restaurantID);
            }));
            // Add your onPressed code here!
          },
          child: const Icon(Icons.add),
          backgroundColor: Color(0xFFD1413A)),
    );
  }
}
