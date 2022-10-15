import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class AddIngredientScreen extends StatefulWidget {
  final String fKey;
  const AddIngredientScreen({Key? key, required this.fKey}) : super(key: key);

  @override
  _AddIngredientScreenState createState() => _AddIngredientScreenState();
}

class _AddIngredientScreenState extends State<AddIngredientScreen> {
  final _formKey  = GlobalKey<FormState>();
  TextEditingController _textEditingControllerName = new TextEditingController();
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("Ingredient");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Ingredient"),
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                cursorColor: Colors.black,
                controller: _textEditingControllerName,
                validator: validName,
                decoration: InputDecoration(
                  labelText: 'Ingredient Name',
                  labelStyle: TextStyle(
                      color:  Colors.black
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:  Colors.black),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
                      _formKey.currentState!.save();
                      String autoID = databaseReference.push().key;
                      databaseReference.child(autoID).set({
                        'iName' : _textEditingControllerName.text.toString().trim(),
                        'fKey' : widget.fKey,
                        'iKey' : autoID.toString().trim(),
                        'isSelected' : false
                      }).then((value){
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Ingredient created successfully')));
                      });
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(17.0),
                    child: Text(
                      "Add",
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
            ],
          ),
        ),
      ),
    );
  }

  String? validName(String? name) {
    if(name!.isEmpty){
      return "Please enter ingredient";
    }else{
      return null;
    }
  }
}
