import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Update_Stock_Screen extends StatefulWidget {
  String fKey;
  Update_Stock_Screen({Key? key, required this.fKey}) : super(key: key);

  @override
  _Update_Stock_ScreenState createState() => _Update_Stock_ScreenState();
}

class _Update_Stock_ScreenState extends State<Update_Stock_Screen> {
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("Foods");
  TextEditingController textEditingController = new TextEditingController();
  String? quantity;
  @override
  void initState() {
    databaseReference.child(widget.fKey.toString()).onValue.listen((event) {
      setState(() {
        quantity = event.snapshot.value['fRemainingQuantity'];
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    textEditingController.text = quantity.toString();
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("Update Quantity"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Quantity',
                        labelStyle: TextStyle(
                            color:  Colors.black
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color:  Colors.black),
                        ),
                      ),
                      controller: textEditingController,
                    )
                ),
                SizedBox(width: 10,),
                SizedBox(width: 100,
                child: ElevatedButton(
                  onPressed: (){
                        databaseReference.child(widget.fKey.toString()).child("fRemainingQuantity").set(textEditingController.text.toString());
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Quantity Updated')));
                        Navigator.pop(context);
                  },
                  child: Text("Update"),),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
