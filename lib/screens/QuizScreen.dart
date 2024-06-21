import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:home/model/course_model.dart';
import 'package:home/screens/add_quiz.dart';

class QuizScreen extends StatefulWidget {
  final CourseModel course;

  const QuizScreen({super.key, required this.course});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref('Courses/${widget.course.courseCode}/quizzes');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Quiz'),
      ),
      body: Column(children: [
        Expanded(
          child: StreamBuilder(
            stream: ref.onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: SpinKitChasingDots(
                  color: Colors.lightBlue,
                  size: 50,

                ));
              } else if (snapshot.data!.snapshot.value == null) {
                return Center(child: Text('No quizzes available'));
              } else {
              Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

                // Convert map to a list of QuizModel
                List<QuizModel> quizzes = map.entries.map((entry) {
                  return QuizModel(map: Map<String, dynamic>.from(entry.value), key: entry.key);
                }).toList();

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: quizzes.length,
                  itemBuilder: (context, index) {
                    QuizModel quiz = quizzes[index];
                    return GestureDetector(
                      onLongPress: () => _deleteQuiz(context,
                      quiz.key,ref),
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.indigo.shade300,
                        child: ListTile(
                          title: Row(
                            children: [
                              Text(
                                '  ${quiz.topic}',
                                style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 20,
                                ),
                              ),
                              Spacer(),
                              Text(' ${quiz.date}'),
                            ],
                          ),
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
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddQuiz(courseCode: widget.course.courseCode ?? ""),
            ),
          );
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
                  SizedBox(width: 20),
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


Future<void> _deleteQuiz(BuildContext context, String 
quizKey , DatabaseReference ref ) async {
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
                       ref.child(quizKey).remove().then((_) {
                    Navigator.of(context).pop();
                  });
                      Navigator.of(context).pop();
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
              SizedBox(height: 20,)
            ]);
      });
}
