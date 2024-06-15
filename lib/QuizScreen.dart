import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
 // import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home/add_quiz.dart';

class QuizScreen extends StatefulWidget {
  final String courseCode;

  const QuizScreen({super.key,required this.courseCode});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {



  //
  // final List<String> _quizItems = [
  // 'Question 1',
  // 'Question 2',
  // 'Question 3',
  // 'Question 4',
  // ];
  // //
  // // // Variable to store the selected radio button index
  //  int? _selectedRadioIndex;
  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref('Courses/${widget.courseCode}/quizzes');
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Quiz'),
      ),
      body:
      // Center(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       Expanded(
      //
      //         child: ListView.builder(
      //           shrinkWrap: true,
      //           itemCount: _quizItems.length,
      //           itemBuilder: (context, index) {
      //             return Card(
      //               margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      //               child: ListTile(
      //                 leading: Radio<int>(
      //                   activeColor: Colors.black,
      //                   value: index,
      //
      //                   groupValue: _selectedRadioIndex,
      //                   onChanged: (int? value) {
      //                     setState(() {
      //                       _selectedRadioIndex = value;
      //                     });
      //                     _deleteQuiz(context, );
      //
      //                   },
      //                 ),
      //
      //
      //                 title: Text(_quizItems[index], style: TextStyle(fontSize: 18)),
      //               ),
      //             );
      //           },
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    Column(children: [
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

        return ListView.builder(

            shrinkWrap: true,
            itemCount: snapshot.data!.snapshot.children.length,
            itemBuilder: (context, index) {
              String topic = list[index]['topic'].toString();
              String date = list[index]['date'].toString();
              return Card(
                  elevation: 10,
                  shadowColor: Colors.indigo.shade300,
                  child: Column(
                      children: [
                        ListTile(
                            title: Row(
                                children: [
                                  Text('  $topic',style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 20
                                  ),
                                    ),
                                  Spacer(),
                                  Text(' $date'),
                                ]))
                      ])
              );
            }
        );
      }
    }
    )
    )
    ]),
      bottomNavigationBar: InkWell(
        onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddQuiz()));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddQuiz(courseCode: widget.courseCode)));  //AddQuiz()
          // Add your onTap logic here
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Container(
            height: 55,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(23),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_box, color: Colors.white),
                  SizedBox(
                    width: 20,
                  ),

                  Text(
                    "Add Quiz",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}






Future<void> _deleteQuiz(BuildContext context ) async {
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
                SizedBox(
                  height: 2,
                ),
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
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.green),
                      minimumSize:
                      MaterialStateProperty.all(const Size(100.0, 40.0)),
                    ),
                    child: const Text(
                      "No",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 9,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.green),
                      minimumSize:
                      MaterialStateProperty.all(const Size(100.0, 40.0)),
                    ),
                    child: const Text(
                      "Yes",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
             SizedBox(
               height: 20,
             ),
            ]);
      });
}

