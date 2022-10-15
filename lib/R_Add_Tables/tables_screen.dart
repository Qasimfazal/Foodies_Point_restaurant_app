import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'add_table_screen.dart';

class TableScreen extends StatefulWidget {
  final String restaurantID;
  TableScreen({Key? key, required this.restaurantID}) : super(key: key);

  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("Tables");
  List tableList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("Restaurant Table"),
      ),
      body: Container(
        child: Container(
          child: StreamBuilder(
            stream: databaseReference.onValue,
            builder: (context, AsyncSnapshot<Event> snapshot) {
              if (snapshot.hasData) {
                tableList.clear();
                DataSnapshot dataSnapshot = snapshot.data!.snapshot;
                if (dataSnapshot.value != null) {
                  Map<dynamic, dynamic> values = dataSnapshot.value;
                  values.forEach((key, value) {
                    if (widget.restaurantID == value['rKey']) {
                      tableList.add(value);
                    }
                  });
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1 / 1.5),
                  itemCount: tableList.length,
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
                              image:
                                  NetworkImage(tableList[index]['tImageURl']),
                              height: 150.0,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Container(
                                margin: EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Text(
                                      tableList[index]['tSeat'],
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "Table no. " + tableList[index]['tno'],
                                      style: TextStyle(
                                        fontSize: 13.0,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        databaseReference
                                            .child(tableList[index]['tKey'])
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
              return AddTableScreen(restaurantID: widget.restaurantID);
            }));
            // Add your onPressed code here!
          },
          child: const Icon(Icons.add),
          backgroundColor: Color(0xFFD1413A)),
    );
  }
}
