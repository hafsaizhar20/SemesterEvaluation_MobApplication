import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:home/helpers/loader.dart';
import 'package:home/model/user_model.dart';
import 'package:home/screens/loginSc.dart';
import 'package:home/screens/sub.dart';
import 'package:home/utils/utilities.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel userData;

  ProfileScreen({super.key, required this.userData});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Manage Profile'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(height: 30),
              GestureDetector(
                onTap: () async {
                  image = await getImage();
                  if (image != null) {
                    String imageUrl = await uploadImageToFirebase(image!);
                    _updateUserData(context, 'photoUrl', imageUrl);
                  }
                },
             child: CircleAvatar(
  radius: 80,
  child: widget.userData.image.isNotEmpty
      ? ClipOval(
          child: Image.network(
            widget.userData.image,
            width: 160,  
            height: 160,
            fit: BoxFit.cover,
          ),
        )
      : Icon(
          Icons.person,
          size: 80, // Adjust size if needed
        ),
),

              ),
              SizedBox(height: 55),
              buildProfileField(context, "name", widget.userData.name , nameController),
              SizedBox(height: 25),
              buildProfileField(context, "email", widget.userData.email, emailController),
              SizedBox(height: 25),
              buildProfileField(context, "phone", widget.userData.phone, phoneNumberController),
              // SizedBox(height: 25),
              // buildProfileField(context, "Password", userData.password, passwordController),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileField(BuildContext context, String field, String value, TextEditingController controller) {
    controller.text = value;
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xff32CD32), width: 3))),
        width: 390,
        height: 50,
        child: Container(
          color: const Color(0xff32CD32),
          child: Container(
            padding: EdgeInsets.all(10),
            color: Color(0xffdaf7D2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value),
                InkWell(
                  onTap: () {
                    _updateDialog(context, field, controller);
                  },
                  child: Icon(Icons.edit),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateDialog(BuildContext context, String title, TextEditingController controller) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.zero,
          backgroundColor: const Color(0xFFFFFFFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Update Your $title'),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.close),
              ),
            ],
          ),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "Enter new $title",
            ),
          ),
          titleTextStyle: const TextStyle(fontSize: 16, color: Colors.black),
          contentPadding: EdgeInsets.all(10),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  _updateUserData(context, title, controller.text);
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  minimumSize: MaterialStateProperty.all(const Size(140.0, 52.0)),
                ),
                child: const Text(
                  "Update",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
 

  void _updateUserData(BuildContext context, String field, String newValue) {
    showLoader(context);
    final ref = FirebaseDatabase.instance.ref('users/$userId');
    ref.update({
      field.toLowerCase(): newValue,
    }).then((_) {
      hideLoader(context);
      utilities().toastMessages("Data updated successfully!");
 
 Navigator.pop(context);
 Navigator.pop(context);
      //  Navigator.of(context).pushAndRemoveUntil(
      //   MaterialPageRoute(builder: (context) => sub(userData: widget.userData,)),
      //   (Route<dynamic> route) => false,
      // );
    }).catchError((error) {
      hideLoader(context);
      utilities().toastMessages("Failed to update data: $error");
    });
  }

  Future<File?> getImage() async {
    final picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      log('Picked file path: ${pickedFile.path}');
      return File(pickedFile.path);
    } else {
      print('Image picking canceled or failed.');
      return null;
    }
  }

  Future<String> uploadImageToFirebase(File imageFile) async {
    String fileName = 'profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg';
    Reference storageRef = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageRef.putFile(imageFile);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
