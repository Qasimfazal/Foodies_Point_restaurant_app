import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/R_Add_Foods/food_categories_screnn.dart';
import 'package:flutter_restaurant_app/U_Home_foods/food_&_category_screen.dart';

import '../constant.dart';

class TableDetailsScreen extends StatefulWidget {
  final String tImageURl;
  final String tKey;
  final String tSeat;
  final String restaurantID;
  final String tno;
  const TableDetailsScreen(
      {Key? key,
      required this.tImageURl,
      required this.tKey,
      required this.tSeat,
      required this.restaurantID,
      required this.tno})
      : super(key: key);

  @override
  _TableDetailsScreenState createState() => _TableDetailsScreenState();
}

class _TableDetailsScreenState extends State<TableDetailsScreen> {
  final formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectTime = TimeOfDay.now();

  String dropdownValue = '12:00 PM - 2:00 PM';

  List<String> spinnerItems = [
    '12:00 PM - 2:00 PM',
    '2:00 PM - 4:00 PM',
    '4:00 PM - 6:00 PM',
    '6:00 PM - 8:00 PM',
    '8:00 PM - 10:00 PM',
    '10:00 PM - 12:00 AM',
    '12:00 AM - 2:00 AM',
  ];
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("CheckAvailable");
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
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(bottom: 100.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  FadeInImage(
                    placeholder: AssetImage('images/image_large.png'),
                    image: NetworkImage(widget.tImageURl),
                    height: 200.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
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
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.tSeat,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      "Table no. " + widget.tno,
                      style: TextStyle(fontSize: 14.0),
                    ),
                    //Text("Available",style: TextStyle(fontSize: 14.0),),
                    SizedBox(
                      height: 4.0,
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Select Date & Time",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        height: 80.0,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              //select date
                              child: GestureDetector(
                                onTap: () {
                                  _selectDate(context);
                                },
                                child: Container(
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFFE6E4E4),
                                  ),
                                  child: Center(
                                      child: Text(
                                          "Select Date\n${selectedDate.day}/${selectedDate.month}/${selectedDate.year}")),
                                ),
                              ),
                            ),

                            SizedBox(
                              width: 12.0,
                            ),

                            Expanded(
                                flex: 2,
                                child: Container(
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xFFE6E4E4),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Select Time',
                                            style:
                                                TextStyle(color: Colors.black)),
                                        DropdownButton<String>(
                                          value: dropdownValue,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 24,
                                          elevation: 16,
                                          style: TextStyle(color: Colors.black),
                                          underline: Container(
                                            height: 1,
                                            color: Color(0xFFE6E4E4),
                                          ),
                                          onChanged: (data) {
                                            setState(() {
                                              dropdownValue = data!;
                                            });
                                          },
                                          items: spinnerItems
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ))),

                            ///
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Add your onPressed code here!
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            Constant.tImage = widget.tImageURl;
            Constant.rrID = widget.restaurantID;
            Constant.tSeat = widget.tSeat;
            Constant.tKey = widget.tKey;
            Constant.selectDate =
                "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
            Constant.tno = widget.tno;
            // Constant.selectTime = selectTime.format(context).toString();
            Constant.selectTime = dropdownValue.toString();

            // databaseReference.orderByChild("tKey").equalTo(widget.tKey).once().then((DataSnapshot dataSnapshot){
            //   if(dataSnapshot.exists){
            //     Map<dynamic, dynamic> values = dataSnapshot.value;
            //     bool forEachDone=false;
            //     values.forEach((key, value) {
            //       if(value['tDate'] == '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}' && value['tTime'] == dropdownValue){
            //         if(!forEachDone){
            //           forEachDone=true;
            //           print('Date Time Find');
            //         }
            //       }else{
            //         if(!forEachDone){
            //           forEachDone=true;
            //           print('Date Time Not Find');
            //         }
            //       }
            //     });
            //     print("Table Exist");
            //   }else{
            //     print("Table Not Exist");
            //   }
            // });
            databaseReference.once().then((DataSnapshot dataSnapShot) {
              print(dataSnapShot);
              Map<dynamic, dynamic> values = dataSnapShot.value;
              bool forEachDone = false;
              values.forEach((key, value) {
                if (value['tDate'] ==
                        '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}' &&
                    value['tTime'] == dropdownValue &&
                    value['tKey'] == widget.tKey) {
                  forEachDone = true;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Table is Booked for this Date : " +
                          value['tDate'] +
                          " and Time Duration " +
                          value['tTime'])));
                }
              });
              if (!forEachDone) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return FoodCategoryScreen(restaurantID: widget.restaurantID);
                }));
              }
            });
          }
        },
        child: const Icon(Icons.navigate_next),
        backgroundColor: Color(0xFFD1413A),
      ),
    );
  }

  _selectTime() async {
    final TimeOfDay? result = await showTimePicker(
      context: context,
      initialTime: selectTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.red, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (result != null) {
      setState(() {
        selectTime = result;
      });
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(Duration(days: 1)),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.red, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  }

  String? validAddress(String? address) {
    if (address!.isEmpty) {
      return "Please enter address";
    } else {
      return null;
    }
  }

  String? validPhoneNumber(String? phoneNumber) {
    if (phoneNumber!.isEmpty) {
      return "Please enter phone number";
    } else {
      return null;
    }
  }

  String? validUsername(String? userName) {
    if (userName!.isEmpty) {
      return "Please enter user name";
    } else {
      return null;
    }
  }
}
