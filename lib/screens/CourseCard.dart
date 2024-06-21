import 'package:flutter/material.dart';
import 'package:home/model/course_model.dart';
import 'package:home/screens/QuizScreen.dart';

class CourseCard extends StatefulWidget {
 final CourseModel course;
  const CourseCard(
      {super.key,
       required this.course,
     });

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  // Manage the visibility of the dropdown
  bool _isDropdownVisible = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            _isDropdownVisible = !_isDropdownVisible;
          });
        },
        child: Column(
          children: [
            ListTile(
              title: Text('${widget.course.courseCode.toString() + "          "} ${widget.course}'),
              trailing: Icon(
                _isDropdownVisible
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down,
              ),
            ),
            if (_isDropdownVisible)
              Column(
                children: [
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.quiz),
                    title: const Text('Quiz'),
                    onTap: () {
                      // Handle Quiz tap
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => QuizScreen(course: widget.course)));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.assignment),
                    title: const Text('Assignment'),
                    onTap: () {
                      // Handle Assignment tap
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Assignment selected')),
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
