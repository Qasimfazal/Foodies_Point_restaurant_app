import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/progress_dialog.dart';
import 'package:image_picker/image_picker.dart';

class AddTableScreen extends StatefulWidget {
  final String restaurantID;
  AddTableScreen({Key? key, required this.restaurantID}) : super(key: key);

  @override
  _AddTableScreenState createState() => _AddTableScreenState();
}

class _AddTableScreenState extends State<AddTableScreen> {
  var imageFile;
  chooseImage() async {
    XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = File(image!.path);
    });
  }

  ImagePicker imagePicker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textEditingControllerTableName =
      new TextEditingController();
  TextEditingController _textEditingControllerTableNo =
      new TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("Tables");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("Add Tables"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                imageFile != null
                    ? GestureDetector(
                        onTap: () {
                          chooseImage();
                        },
                        child: Container(
                          height: 250.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: FileImage(imageFile!),
                            fit: BoxFit.contain,
                          )),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          chooseImage();
                        },
                        child: Image.asset(
                          'images/placeholderimage.png',
                          height: 250.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                TextFormField(
                  cursorColor: Colors.black,
                  controller: _textEditingControllerTableNo,
                  validator: validTableNo,
                  decoration: InputDecoration(
                    labelText: 'Table no',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  controller: _textEditingControllerTableName,
                  validator: validTableName,
                  decoration: InputDecoration(
                    labelText: 'Table seats',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _uploadImage();
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
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _uploadImage() {
    final User? user = auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      if (imageFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please choose image file')));
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return Progress_Dialog(message: "Please wait...");
            });
        // create a unique file name for image
        String imageFileName = DateTime.now().microsecondsSinceEpoch.toString();
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child("Table_Image")
            .child(imageFileName);
        UploadTask uploadTask = storageReference.putFile(imageFile);
        uploadTask.then((TaskSnapshot taskSnapshot) {
          taskSnapshot.ref.getDownloadURL().then((imageURL) {
            String autoID = databaseReference.push().key;
            databaseReference.child(autoID).set({
              'tImageURl': imageURL.toString(),
              'tSeat': _textEditingControllerTableName.text.toString().trim(),
              'tno': _textEditingControllerTableNo.text.toString().trim(),
              'isAvailable': '0',
              'rKey': widget.restaurantID,
              'tKey': autoID.toString().trim(),
              'uID': uid.toString().trim()
            }).then((value) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Table created successfully')));
              print(imageURL.toString());
            });
          });
        }).catchError((error) {
          Navigator.pop(context);
          print(error.toString());
        });
      }
    }
  }

  String? validTableName(String? name) {
    if (name!.isEmpty) {
      return "Please enter table seats";
    } else {
      return null;
    }
  }

  String? validTableNo(String? value) {
    if (value!.isEmpty) {
      return "Please enter table no";
    } else {
      return null;
    }
  }
}
