
import 'package:flutter/material.dart';
import 'package:home/view.dart';
import 'package:home/addition.dart';

class sub extends StatefulWidget {
  const sub({super.key});

  @override
  State<sub> createState() => _subState();
}

class _subState extends State<sub> {
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
                accountName: const Text('Nawaira Sajjad'),
                accountEmail: const Text('nawairasajjad97@gmail.com')),
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
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: (){},
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

