// import 'package:flutter/material.dart';
//  import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:home/widgets.dart';
// import 'package:home/calender.dart';
//
//
//
// class AddQuiz extends StatelessWidget {
//   const AddQuiz({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(360, 690),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       child: const MaterialApp(
//         home: AddQuiz(),
//       ),
//     );
//   }
// }
//   @override
//   Widget build(BuildContext context) {
//
//     return  Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Add Quiz'),
//       ),
//       body: Center(
//           child: Column(
//             children: [
//               LargeTextField(HintText: "Enter Your Quiz Title....",height: 40.0,),
//               SizedBox(
//                 height: 5,
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(
//                     vertical: 10, horizontal: 17
//                 ),
//                 child: CalendarWidget(dateController: controller1),
//               )
//
//
//             ],
//           )
//       ),
//       bottomNavigationBar: InkWell(
//         onTap: () {
//
//           // Add your onTap logic here
//         },
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//           child: Container(
//             height: 40,
//             width: 300,
//             decoration: BoxDecoration(
//               color: Colors.blue,
//               borderRadius: BorderRadius.circular(23),
//             ),
//             child: Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.check_sharp, color: Colors.white),
//                 SizedBox(
//                   width: 5,
//                 ),
//                   Text(
//                     "Done",
//                     style: TextStyle(fontSize: 22, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//
//
//
//
//     );
//
//   }
//
// TextEditingController controller1 =TextEditingController();
//   import 'package:flutter/material.dart';
//   import 'package:flutter_screenutil/flutter_screenutil.dart';
//   // import 'package:experiment/text_field.dart';
//   // import 'package:experiment/calender.dart';
//
//
//   class AddQuiz extends StatelessWidget {
//     const AddQuiz({super.key});
//
//     @override
//     Widget build(BuildContext context) {
//       return ScreenUtilInit(
//         designSize: const Size(360, 690),
//         minTextAdapt: true,
//         splitScreenMode: true,
//         child: const MaterialApp(
//           home: AddQuiz(),
//         ),
//       );
//     }
//   }
//
//
//     @override
//     Widget build(BuildContext context) {
//       // ScreenUtil.init is now handled by ScreenUtilInit in MyApp, so no need to call it here
//
//       return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: const Text('Add Quiz'),
//         ),
//         body: Center(
//           child: Column(
//             children: [
//               LargeTextField(HintText: "Enter Your Quiz Title....", height: 50.0.h),
//               10.verticalSpace,
//               Container(
//                 padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 17),
//                 child: CalendarWidget(dateController: controller1),
//               ),
//             ],
//           ),
//         ),
//         bottomNavigationBar: InkWell(
//           onTap: () {
//             // Add your onTap logic here
//           },
//           child: Padding(
//             padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
//             child: Container(
//               height: 55.h,
//               width: 300.w,
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 borderRadius: BorderRadius.circular(23),
//               ),
//               child: Center(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(Icons.check_sharp, color: Colors.white),
//                     10.horizontalSpace,
//                     Text(
//                       "Done",
//                       style: TextStyle(fontSize: 22.sp, color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     }
//
//   TextEditingController controller1 = TextEditingController();
//
//   class CalendarWidget extends StatefulWidget {
//     final TextEditingController dateController;
//
//     const CalendarWidget({Key? key, required this.dateController}) : super(key: key);
//
//     @override
//     _CalendarWidgetState createState() => _CalendarWidgetState();
//   }
//
//   class _CalendarWidgetState extends State<CalendarWidget> {
//     DateTime selectedDate = DateTime.now();
//     late FixedExtentScrollController monthController;
//     late FixedExtentScrollController yearController;
//     bool hasSelectedDate = false;
//
//     @override
//     void initState() {
//       super.initState();
//       widget.dateController.text = 'Select Date of Quiz'; // Initial hint text
//       monthController = FixedExtentScrollController(initialItem: selectedDate.month - 1);
//       yearController = FixedExtentScrollController(
//         initialItem: _getYears().indexOf(selectedDate.year.toString()),
//       );
//     }
//
//     void updateDateText() {
//       final day = selectedDate.day;
//       final month = _getMonths()[selectedDate.month - 1];
//       final year = selectedDate.year;
//       widget.dateController.text = "$day $month $year";
//       hasSelectedDate = true;
//     }
//
//     @override
//     Widget build(BuildContext context) {
//       return TextField(
//         controller: widget.dateController,
//         readOnly: true,
//         decoration: InputDecoration(
//           filled: true, // Enable filling
//           fillColor: Colors.grey[200], // Grey background color
//           labelStyle: TextStyle(
//             fontSize: 16.sp,
//             color: Colors.black,
//           ),
//           border: OutlineInputBorder(
//             // Rectangle border
//             borderSide: BorderSide.none, // Remove the border
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//         ),
//         onTap: _pickDate,
//       );
//     }
//
//     Future<void> _pickDate() async {
//       final DateTime? picked = await showDatePicker(
//         context: context,
//         initialDate: selectedDate,
//         firstDate: DateTime(1900),
//         lastDate: DateTime.now().add(const Duration(days: 365 * 10)), // Allow selection of dates up to 10 years in the future
//       );
//
//       if (picked != null && picked != selectedDate) {
//         setState(() {
//           selectedDate = picked;
//           monthController = FixedExtentScrollController(initialItem: selectedDate.month - 1);
//           yearController = FixedExtentScrollController(
//             initialItem: _getYears().indexOf(selectedDate.year.toString()),
//           );
//           updateDateText();
//         });
//       }
//     }
//
//     List<String> _getMonths() {
//       return [
//         "January",
//         "February",
//         "March",
//         "April",
//         "May",
//         "June",
//         "July",
//         "August",
//         "September",
//         "October",
//         "November",
//         "December",
//       ];
//     }
//
//     List<String> _getYears() {
//       List<String> years = [];
//       int currentYear = DateTime.now().year;
//       for (int i = currentYear + 10; i >= 1900; i--) {
//         years.add(i.toString());
//       }
//       return years;
//     }
//
//     @override
//     void dispose() {
//       widget.dateController.dispose();
//       monthController.dispose();
//       yearController.dispose();
//       super.dispose();
//     }
//   }
//
//   class LargeTextField extends StatelessWidget {
//     final double height;
//     final String HintText;
//
//     const LargeTextField({super.key, required this.HintText, required this.height});
//
//     @override
//     Widget build(BuildContext context) {
//       return ClipRRect(
//         borderRadius: BorderRadius.circular(12),
//         child: Container(
//           decoration: const BoxDecoration(
//             border: Border(
//               bottom: BorderSide(color: Color(0xff32CD32), width: 3),
//             ),
//           ),
//           width: 300.h,
//           height: height,
//           child: Container(
//             color: const Color(0xff32CD32),
//             child: TextFormField(
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontSize: 14.0,
//                 fontWeight: FontWeight.normal,
//               ),
//               decoration: InputDecoration(
//                 contentPadding: const EdgeInsets.symmetric(
//                   vertical: 8.0,
//                   horizontal: 16.0,
//                 ),
//                 labelStyle: const TextStyle(
//                   color: Color(0xff674FA3),
//                   fontSize: 14.0,
//                   fontWeight: FontWeight.normal,
//                 ),
//                 hintText: HintText,
//                 hintStyle: const TextStyle(
//                   color: Color(0XFFBF95A6),
//                   fontSize: 14,
//                   fontWeight: FontWeight.normal,
//                 ),
//                 filled: true,
//                 fillColor: const Color(0xffdaf7D2), // Background color
//                 border: const OutlineInputBorder(
//                   borderSide: BorderSide(width: 1, color: Color(0xffFFE5F0)),
//                 ),
//                 enabledBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(width: 1, color: Color(0xffFFE5F0)),
//                 ),
//                 focusedBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(
//                     width: 1,
//                     color: Color(0xffFFE5F0),
//                   ),
//                 ),
//               ),
//               maxLines: 4,
//             ),
//           ),
//         ),
//       );
//     }
//   }
//   import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
//   import 'package:flutter_screenutil/flutter_screenutil.dart';
//
//   class AddQuiz extends StatelessWidget {
//     final String courseCode;
//     AddQuiz({super.key, required this.courseCode});
//
//     @override
//     Widget build(BuildContext context) {
//
//       return ScreenUtilInit(
//         designSize: const Size(360, 690),
//         minTextAdapt: true,
//         splitScreenMode: true,
//         child: MaterialApp(
//           home: AddQuiz(courseCode: courseCode),
//         ),
//       );
//     }
//   }
//
//   class AddQuizScreen extends StatelessWidget {
//     final TextEditingController topicController = TextEditingController();
//     final TextEditingController dateController = TextEditingController();
//      final TextEditingController controller1 = TextEditingController();
//     AddQuiz({super.key, required this.courseCode});
//     @override
//     Widget build(BuildContext context) {
//       DatabaseReference quizzesRef = FirebaseDatabase.instance.ref('Courses/$courseCode/quizzes');
//       return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: const Text('Add Quiz'),
//         ),
//         body: Center(
//           child: Column(
//             children: [
//               LargeTextField(
//                 hintText: "Enter Your Quiz Title....",
//                 height: 50.0.h,
//
//               ),
//               10.verticalSpace,
//               Container(
//                 padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 17),
//                 child: CalendarWidget(dateController: controller1),
//               ),
//             ],
//           ),
//         ),
//         bottomNavigationBar: InkWell(
//           onTap: () {
//             // Add your onTap logic here
//             quizzesRef.push().set({
//               'topic': topicController.text,
//               'date': dateController.text,
//             }).then((_) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Quiz added successfully')),
//               );
//               Navigator.pop(context); // Navigate back to the previous screen
//             }).catchError((error) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Failed to add quiz: $error')),
//               );
//             });
//             },
//           child: Padding(
//             padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
//             child: Container(
//               height: 55.h,
//               width: 300.w,
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 borderRadius: BorderRadius.circular(23),
//               ),
//               child: Center(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(Icons.check_sharp, color: Colors.white),
//                     10.horizontalSpace,
//                     Text(
//                       "Done",
//                       style: TextStyle(fontSize: 22.sp, color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     }
//   }
//
//   class CalendarWidget extends StatefulWidget {
//     final TextEditingController dateController;
//
//     const CalendarWidget({Key? key, required this.dateController}) : super(key: key);
//
//     @override
//     _CalendarWidgetState createState() => _CalendarWidgetState();
//   }
//
//   class _CalendarWidgetState extends State<CalendarWidget> {
//     DateTime selectedDate = DateTime.now();
//     late FixedExtentScrollController monthController;
//     late FixedExtentScrollController yearController;
//     bool hasSelectedDate = false;
//
//     @override
//     void initState() {
//       super.initState();
//       widget.dateController.text = 'Select Date of Quiz';
//       monthController = FixedExtentScrollController(initialItem: selectedDate.month - 1);
//       yearController = FixedExtentScrollController(
//         initialItem: _getYears().indexOf(selectedDate.year.toString()),
//       );
//     }
//
//     void updateDateText() {
//       final day = selectedDate.day;
//       final month = _getMonths()[selectedDate.month - 1];
//       final year = selectedDate.year;
//       widget.dateController.text = "$day $month $year";
//       hasSelectedDate = true;
//     }
//
//     @override
//     Widget build(BuildContext context) {
//       return TextField(
//         controller: widget.dateController,
//         readOnly: true,
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Colors.grey[200],
//           labelStyle: TextStyle(
//             fontSize: 16.sp,
//             color: Colors.black,
//           ),
//           border: OutlineInputBorder(
//             borderSide: BorderSide.none,
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//         ),
//         onTap: _pickDate,
//       );
//     }
//
//     Future<void> _pickDate() async {
//       final DateTime? picked = await showDatePicker(
//         context: context,
//         initialDate: selectedDate,
//         firstDate: DateTime(1900),
//         lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
//       );
//
//       if (picked != null && picked != selectedDate) {
//         setState(() {
//           selectedDate = picked;
//           monthController = FixedExtentScrollController(initialItem: selectedDate.month - 1);
//           yearController = FixedExtentScrollController(
//             initialItem: _getYears().indexOf(selectedDate.year.toString()),
//           );
//           updateDateText();
//         });
//       }
//     }
//
//     List<String> _getMonths() {
//       return [
//         "January",
//         "February",
//         "March",
//         "April",
//         "May",
//         "June",
//         "July",
//         "August",
//         "September",
//         "October",
//         "November",
//         "December",
//       ];
//     }
//
//     List<String> _getYears() {
//       List<String> years = [];
//       int currentYear = DateTime.now().year;
//       for (int i = currentYear + 10; i >= 1900; i--) {
//         years.add(i.toString());
//       }
//       return years;
//     }
//
//     @override
//     void dispose() {
//       widget.dateController.dispose();
//       monthController.dispose();
//       yearController.dispose();
//       super.dispose();
//     }
//   }
//
//   class LargeTextField extends StatelessWidget {
//     final double height;
//     final String hintText;
//     final topicController = TextEditingController();
//     LargeTextField({super.key, required this.hintText, required this.height});
//
//     @override
//     Widget build(BuildContext context) {
//       return ClipRRect(
//         borderRadius: BorderRadius.circular(12),
//         child: Container(
//           decoration: const BoxDecoration(
//             border: Border(
//               bottom: BorderSide(color: Color(0xff32CD32), width: 3),
//             ),
//           ),
//           width: 300.h,
//           height: height,
//           child: Container(
//             color: const Color(0xff32CD32),
//             child: TextFormField(
//               controller: topicController,
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontSize: 14.0,
//                 fontWeight: FontWeight.normal,
//               ),
//               decoration: InputDecoration(
//                 contentPadding: const EdgeInsets.symmetric(
//                   vertical: 8.0,
//                   horizontal: 16.0,
//                 ),
//                 labelStyle: const TextStyle(
//                   color: Color(0xff674FA3),
//                   fontSize: 14.0,
//                   fontWeight: FontWeight.normal,
//                 ),
//                 hintText: hintText,
//                 hintStyle: const TextStyle(
//                   color: Color(0XFFBF95A6),
//                   fontSize: 14,
//                   fontWeight: FontWeight.normal,
//                 ),
//                 filled: true,
//                 fillColor: const Color(0xffdaf7D2),
//                 border: const OutlineInputBorder(
//                   borderSide: BorderSide(width: 1, color: Color(0xffFFE5F0)),
//                 ),
//                 enabledBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(width: 1, color: Color(0xffFFE5F0)),
//                 ),
//                 focusedBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(
//                     width: 1,
//                     color: Color(0xffFFE5F0),
//                   ),
//                 ),
//               ),
//               maxLines: 4,
//             ),
//           ),
//         ),
//       );
//     }
//   }
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddQuiz extends StatelessWidget {
  final String courseCode;
  const AddQuiz({super.key, required this.courseCode});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AddQuizScreen(courseCode: courseCode),
      ),
    );
  }
}

