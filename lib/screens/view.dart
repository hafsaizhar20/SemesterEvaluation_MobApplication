import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
 import 'package:home/screens/Attendance.dart';
import 'package:home/screens/QuizScreen.dart';
import 'package:home/model/course_model.dart';
import 'package:home/screens/loginSc.dart'; 

  
class viewCourse extends StatefulWidget {
  const viewCourse({super.key});

  @override
  State<viewCourse> createState() => _viewCourseState();
}

class _viewCourseState extends State<viewCourse> {
  bool _isDropdownVisible = false;
  final ref = FirebaseDatabase.instance.ref('Courses');
  List<bool> _dropdownVisibility = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'View Courses',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
        backgroundColor: Colors.indigo.shade900,
      ),
      body: Column(children: [
        Expanded(
          child: StreamBuilder(
            stream: ref.onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: SpinKitChasingDots(
                  color:Colors.lightBlue,
                size:25.0

                ));
              } else {
                Map<dynamic, dynamic> map =
                    snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                List<CourseModel> courses = [];
                map.forEach((key, value) {
                  // Ensure value is Map<String, dynamic>
                  if (value is Map) {
                    Map<String, dynamic> courseData = Map<String, dynamic>.from(value);
                    CourseModel course = CourseModel(map: courseData);
                    if (course.uid == userId) {
                      courses.add(course);
                    }
                  }
                });

                if (_dropdownVisibility.length != courses.length) {
                  _dropdownVisibility = List<bool>.filled(courses.length, false);
                }

                return ListView.builder(
                  
                  shrinkWrap: true,
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    CourseModel course = courses[index];
                    return GestureDetector(
                      onLongPress: () => _deleteCourse(context,course.courseCode??"1",ref),
                      child: Card(
                        
                        elevation: 10,
                        shadowColor: Colors.indigo.shade300,
                        child: Column(
                      
                          children: [
                            ListTile(
                             
                              title: Row(
                                children: [
                                  Text('  ${course.courseCode}'),
                                  Spacer(),
                                  Text(' ${course.courseName}'),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(
                                      _dropdownVisibility[index]
                                          ? Icons.arrow_drop_up
                                          : Icons.arrow_drop_down,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _dropdownVisibility[index] =
                                            !_dropdownVisibility[index];
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            if (_dropdownVisibility[index])
                              Column(
                                children: [
                                  Divider(),
                                  ListTile(
                                    leading: Icon(Icons.quiz),
                                    title: Text('Quiz'),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              QuizScreen(course: course),
                                        ),
                                      );
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.pending_outlined),
                                    title: Text('Attendance'),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Attendance(
                                              course: course),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ]),
    );
  }
}


Future<void> _deleteCourse(BuildContext context, String coursekey , DatabaseReference ref) async {
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
                 Text('Do you want to delete it?'),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.close),
                ),
              ],
            ),
            titleTextStyle: const TextStyle(fontSize: 16, color: Colors.black),
            contentPadding: EdgeInsets.zero,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [ 
                  SizedBox(width: 8,),
                  ElevatedButton(
                    onPressed: () {
                       Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.green),
                      minimumSize:
                      MaterialStateProperty.all(const Size(140.0, 52.0)),
                    ),
                    child: const Text(
                      "No",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 9,),
                  ElevatedButton(
                    onPressed: () {
                       ref.child(coursekey).remove().then((_) {
                      Navigator.of(context).pop();
                    });
                    },
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.green),
                      minimumSize:
                      MaterialStateProperty.all(const Size(140.0, 52.0)),
                    ),
                    child: const Text(
                      "Yes",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 8,),
                ],
              ),
                  SizedBox(height: 20,),
            ]);
      });
}