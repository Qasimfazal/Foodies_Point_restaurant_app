import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/U_Home_Reserve%20Tables%20select%20date%20&%20time/table_Select%20Date%20&%20Time_detail_screen.dart';
//import 'package:flutter_restaurant_app/U_Home_Reserve%20Tables/table_select%20Date%20&%20Time_detail_screen.dart';
//import 'package:flutter_restaurant_app/U_Home_Tables/table_select%20Date%20&%20Time_detail_screen.dart';

import '../constant.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final String rImageURl;
  final String restaurantID;
  final String rName;
  final String rDes;
  final String rAddress;
  final String rPhoneNo;
  final String rOpenCloseTime;
  RestaurantDetailScreen(
      {Key? key,
      required this.rImageURl,
      required this.restaurantID,
      required this.rName,
      required this.rDes,
      required this.rAddress,
      required this.rPhoneNo,
      required this.rOpenCloseTime})
      : super(key: key);

  @override
  _RestaurantDetailScreenState createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("Tables");
  List tableList = [];

  @override

  Widget build(BuildContext context) {
    print(widget.rImageURl.toString());
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Color(0xFFFFFFFF),
            elevation: 0,
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  FadeInImage(
                    placeholder: AssetImage('images/image_large.png'),
                    image: NetworkImage(widget.rImageURl),
                    height: 200.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Column(
                    children: [
                      Container(
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
                    ],
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.rName,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      widget.rDes,
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
                          widget.rAddress,
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
                        Flexible(
                            child: Text(
                          widget.rPhoneNo,
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
                        Flexible(
                            child: Text(
                          widget.rOpenCloseTime,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14.0),
                        )),
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(9.0),
                child: Text(
                  "Reserve Your Table",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 14.0,
              ),
              Container(
                child: StreamBuilder(
                  stream: databaseReference.onValue,
                  builder: (context, AsyncSnapshot<Event> snapshot) {
                    if (snapshot.hasData) {
                      tableList.clear();
                      DataSnapshot dataSnapshot = snapshot.data!.snapshot;
                      if (dataSnapshot.value != null) {
                        Map<dynamic, dynamic> values = dataSnapshot.value;
                        values.forEach((key, value) {
                          tableList.add(value);
                        });
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),

                        itemCount: tableList.length,
                        itemBuilder: (context, index) {
                          if (widget.restaurantID == tableList[index]['rKey']) {
                            return Padding(
                              padding: EdgeInsets.all(4.0),
                              child: GestureDetector(
                                onTap: () {
                                  // if(tableList[index]['isAvailable'] == "1"){
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //       const SnackBar(content: Text('Table Booked')));
                                  // }else{
                                  //   Constant.rName = widget.rName;
                                  //   Constant.rAddress = widget.rAddress;
                                  //   Constant.rDes = widget.rDes;
                                  //   Constant.rImageURl = widget.rImageURl;
                                  //   Constant.restaurantID = widget.restaurantID;
                                  //   Constant.rUID = tableList[index]['uID'];
                                  //   Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                  //     return TableDetailsScreen(tImageURl : tableList[index]['tImageURl'], tKey : tableList[index]['tKey'],tSeat : tableList[index]['tSeat'],restaurantID:widget.restaurantID, tno : tableList[index]['tno']);
                                  //   }));
                                  // }
                                  Constant.rName = widget.rName;
                                  Constant.rAddress = widget.rAddress;
                                  Constant.rDes = widget.rDes;
                                  Constant.rImageURl = widget.rImageURl;
                                  Constant.restaurantID = widget.restaurantID;
                                  Constant.rUID = tableList[index]['uID'];
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return TableDetailsScreen(
                                        tImageURl: tableList[index]['tImageURl'],
                                        tKey: tableList[index]['tKey'],
                                        tSeat: tableList[index]['tSeat'],
                                        restaurantID: widget.restaurantID,
                                        tno: tableList[index]['tno']);
                                  }));
                                },
                                child: Card(
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Row(
                                    children: [
                                      FadeInImage(
                                        placeholder: AssetImage(
                                            'images/image_large.png'),
                                        image: NetworkImage(
                                            tableList[index]['tImageURl']),
                                        height: 80.0,
                                        width: 80.0,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            tableList[index]['tSeat'],
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Table no. " +
                                                tableList[index]['tno'],
                                            style: TextStyle(fontSize: 12.0),
                                          ),
                                          // tableList[index]['isAvailable'] == "0" ? Text('Available',style: TextStyle(fontSize: 12.0),) : Text("Booked",style: TextStyle(fontSize: 12.0),),
                                          Text(
                                            'Available',
                                            style: TextStyle(fontSize: 12.0),
                                          ),
                                        ],
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
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.red),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
