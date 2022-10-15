import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/progress_dialog.dart';
import 'package:image_picker/image_picker.dart';

class AddCategoriesScreen extends StatefulWidget {
  final String restaurantID;
  AddCategoriesScreen({Key? key, required this.restaurantID}) : super(key: key);

  @override
  _AddCategoriesScreenState createState() => _AddCategoriesScreenState();
}

class _AddCategoriesScreenState extends State<AddCategoriesScreen> {
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
  TextEditingController _textEditingControllerCategoriesName =
      new TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("Category");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Categories"),
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
                  controller: _textEditingControllerCategoriesName,
                  validator: validCategoriestName,
                  decoration: InputDecoration(
                    labelText: 'Category Name',
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
            .child("Category_Image")
            .child(imageFileName);
        UploadTask uploadTask = storageReference.putFile(imageFile);
        uploadTask.then((TaskSnapshot taskSnapshot) {
          taskSnapshot.ref.getDownloadURL().then((imageURL) {
            String autoID = databaseReference.push().key;
            databaseReference.child(autoID).set({
              'cImageURl': imageURL.toString(),
              'cName':
                  _textEditingControllerCategoriesName.text.toString().trim(),
              'rKey': widget.restaurantID,
              'cKey': autoID.toString().trim(),
              'uID': uid.toString().trim()
            }).then((value) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Category created successfully')));
              print(imageURL.toString());
            });
          });
        }).catchError((error) {
          print(error.toString());
        });
      }
    }
  }

  String? validCategoriestName(String? name) {
    if (name!.isEmpty) {
      return "Please enter category name";
    } else {
      return null;
    }
  }
}