class AddQuizScreen extends StatelessWidget {
  final String courseCode;

  final TextEditingController topicController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  AddQuizScreen({super.key, required this.courseCode,});

  @override
  Widget build(BuildContext context) {
    DatabaseReference quizzesRef = FirebaseDatabase.instance.ref('Courses/$courseCode/quizzes');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Quiz'),
      ),
      body: Center(
        child: Column(
          children: [
            LargeTextField(
              hintText: "Enter Your Quiz Title....",
              height: 50.0.h,
              controller: topicController,
            ),
            10.verticalSpace,
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 17),
              child: CalendarWidget(dateController: dateController),
            ),
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          quizzesRef.push().set({
            'topic': topicController.text,
            'date': dateController.text,
          });
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: Container(
            height: 55.h,
            width: 300.w,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(23),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_sharp, color: Colors.white),
                  10.horizontalSpace,
                  Text(
                    "Done",
                    style: TextStyle(fontSize: 22.sp, color: Colors.white),
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

class CalendarWidget extends StatefulWidget {
  final TextEditingController dateController;

  const CalendarWidget({Key? key, required this.dateController})
      : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime selectedDate = DateTime.now();
  late FixedExtentScrollController monthController;
  late FixedExtentScrollController yearController;
  bool hasSelectedDate = false;

  @override
  void initState() {
    super.initState();
    widget.dateController.text = 'Select Date of Quiz';
    monthController =
        FixedExtentScrollController(initialItem: selectedDate.month - 1);
    yearController = FixedExtentScrollController(
      initialItem: _getYears().indexOf(selectedDate.year.toString()),
    );
  }

  void updateDateText() {
    final day = selectedDate.day;
    final month = _getMonths()[selectedDate.month - 1];
    final year = selectedDate.year;
    widget.dateController.text = "$day $month $year";
    hasSelectedDate = true;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.dateController,
      readOnly: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        labelStyle: TextStyle(
          fontSize: 16.sp,
          color: Colors.black,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onTap: _pickDate,
    );
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
                                                    monthController =
            FixedExtentScrollController(initialItem: selectedDate.month - 1);
        yearController = FixedExtentScrollController(
          initialItem: _getYears().indexOf(selectedDate.year.toString()),
        );
        updateDateText();
      });
    }
  }

  List<String> _getMonths() {
    return [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
  }

  List<String> _getYears() {
    List<String> years = [];
    int currentYear = DateTime.now().year;
    for (int i = currentYear + 10; i >= 1900; i--) {
      years.add(i.toString());
    }
    return years;
  }

  @override
  void dispose() {
    widget.dateController.dispose();
    monthController.dispose();
    yearController.dispose();
    super.dispose();
  }
}

class LargeTextField extends StatelessWidget {
  final double height;
  final String hintText;
  final TextEditingController controller;

  LargeTextField(
      {super.key,
      required this.hintText,
      required this.height,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xff32CD32), width: 3),
          ),
        ),
        width: 300.h,
        height: height,
        child: Container(
          color: const Color(0xff32CD32),
          child: TextFormField(
            controller: controller,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              labelStyle: const TextStyle(
                color: Color(0xff674FA3),
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
              ),
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Color(0XFFBF95A6),
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              filled: true,
              fillColor: const Color(0xffdaf7D2),
              border: const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Color(0xffFFE5F0)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Color(0xffFFE5F0)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Color(0xffFFE5F0),
                ),
              ),
            ),
            maxLines: 4,
          ),
        ),
      ),
    );
  }
}
