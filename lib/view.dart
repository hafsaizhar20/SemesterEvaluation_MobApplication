import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:home/CourseCard.dart';
import 'package:home/QuizScreen.dart';
import 'package:home/Attendance.dart';
import 'package:home/add_quiz.dart';
class viewCourse extends StatefulWidget {
  const viewCourse({super.key});

  @override
  State<viewCourse> createState() => _viewCourseState();
}

class _viewCourseState extends State<viewCourse> {
  bool _isDropdownVisible = false;
   // final String uniqueKey;
  final ref = FirebaseDatabase.instance.ref('Courses');
  final List<String> courses =
      List<String>.generate(10, (index) => 'Course $index');
  List<bool> _dropdownVisibility = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.indigo.shade900,
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
              return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircularProgressIndicator()]);
            } else {
    Map<dynamic, dynamic> map =
    snapshot.data!.snapshot.value as dynamic;
    List<dynamic> list = [];
    list.clear();
    list = map.values.toList();
    if (_dropdownVisibility.length != list.length) {
      _dropdownVisibility = List<bool>.filled(list.length, false);
    }
    return ListView.builder(

    shrinkWrap: true,
    itemCount: snapshot.data!.snapshot.children.length,
    itemBuilder: (context, index) {
    String courseCode = list[index]['courseCode'].toString();
    String courseName = list[index]['courseName'].toString();
    return Card(
    elevation: 10,
    shadowColor: Colors.indigo.shade300,
    child: Column(
    children: [
    ListTile(
    title: Row(
    children: [
    Text('  $courseCode'),
    Spacer(),
    Text(' $courseName'),
    Spacer(),
    IconButton(
    icon: Icon(  _dropdownVisibility[index]
        ? Icons.arrow_drop_up
        : Icons.arrow_drop_down,),
        // _isDropdownVisible ? Icons.arrow_drop_up : Icons.arrow_drop_down),
    onPressed: () {

    setState(() {
    // _isDropdownVisible = !_isDropdownVisible;
      _dropdownVisibility[index] =
      !_dropdownVisibility[index];
    }
    );
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
    // Handle Quiz tap
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuizScreen()));
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  QuizScreen(courseCode: courseCode ) ));  //QuizScreen()
    },
    ),
    ListTile(
    leading: Icon(Icons.pending_outlined),
    title: Text('Attendance'),
    onTap: () {
    // Handle Assignment tap
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  Attendance(courseCode: courseCode,)));
    // ScaffoldMessenger.of(context).showSnackBar(
    // SnackBar(content: Text('Assignment selected')),
    // );
    },
    ),
    ],
    ),
    ],
    ),
    );
    }
    );
    };
            }
    )

    )
    ]
    ),
    );
          }
    }

    //               return Card(
    //                 elevation: 10,
    //                 shadowColor: Colors.indigo.shade300,
    //
    //                 child: ListTile(
    //
    //                   trailing: Icon(
    //                     _isDropdownVisible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
    //                   ),
    //
    //
    //                   if (_isDropdownVisible)
    //                   Column(
    //                   children: [
    //                   const Divider(),
    //               ListTile(
    //
    //               leading: const Icon(Icons.quiz),
    //               title: const Text('Quiz'),
    //               onTap: () {
    //               // Handle Quiz tap
    //               Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuizScreen()));
    //
    //
    //               },
    //               ),
    //               ListTile(
    //               leading: const Icon(Icons.assignment),
    //               title: const Text('Assignment'),
    //               onTap: () {
    //               // Handle Assignment tap
    //               ScaffoldMessenger.of(context).showSnackBar(
    //               const SnackBar(content: Text('Assignment selected')),
    //               );
    //               },
    //               ),
    //               ],
    //               ),
    //
    //
    //
    //                   title: Container(
    //                                     height: 50,
    //                                       width: 300,
    //
    //                                       child: Row(
    //                                           children: [
    //                                       Text('  $courseCode'),
    //                                                   SizedBox(
    //                                   width: 50,
    //                                                   ),
    //                                       Center(child: Text(' $courseName')),
    //                                           SizedBox(
    //                                             width:70,
    //                                           ),
    //
    //               ]
    //               )
    //               ),
    //               ),
    //               );
    //
    //             },
    //           );
    //         }
    //       },
    //     )),
    //   ]),
    // );

    // return  CourseCard(courseid: courseCode, course: courseName);
    // FirebaseAnimatedList(query: ref,
    //     itemBuilder: (context, snapshot, animation, index ){
    // List<Widget> courseWidgets = [];
    // for (DataSnapshot childSnapshot in snapshot.children) {
    // String courseCode = snapshot.child('courseCode').value.toString();
    // String courseName = snapshot.child('courseName').value.toString();
    // courseWidgets.add(Text('$courseCode: $courseName'));
    // }
    //         return  ListTile(
    //           title:  Card(
    //               elevation: 10,
    //               shadowColor: Colors.indigo.shade300,
    //
    //               child: Stack(
    //                 children:[ Container(
    //                   height: 50,
    //                     width: 300,
    //
    //                     child: Row(
    //                         children: [
    //                     Text('  $courseCode'),
    //                                 SizedBox(
    //                 width: 70,
    //                                 ),
    //                     Center(child: Text(' $courseName')),
    //                         SizedBox(
    //                           width:90,
    //                         ),
    //

    // Icon(Icons.arrow_drop_down)

    // ])),

    // title: Text(snapshot.child('courseCode').value.toString())
    // title: Row(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: courseWidgets,
    // ),
    //
    //           );
    //           }
    //       )
    //       ),
    //     ],
    //   ),
    // );


