import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/U-R_Show%20Details_food_order_details_screen.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class Stock_Report extends StatefulWidget {
  const Stock_Report({Key? key}) : super(key: key);

  @override
  _Stock_ReportState createState() => _Stock_ReportState();
}

class _Stock_ReportState extends State<Stock_Report>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          brightness: Brightness.dark,
          title: Text("Stock Report"),
          bottom: TabBar(
            controller: _tabController,
            tabs: const <Widget>[
              Tab(
                child: Text("Day"),
              ),
              Tab(
                child: Text("Week"),
              ),
              Tab(
                child: Text("Month"),
              ),
              Tab(
                child: Text("Year"),
              ),
            ],
          )),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Day_Screen(),
          Week_Screen(),
          Month_Screen(),
          Year_Screen(),
        ],
      ),
    );
  }
}
// Day

class Day_Screen extends StatefulWidget {
  const Day_Screen({Key? key}) : super(key: key);

  @override
  _Day_ScreenState createState() => _Day_ScreenState();
}

class _Day_ScreenState extends State<Day_Screen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("ResturantFoodOrder");
  List foodOrderList = [];
  final DateFormat formatter = DateFormat('MM/dd/yyyy');
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        GestureDetector(
          onTap: () {
            _selectDate(context);
          },
          child: Container(
            padding: EdgeInsets.all(18),
            width: double.infinity,
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFE6E4E4),
            ),
            child: Center(
                child: Text("Select Date\n" +
                    formatter.format(selectedDate).toString())),
          ),
        ),
        StreamBuilder(
          stream: databaseReference.onValue,
          builder: (context, AsyncSnapshot<Event> snapshot) {
            if (snapshot.hasData) {
              final User? user = auth.currentUser;
              String uid = user!.uid;
              foodOrderList.clear();
              DataSnapshot dataSnapshot = snapshot.data!.snapshot;
              if (dataSnapshot.value != null) {
                Map<dynamic, dynamic> values = dataSnapshot.value;
                values.forEach((key, value) {
                  if (value['dates'] ==
                      formatter.format(selectedDate).toString()) {
                    foodOrderList.add(value);
                  }
                });
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: foodOrderList.length,
                itemBuilder: (context, index) {
                  if (uid == foodOrderList[index]['rID']) {
                    return Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return ShowFoodOrder_Screen(
                                    uID: foodOrderList[index]['uID'],
                                    cardID: foodOrderList[index]['cardID']);
                              }));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'User name : ',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              foodOrderList[index]['name'],
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.grey),
                                            ))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Address :',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              foodOrderList[index]['address'],
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.grey),
                                            ))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Email : ',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              foodOrderList[index]['email'],
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.grey),
                                            ))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Phone : ',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              foodOrderList[index]['phone'],
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.grey),
                                            ))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Date : ',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              foodOrderList[index]['dates'],
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.grey),
                                            ))),
                                  ],
                                ),
                                Center(
                                    child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          "Show Details",
                                          style: TextStyle(fontSize: 20),
                                        )))
                              ],
                            ),
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
      ],
    ));
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
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
        String formattedDate = DateFormat.yMMMEd().format(selectedDate);
        print(formattedDate);
      });
  }
}

class Month_Screen extends StatefulWidget {
  const Month_Screen({Key? key}) : super(key: key);

  @override
  _Month_ScreenState createState() => _Month_ScreenState();
}

