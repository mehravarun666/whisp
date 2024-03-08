import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../main.dart';

class SignInScreen extends StatefulWidget {
  final VoidCallback login;

  SignInScreen({Key? key, required this.login}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController checkPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  File? _image;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    checkPasswordController.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      CroppedFile? croppedImage = await _cropImage(File(pickedImage.path));
      if (croppedImage != null) {
        setState(() {
          _image = File(croppedImage.path!); // Convert CroppedFile to File
        });
      }
    } else {
      print('No image selected.');
    }
  }

  Future<CroppedFile?> _cropImage(File imageFile) async {
    final cropper = ImageCropper();
    CroppedFile? croppedFile = await cropper.cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.grey,
            toolbarWidgetColor: Colors.black54,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );

    return croppedFile;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFDFA),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Center(
                  child: GestureDetector(
                    onTap: _getImageFromGallery,
                    child: ClipOval(
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black, // You can set the color of the circular boundary here
                            width: 2.0, // You can adjust the width of the circular boundary here
                          ),
                        ),
                        child: _image != null
                            ? Image.file(
                          _image!,
                          fit: BoxFit.cover, // Ensures the image fills the circular container without distortion
                        )
                            : Image.asset(
                          'assets/Images/user.png',
                          fit: BoxFit.cover, // Ensures the placeholder image fills the circular container without distortion
                        ),
                      ),
                    ),
                  ),


                ),
              ),

              SizedBox(height: 10,),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (name) =>
                  name != null && name.isEmpty ? 'Enter your name' : null,
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'Name',
                    hintText: 'Enter your name',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (phoneNumber) {
                    if (phoneNumber != null &&
                        phoneNumber.length != 10 &&
                        !phoneNumber.startsWith('+91')) {
                      return 'Enter a valid Indian phone number';
                    }
                    return null;
                  },
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(12),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'Phone Number',
                    hintText: '+91 XXXXXXXXXX',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) => email != null &&
                      !RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(email)
                      ? 'Enter a valid email'
                      : null,
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'Email',
                    hintText: 'Enter email id as abc@gmail.com',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value != null && value.length < 6
                      ? 'Password must contain more than 6 characters'
                      : null,
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'Password',
                    hintText: 'Enter secure password',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value != null &&
                      passwordController.text != checkPasswordController.text
                      ? 'Passwords do not match'
                      : null,
                  controller: checkPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'Confirm Password',
                    hintText: 'Re-enter password',
                  ),
                ),
              ),
              SizedBox(
                height: 65,
                width: 360,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      onPressed: (){
                        signUp;
                        sendDataToFirestore(nameController.text, phoneNumberController.text, _image!);
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 62),
                        child: Container(height: 40, child: Text("Already have an account ?")),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: InkWell(
                          onTap: () {
                            widget.login();
                            print('tapped on signin screen');
                          },
                          child: Container(
                            height: 40,
                            width: 50,
                            child: Text('Log in', style: TextStyle(fontSize: 14, color: Colors.blue)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signUp() async {

    final isValid = formKey.currentState!.validate();
    if(!isValid) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'An error occurred during sign up.'),
        ),
      );
    } finally {
      Navigator.of(context).pop();
    }
  }


  void sendDataToFirestore(String name, String phoneNumber, File imageFile) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    String imageUrl = await uploadImageToFirebaseStorage(imageFile);
    users.add({
      'name': name,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
    })
        .then((value) {
      print("Data added successfully");
    })
        .catchError((error) {
      print("Failed to add data: $error");
    });
  }

  Future<String> uploadImageToFirebaseStorage(File imageFile) async {
    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('profileImage')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

      await ref.putFile(imageFile);

      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print("Failed to upload image to Firebase Storage: $e");
      return '';
    }
  }

}

