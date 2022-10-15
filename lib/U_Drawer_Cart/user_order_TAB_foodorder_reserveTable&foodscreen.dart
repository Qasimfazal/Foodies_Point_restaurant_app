import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/U_Drawer_Cart/orders_food%20order_screen.dart';

import 'orders_table_screen.dart_Review Ratingdailog.dart';
//import 'package:flutter_restaurant_app/U_Home_Tables/order_table_screen.dart';

class User_Order extends StatefulWidget {
  const User_Order({Key? key}) : super(key: key);

  @override
  _User_OrderState createState() => _User_OrderState();
}

class _User_OrderState extends State<User_Order> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

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
      body: Column(
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            height: 60.0,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 18.0,
                      color: Colors.black,
                    )),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "Orders",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(48),
                child: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(0),
                      child: TabBar(
                        controller: _tabController,
                        labelColor: Colors.red,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Colors.red,
                        tabs: const <Widget>[
                          Tab(
                            child: Text("Food Order"),
                          ),
                          Tab(
                            child: Text("Reserve Table & Food"),
                          ),
                        ],
                      ),
                    )),
              ),
              body: TabBarView(
                controller: _tabController,
                children: const <Widget>[
                  OrderFood(),
                  OrderTable(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
