import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/progress_dialog.dart';
import 'package:image_picker/image_picker.dart';

class AddFoodScreen extends StatefulWidget {
  final String restaurantID;
  final String categoryID;
  const AddFoodScreen(
      {Key? key, required this.restaurantID, required this.categoryID})
      : super(key: key);

  @override
  _AddFoodScreenState createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
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
  TextEditingController _textEditingControllerFoodName =
      new TextEditingController();
  TextEditingController _textEditingControllerFoodPrice =
      new TextEditingController();
  TextEditingController _textEditingControllerFoodQuantity =
      new TextEditingController();
  TextEditingController _textEditingControllerRemainingQuantity =
      new TextEditingController();
  TextEditingController _textEditingControllerFoodCookTime =
      new TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("Foods");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("Add Foods"),
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
                  validator: validFoodName,
                  controller: _textEditingControllerFoodName,
                  decoration: InputDecoration(
                    labelText: 'Food Name',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  validator: validFoodPrice,
                  keyboardType: TextInputType.number,
                  controller: _textEditingControllerFoodPrice,
                  decoration: InputDecoration(
                    labelText: 'Food Price',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  validator: validQuantity,
                  keyboardType: TextInputType.number,
                  controller: _textEditingControllerFoodQuantity,
                  decoration: InputDecoration(
                    labelText: 'Product Quantity',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  validator: validRemainingQuantity,
                  keyboardType: TextInputType.number,
                  controller: _textEditingControllerRemainingQuantity,
                  decoration: InputDecoration(
                    labelText: 'Available Quantity',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  validator: validCookTime,
                  keyboardType: TextInputType.number,
                  controller: _textEditingControllerFoodCookTime,
                  decoration: InputDecoration(
                    labelText: 'Food Cook Time',
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
            .child("Food_Image")
            .child(imageFileName);
        UploadTask uploadTask = storageReference.putFile(imageFile);
        uploadTask.then((TaskSnapshot taskSnapshot) {
          taskSnapshot.ref.getDownloadURL().then((imageURL) {
            String autoID = databaseReference.push().key;
            databaseReference.child(autoID).set({
              'fImageURl': imageURL.toString(),
              'fName': _textEditingControllerFoodName.text.toString().trim(),
              'fPrice': _textEditingControllerFoodPrice.text.toString().trim(),
              'fQuantity':
                  _textEditingControllerFoodQuantity.text.toString().trim(),
              'fCookTime':
                  _textEditingControllerFoodCookTime.text.toString().trim(),
              'fRemainingQuantity': _textEditingControllerRemainingQuantity.text
                  .toString()
                  .trim(),
              'rKey': widget.restaurantID,
              'cKey': widget.categoryID,
              'fKey': autoID.toString().trim(),
              'uID': uid.toString().trim()
            }).then((value) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Food created successfully')));
              print(imageURL.toString());
            });
          });
        }).catchError((error) {
          print(error.toString());
        });
      }
    }
  }

  String? validCookTime(String? cookTime) {
    if (cookTime!.isEmpty) {
      return "Please enter cook time";
    } else {
      return null;
    }
  }

  String? validFoodName(String? foodName) {
    if (foodName!.isEmpty) {
      return "Please enter food name";
    } else {
      return null;
    }
  }

  String? validQuantity(String? foodQuantity) {
    if (foodQuantity!.isEmpty) {
      return "Please enter food quantity";
    } else {
      return null;
    }
  }

  String? validFoodPrice(String? foodPrice) {
    if (foodPrice!.isEmpty) {
      return "Please enter food price";
    } else {
      return null;
    }
  }

  String? validRemainingQuantity(String? remainingQuantity) {
    if (remainingQuantity!.isEmpty) {
      return "Please enter remaining quantity";
    } else {
      return null;
    }
  }
}
