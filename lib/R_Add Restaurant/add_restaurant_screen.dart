import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/progress_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Add_Restaurant_Screen extends StatefulWidget {
  const Add_Restaurant_Screen({Key? key}) : super(key: key);

  @override
  _Add_Restaurant_ScreenState createState() => _Add_Restaurant_ScreenState();
}

class _Add_Restaurant_ScreenState extends State<Add_Restaurant_Screen> {
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
  TextEditingController _textEditingControllerRestaurantName =
      new TextEditingController();
  TextEditingController _textEditingControllerDescription =
      new TextEditingController();
  TextEditingController _textEditingControllerAddress =
      new TextEditingController();
  TextEditingController _textEditingControllerPhoneNumber =
      new TextEditingController();
  TextEditingController _textEditingControllerOpenCloseTime =
      new TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("Restaurant");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Restaurant"),
        brightness: Brightness.dark,
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
                  controller: _textEditingControllerRestaurantName,
                  validator: validRestaurantName,
                  decoration: InputDecoration(
                    labelText: 'Restaurant Name',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  controller: _textEditingControllerDescription,
                  validator: validDescription,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  controller: _textEditingControllerAddress,
                  validator: validAddress,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.phone,
                  controller: _textEditingControllerPhoneNumber,
                  validator: validPhoneNumber,
                  decoration: InputDecoration(
                    labelText: 'Contact number',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  controller: _textEditingControllerOpenCloseTime,
                  validator: validTime,
                  decoration: InputDecoration(
                    labelText: 'Opening and closing time',
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
       /// Reference storageReference = FirebaseStorage.instance.ref().child("Restaurant_Image").child(imageFileName);
        final storageRef = FirebaseStorage.instance.ref();
        final mountainsRef = storageRef.child("Restaurant_Image").child(imageFileName);
        ///UploadTask uploadTask = storageReference.putFile(imageFile);
        UploadTask uploadTask = mountainsRef.putFile(imageFile);
        uploadTask.then((TaskSnapshot taskSnapshot) {
          taskSnapshot.ref.getDownloadURL().then((imageURL) {
            
            String autoID = databaseReference.push().key;
            databaseReference.child(autoID).set({
              'rImageURl': imageURL.toString(),
              'rName': _textEditingControllerRestaurantName.text.toString().trim(),
              'rDes': _textEditingControllerDescription.text.toString().trim(),
              'rAddress': _textEditingControllerAddress.text.toString().trim(),
              'rPhoneNo': _textEditingControllerPhoneNumber.text.toString().trim(),
              'rOpenCloseTime': _textEditingControllerOpenCloseTime.text.toString().trim(),
              'rKey': autoID.toString().trim(),
              'uID': uid.toString().trim()
            }).then((value) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Restaurant created successfully')));
              print(imageURL.toString());
            });
          });
        }).catchError((error) {
          print(error.toString());
        });
      }
    }
  }

  String? validRestaurantName(String? name) {
    if (name!.isEmpty) {
      return "Please enter restaurant name";
    } else {
      return null;
    }
  }

  String? validDescription(String? des) {
    if (des!.isEmpty) {
      return "Please enter description";
    } else {
      return null;
    }
  }

  String? validAddress(String? address) {
    if (address!.isEmpty) {
      return "Please enter address";
    } else {
      return null;
    }
  }

  String? validPhoneNumber(String? number) {
    if (number!.isEmpty) {
      return "Please enter phone number";
    } else {
      return null;
    }
  }

  String? validTime(String? time) {
    if (time!.isEmpty) {
      return "Please enter opening and closing time";
    } else {
      return null;
    }
  }
}
