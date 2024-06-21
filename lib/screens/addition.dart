import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:home/helpers/loader.dart';
import 'package:home/screens/loginSc.dart';
import 'package:home/screens/sub.dart';
import 'package:home/utils/utilities.dart';

class addCourse extends StatelessWidget {
  addCourse({super.key});
  final courseCode = TextEditingController();
  final courseName = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref("Courses");
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigo.shade900,
            leading: IconButton(
                onPressed: () {

Navigator.pop(context);                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (context) => sub()));
                },
                icon: const Icon(
                  Icons.backspace_rounded,
                  color: Colors.white,
                )),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: SafeArea(
                child: Form(
                  key: _formKey,
                  child: Column(
                                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Text(
                            'Add Courses here!',
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.lightGreen.shade400,
                                fontFamily: 'Pacifico'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                          controller: courseCode,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Course code';
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Course code',
                              fillColor: Color(0xff323F4B),
                              filled: false,
                              prefixIcon: Icon(
                                Icons.numbers,
                                color: Color(0xff323F4B),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xffE4E7EB)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              )))),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: courseName,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Course ';
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Course name',
                              fillColor: Colors.lightGreen,
                              filled: false,
                              prefixIcon: Icon(
                                Icons.book,
                                color: Color(0xff323F4B),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              )))),
                  SizedBox(
                    height: 100,
                  ),
                  InkWell( onTap: () {

                    if (_formKey.currentState!.validate()) {
                      showLoader(context);

                    // / Generate a unique key using the current timestamp in milliseconds
                    // final String uniqueKey = DateTime.now().millisecondsSinceEpoch.toString();

                    // Add the course to the database
                   //  databaseRef.child(uniqueKey).set({
                    //'courseCode': courseCode.text.toString(),
                    //'courseName': courseName.text.toString(),
                    //}

                      databaseRef.child(courseCode.text.toString()).set({
                        'courseCode': courseCode.text.toString(),
                        'courseName': courseName.text.toString(),
                        'uid': userId.toString(),

                      }
                      ).then((value){
                        hideLoader(context);
                        utilities().toastMessages('Course added successfully');
                      }).onError((error, stackTrace) {
                        hideLoader(context);

                        utilities().toastMessages(error.toString());
                      }
                      );
                    }
                  },

                    child: Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                          color: Colors.indigo.shade900,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                          child: Text(
                        'Add',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Pacifico',
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                                ],
                              ),
                )),
          ),
        ));
  }
}
