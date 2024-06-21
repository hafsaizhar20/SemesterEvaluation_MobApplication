
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:home/model/user_model.dart';
import 'package:home/screens/loginSc.dart';
import 'package:home/screens/user_profile.dart';
import 'package:home/screens/view.dart';
import 'package:home/screens/addition.dart';

class sub extends StatefulWidget {
    final UserModel  userData;
    sub({super.key, required    this.userData } );

  @override
  State<sub> createState() => _subState();
}

class _subState extends State<sub> {

     UserModel? user ;
  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() {
    final databaseRef = FirebaseDatabase.instance.ref("users");

    databaseRef.child(userId).once().then((DatabaseEvent event) {
      final userData = Map<String, dynamic>.from(event.snapshot.value as Map);
      setState(() {
        user = UserModel(map: userData);
      });
    }).catchError((error) {
      log("Failed to fetch user data: $error");
    });
  }



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Builder(builder: (context) => IconButton(onPressed: (){
          Scaffold.of(context).openDrawer();
        }, icon: Icon(Icons.list,color: Colors.white,)),),
        title:const  Center(
          child: Text('Dashboard',style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),),
        ),
        backgroundColor: Colors.indigo.shade900,

      ),
      drawer: Drawer(

        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                    color: Colors.indigo.shade900
                ),
                // currentAccountPicture: CircleAvatar(
                //   backgroundImage: NetworkImage(url),
                // ),
                accountName:   Text(user!.name),
                accountEmail:   Text(user!.email)),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Add Course'),
              onTap: (){

                Navigator.push(context, MaterialPageRoute(builder: (context) => addCourse()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.remove_red_eye_outlined),
              title: const Text('View Course'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => viewCourse()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete Course'),
              onTap: (){},
            ),
            ListTile(
              leading: const Icon(Icons.notifications_on),
              title: const Text('Notification'),
              onTap: (){},
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('User Profile'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(userData: user!,)));

              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: (){
                         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => login()), (Route<dynamic> route) =>
              false,);

              },
            )

            // Text(data)
          ],
        ),
      ),


      // body: Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      // TextButton(
      //   onPressed:() {
      //     Navigator.push(context, route)
      //   },
      //   child:const Center(child: Text('Happy learning')) ,
      // )
      // ],

    );

  }
}

