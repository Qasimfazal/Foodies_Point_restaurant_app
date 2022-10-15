import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class UpdateTableSeat extends StatefulWidget {
  String tkey;
  String placeOrder;
  UpdateTableSeat({Key? key, required this.tkey, required this.placeOrder})
      : super(key: key);

  @override
  _UpdateTableSeatState createState() => _UpdateTableSeatState();
}

class _UpdateTableSeatState extends State<UpdateTableSeat> {
  TextEditingController textEditingControllerTableSeat =
      TextEditingController();
  String tSeat = "";
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("OrderTable");
  DatabaseReference databaseReference2 =
      FirebaseDatabase.instance.reference().child("PlaceOrder").child("Table");
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    final User? user = auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      databaseReference.child(uid).child(widget.tkey).onValue.listen((event) {
        setState(() {
          tSeat = event.snapshot.value['tSeat'];
          print(widget.tkey);
          textEditingControllerTableSeat.text = tSeat;
        });
      });
    }

    super.initState();
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
                  "Update Table  Seats",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TextFormField(
              controller: textEditingControllerTableSeat,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Color(0xFFD1413A),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    width: 1,
                  ),
                ),
                hintStyle: TextStyle(
                  color: Color(0xFF666666),
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: "Table Seats*",
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        margin: EdgeInsets.all(18.0),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            databaseReference
                .child(Constant.userID)
                .child(widget.tkey)
                .child("tSeat")
                .set(textEditingControllerTableSeat.text);
            databaseReference2
                .child(widget.placeOrder)
                .child("tSeat")
                .set(textEditingControllerTableSeat.text);
            // databaseReference2.once().then((DataSnapshot dataSnapShot){
            //   print(dataSnapShot);
            //   Map<dynamic, dynamic> values = dataSnapShot.value;
            //   bool forEachDone=false;
            //   values.forEach((key, value) {
            //     databaseReference2.child(value['tableOrderKey']).child(value['tSeat']).set(textEditingControllerTableSeat.text);
            //   });
            //
            // });
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Seat Updated')));
          },
          child: Padding(
            padding: EdgeInsets.all(14.0),
            child: Text(
              "Save & Continue",
              style: TextStyle(fontSize: 18),
            ),
          ),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor:
                MaterialStateProperty.all<Color>(Color(0xFFD1413A)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: Color(0xFFD1413A)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
