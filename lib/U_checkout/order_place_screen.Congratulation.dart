import 'package:flutter/material.dart';


class OrderPlace_Screen extends StatefulWidget {
  const OrderPlace_Screen({Key? key}) : super(key: key);

  @override
  _OrderPlace_ScreenState createState() => _OrderPlace_ScreenState();
}

class _OrderPlace_ScreenState extends State<OrderPlace_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor:  Color(0xFFFFFFFF),
          elevation: 0,
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 60.0,
              child: Row(
                children: [
                  IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios,size: 18.0,color: Colors.black,)),
                  SizedBox(width: 5.0,),
                  Text("Order Placed",style: TextStyle(color: Colors.black,fontSize: 18.0,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            Expanded(
                child: Column(
                  children: [
                    SizedBox(height: 50,),
                    Icon(Icons.verified,size: 140.0,color: Color(0xFFD1413A),),
                    SizedBox(height: 10,),
                    Text("Congratulation!",style: TextStyle(color: Color(0xFFD1413A),fontSize: 20.0),),
                    SizedBox(height: 5,),
                    Text('Your Order Has been Placed',style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 30,),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 30.0),
                      child:  ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            "View Orders",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFD1413A)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(color: Color(0xFFD1413A)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 30.0),
                      child:  ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            "Continue Shopping",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Color(0xFFD1413A)),
                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFFFFFF)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(color: Color(0xFFD1413A)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
