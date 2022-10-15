import 'package:flutter/material.dart';


class About_Screen extends StatefulWidget {
  const About_Screen({Key? key}) : super(key: key);

  @override
  _About_ScreenState createState() => _About_ScreenState();
}

class _About_ScreenState extends State<About_Screen> {
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
      body: Column(
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            height: 60.0,
            child: Row(
              children: [
                IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios,size: 18.0,color: Colors.black,)),
                SizedBox(width: 5.0,),
                Text("About",style: TextStyle(color: Colors.black,fontSize: 18.0,fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color:  Color(0xFFF5F5F5),
            ),
          ),
        ],
      ),
    );
  }
}