class _Month_ScreenState extends State<Month_Screen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("ResturantFoodOrder");
  List foodOrderList = [];
  final DateFormat formatter = DateFormat('MM/yyyy');
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        GestureDetector(
          onTap: () {
            _selectDate(context);
          },
          child: Container(
            padding: EdgeInsets.all(18),
            width: double.infinity,
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFE6E4E4),
            ),
            child: Center(
                child: Text("Select Month\n" +
                    formatter.format(selectedDate).toString())),
          ),
        ),
        StreamBuilder(
          stream: databaseReference.onValue,
          builder: (context, AsyncSnapshot<Event> snapshot) {
            if (snapshot.hasData) {
              final User? user = auth.currentUser;
              String uid = user!.uid;
              foodOrderList.clear();
              DataSnapshot dataSnapshot = snapshot.data!.snapshot;
              if (dataSnapshot.value != null) {
                Map<dynamic, dynamic> values = dataSnapshot.value;
                values.forEach((key, value) {
                  if (value['dates'].substring(0, 2) ==
                      formatter
                          .format(selectedDate)
                          .toString()
                          .substring(0, 2)) {
                    if (value['dates'].substring(6) == "${selectedDate.year}") {
                      foodOrderList.add(value);
                    }
                  }
                });
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: foodOrderList.length,
                itemBuilder: (context, index) {
                  if (uid == foodOrderList[index]['rID']) {
                    return Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return ShowFoodOrder_Screen(
                                    uID: foodOrderList[index]['uID'],
                                    cardID: foodOrderList[index]['cardID']);
                              }));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'User name : ',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              foodOrderList[index]['name'],
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.grey),
                                            ))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Address :',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              foodOrderList[index]['address'],
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.grey),
                                            ))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Email : ',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              foodOrderList[index]['email'],
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.grey),
                                            ))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Phone : ',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              foodOrderList[index]['phone'],
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.grey),
                                            ))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Date : ',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              foodOrderList[index]['dates'],
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.grey),
                                            ))),
                                  ],
                                ),
                                Center(
                                    child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          "Show Details",
                                          style: TextStyle(fontSize: 20),
                                        )))
                              ],
                            ),
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
      ],
    ));
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showMonthPicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 10, 5),
      lastDate: DateTime(DateTime.now().year + 10, 9),
      initialDate: selectedDate,
      locale: Locale("en"),
    ).then((date) {
      if (date != null) {
        setState(() {
          selectedDate = date;
        });
      }
    });
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  }
}

class Week_Screen extends StatefulWidget {
  const Week_Screen({Key? key}) : super(key: key);

  @override
  _Week_ScreenState createState() => _Week_ScreenState();
}

class _Week_ScreenState extends State<Week_Screen> {
  DateTime selectedDate = DateTime.now();
  String startDay = '';
  String startMonth = '';
  String startYear = '';
  String endDay = '';
  String endMonth = '';
  String endYear = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        startDay = DateFormat('dd').format(args.value.startDate);
        startMonth = DateFormat('MM').format(args.value.startDate);
        startYear = DateFormat('yyyy').format(args.value.startDate);
        endDay =
            DateFormat('dd').format(args.value.endDate ?? args.value.startDate);
        endMonth =
            DateFormat('MM').format(args.value.endDate ?? args.value.startDate);
        endYear = DateFormat('yyyy')
            .format(args.value.endDate ?? args.value.startDate);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.reference().child("ResturantFoodOrder");
    List foodOrderList = [];
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SfDateRangePicker(
            onSelectionChanged: _onSelectionChanged,
            selectionMode: DateRangePickerSelectionMode.range,
            initialSelectedRange: PickerDateRange(
                DateTime.now().subtract(const Duration(days: 4)),
                DateTime.now().add(const Duration(days: 3))),
          ),
          StreamBuilder(
            stream: databaseReference.onValue,
            builder: (context, AsyncSnapshot<Event> snapshot) {
              if (snapshot.hasData) {
                final User? user = auth.currentUser;
                String uid = user!.uid;
                foodOrderList.clear();
                DataSnapshot dataSnapshot = snapshot.data!.snapshot;
                if (dataSnapshot.value != null) {
                  Map<dynamic, dynamic> values = dataSnapshot.value;
                  values.forEach((key, value) {
                    // print(int.parse(value['dates'].substring(0,2))<= int.parse(startMonth));
                    if (startDay.isEmpty) {
                      foodOrderList.add(value);
                    } else {
                      if (int.parse(value['dates'].substring(0, 2)) ==
                          int.parse(startMonth)) {
                        if (int.parse(value['dates'].substring(6)) ==
                            int.parse(startYear)) {
                          if (int.parse(value['dates'].substring(3, 5)) >=
                              int.parse(startDay)) {
                            if (int.parse(value['dates'].substring(3, 5)) <=
                                int.parse(endDay)) {
                              foodOrderList.add(value);
                            }
                          }
                        }
                      }
                    }
                  });
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: foodOrderList.length,
                  itemBuilder: (context, index) {
                    if (uid == foodOrderList[index]['rID']) {
                      return Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return ShowFoodOrder_Screen(
                                      uID: foodOrderList[index]['uID'],
                                      cardID: foodOrderList[index]['cardID']);
                                }));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'User name : ',
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                foodOrderList[index]['name'],
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.grey),
                                              ))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Address :',
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                foodOrderList[index]['address'],
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.grey),
                                              ))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Email : ',
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                foodOrderList[index]['email'],
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.grey),
                                              ))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Phone : ',
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                foodOrderList[index]['phone'],
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.grey),
                                              ))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Date : ',
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                foodOrderList[index]['dates'],
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.grey),
                                              ))),
                                    ],
                                  ),
                                  Center(
                                      child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            "Show Details",
                                            style: TextStyle(fontSize: 20),
                                          )))
                                ],
                              ),
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
        ],
      ),
    ));
  }
}

class Year_Screen extends StatefulWidget {
  const Year_Screen({Key? key}) : super(key: key);

  @override
  _Year_ScreenState createState() => _Year_ScreenState();
}

class _Year_ScreenState extends State<Year_Screen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("ResturantFoodOrder");
  List foodOrderList = [];
  String year = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        GestureDetector(
          onTap: () {
            _pickYear(context);
          },
          child: Container(
            padding: EdgeInsets.all(18),
            width: double.infinity,
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFE6E4E4),
            ),
            child: Center(child: Text("Select Year: " + year)),
          ),
        ),
        Expanded(
          child: StreamBuilder(
            stream: databaseReference.onValue,
            builder: (context, AsyncSnapshot<Event> snapshot) {
              if (snapshot.hasData) {
                final User? user = auth.currentUser;
                String uid = user!.uid;
                foodOrderList.clear();
                DataSnapshot dataSnapshot = snapshot.data!.snapshot;
                if (dataSnapshot.value != null) {
                  Map<dynamic, dynamic> values = dataSnapshot.value;
                  values.forEach((key, value) {
                    // print(int.parse(value['dates'].substring(0,2))<= int.parse(startMonth));
                    if (year.isEmpty) {
                    } else {
                      if (int.parse(value['dates'].substring(6)) ==
                          int.parse(year)) {
                        foodOrderList.add(value);
                      }
                    }
                  });
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: foodOrderList.length,
                  itemBuilder: (context, index) {
                    if (uid == foodOrderList[index]['rID']) {
                      return Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return ShowFoodOrder_Screen(
                                      uID: foodOrderList[index]['uID'],
                                      cardID: foodOrderList[index]['cardID']);
                                }));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'User name : ',
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                foodOrderList[index]['name'],
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.grey),
                                              ))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Address :',
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                foodOrderList[index]['address'],
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.grey),
                                              ))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Email : ',
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                foodOrderList[index]['email'],
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.grey),
                                              ))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Phone : ',
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                foodOrderList[index]['phone'],
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.grey),
                                              ))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Date : ',
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                foodOrderList[index]['dates'],
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.grey),
                                              ))),
                                    ],
                                  ),
                                  Center(
                                      child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            "Show Details",
                                            style: TextStyle(fontSize: 20),
                                          )))
                                ],
                              ),
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
      ],
    ));
  }

  void _pickYear(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final Size size = MediaQuery.of(context).size;
        return AlertDialog(
          title: Text('Select a Year'),
          // Changing default contentPadding to make the content looks better

          contentPadding: const EdgeInsets.all(10),
          content: SizedBox(
            // Giving some size to the dialog so the gridview know its bounds

            height: size.height / 3,
            width: size.width,
            //  Creating a grid view with 3 elements per line.
            child: GridView.count(
              crossAxisCount: 3,
              children: [
                // Generating a list of 123 years starting from 2022
                // Change it depending on your needs.
                ...List.generate(
                  123,
                  (index) => InkWell(
                    onTap: () {
                      // The action you want to happen when you select the year below,

                      // Quitting the dialog through navigator.
                      setState(() {
                        year = (2022 - index).toString();
                      });
                      Navigator.pop(context);
                    },
                    // This part is up to you, it's only ui elements
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Chip(
                        label: Container(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            // Showing the year text, it starts from 2022 and ends in 1900 (you can modify this as you like)
                            (2022 - index).toString(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
