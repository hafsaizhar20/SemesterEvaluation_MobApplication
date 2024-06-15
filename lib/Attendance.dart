// import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// class Attendance extends StatefulWidget {
//
//    Attendance({super.key,});
//
//   @override
//   State<Attendance> createState() => _AttendanceState();
// }
//
// class _AttendanceState extends State<Attendance> {
//   bool isSwitched = false;
//   final TextEditingController dateController = TextEditingController();
//   @override
//   void dispose() {
//     dateController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(
//         title: const Center(
//           child: Text(
//             'Attendance',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 30,
//               fontFamily: 'Pacifico'
//             ),
//           ),
//         ),
//         backgroundColor: Colors.indigo.shade900,
//       ),
//   body: SingleChildScrollView(
//     physics: BouncingScrollPhysics(),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           height: 25,
//         ),
//         Row(
//           children: [
//             SizedBox(
//               width:
//               20,
//             ),
//             Text(' Are you absent :',style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//               fontFamily:'Pacifico', // 'Rubik Italic VariableFont_wght
//               color: Colors.pink
//             ),),
//             SizedBox(
//               width: 100,
//             ),
//             Switch(
//                 activeColor: Colors.lightGreen.shade300,
//                 value: isSwitched, onChanged: (value) {
//               setState(() {
//                 isSwitched = value;
//               });
//             })
//           ],
//         ),
//         Container(
//           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 17),
//           child: CalendarWidget(dateController: dateController),
//         ),
//       ],
//     ),
//   ),
//
//
//
//
//     );
//   }
// }
// class CalendarWidget extends StatefulWidget {
//   final TextEditingController dateController;
//
//   const CalendarWidget({Key? key, required this.dateController})
//       : super(key: key);
//
//   @override
//   _CalendarWidgetState createState() => _CalendarWidgetState();
// }
//
// class _CalendarWidgetState extends State<CalendarWidget> {
//   DateTime selectedDate = DateTime.now();
//   late FixedExtentScrollController monthController;
//   late FixedExtentScrollController yearController;
//   bool hasSelectedDate = false;
//
//   @override
//   void initState() {
//     super.initState();
//     widget.dateController.text = 'Select Date of Quiz';
//     monthController =
//         FixedExtentScrollController(initialItem: selectedDate.month - 1);
//     yearController = FixedExtentScrollController(
//       initialItem: _getYears().indexOf(selectedDate.year.toString()),
//     );
//   }
//
//   void updateDateText() {
//     final day = selectedDate.day;
//     final month = _getMonths()[selectedDate.month - 1];
//     final year = selectedDate.year;
//     widget.dateController.text = "$day $month $year";
//     hasSelectedDate = true;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: widget.dateController,
//       readOnly: true,
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: Colors.grey[200],
//         labelStyle: TextStyle(
//           fontSize: 16,
//           color: Colors.black,
//         ),
//         border: OutlineInputBorder(
//           borderSide: BorderSide.none,
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//       ),
//       onTap: _pickDate,
//     );
//   }
//
//   Future<void> _pickDate() async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
//     );
//
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//         monthController =
//             FixedExtentScrollController(initialItem: selectedDate.month - 1);
//         yearController = FixedExtentScrollController(
//           initialItem: _getYears().indexOf(selectedDate.year.toString()),
//         );
//         updateDateText();
//       });
//     }
//   }
//
//   List<String> _getMonths() {
//     return [
//       "January",
//       "February",
//       "March",
//       "April",
//       "May",
//       "June",
//       "July",
//       "August",
//       "September",
//       "October",
//       "November",
//       "December",
//     ];
//   }
//
//   List<String> _getYears() {
//     List<String> years = [];
//     int currentYear = DateTime.now().year;
//     for (int i = currentYear + 10; i >= 1900; i--) {
//       years.add(i.toString());
//     }
//     return years;
//   }
//
//   // @override
//   // void dispose() {
//   //   widget.dateController.dispose();
//   //   monthController.dispose();
//   //   yearController.dispose();
//   //   super.dispose();
//   // }
// }
//
// class LargeTextField extends StatelessWidget {
//   final double height;
//   final String hintText;
//   final TextEditingController controller;
//
//   LargeTextField(
//       {super.key,
//         required this.hintText,
//         required this.height,
//         required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         decoration: const BoxDecoration(
//           border: Border(
//             bottom: BorderSide(color: Color(0xff32CD32), width: 3),
//           ),
//         ),
//         width: 300,
//         height: height,
//         child: Container(
//           color: const Color(0xff32CD32),
//           child: TextFormField(
//             controller: controller,
//             style: const TextStyle(
//               color: Colors.black,
//               fontSize: 14.0,
//               fontWeight: FontWeight.normal,
//             ),
//             decoration: InputDecoration(
//               contentPadding: const EdgeInsets.symmetric(
//                 vertical: 8.0,
//                 horizontal: 16.0,
//               ),
//               labelStyle: const TextStyle(
//                 color: Color(0xff674FA3),
//                 fontSize: 14.0,
//                 fontWeight: FontWeight.normal,
//               ),
//               hintText: hintText,
//               hintStyle: const TextStyle(
//                 color: Color(0XFFBF95A6),
//                 fontSize: 14,
//                 fontWeight: FontWeight.normal,
//               ),
//               filled: true,
//               fillColor: const Color(0xffdaf7D2),
//               border: const OutlineInputBorder(
//                 borderSide: BorderSide(width: 1, color: Color(0xffFFE5F0)),
//               ),
//               enabledBorder: const OutlineInputBorder(
//                 borderSide: BorderSide(width: 1, color: Color(0xffFFE5F0)),
//               ),
//               focusedBorder: const OutlineInputBorder(
//                 borderSide: BorderSide(
//                   width: 1,
//                   color: Color(0xffFFE5F0),
//                 ),
//               ),
//             ),
//             maxLines: 4,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Attendance extends StatefulWidget {
  final String courseCode;
  const Attendance({super.key,required this.courseCode});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  bool isSwitched = false;
  final TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DatabaseReference attendanceRef = FirebaseDatabase.instance.ref('Courses/${widget.courseCode}/attendance');
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Attendance',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontFamily: 'Pacifico',
            ),
          ),
        ),
        backgroundColor: Colors.indigo.shade900,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  ' Are you absent :',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Pacifico', // 'Rubik Italic VariableFont_wght
                    color: Colors.pink,
                  ),
                ),
                SizedBox(
                  width: 100,
                ),
                Switch(
                  activeColor: Colors.lightGreen.shade300,
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 17),
              child: CalendarWidget(dateController: dateController),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () {
                  Map<String, String> attendanceData = {
                    'date': dateController.text,
                  };

                  if (isSwitched) {
                    attendanceData['status'] = 'absent';
                  }

                  attendanceRef.push().set(attendanceData);
                },
                // child: Text('Submit Attendance'),


              //   onTap: () {
            //   attendanceRef.push().set({
            //     if(isSwitched == true){
            //    'status' : "absent"},
            //     'date': dateController.text,
            //   });
            // },
              child: Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.indigo.shade900,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                    child: Text(
                      'Mark',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: 'Pacifico'),
                    )),
              ),
            ),
SizedBox(height: 50),
                 Text('TOTAL   OFF',style: TextStyle(
                   fontSize: 23,
                   fontFamily: 'Pacifico',
                   color: Colors.lightGreen.shade400
                 ),),
            SizedBox(height: 15),
                 StreamBuilder(
                    stream: attendanceRef.onValue,
                    builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                      // if (!snapshot.hasData) {
                      //   return Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [CircularProgressIndicator()]);
                      // }
                      // else {
                        Map<dynamic, dynamic> map =
                        snapshot.data!.snapshot.value as dynamic;
                        List<dynamic> list = [];
                        list.clear();
                        list = map.values.toList();

                        return ListView.builder(

                            shrinkWrap: true,
                            itemCount: snapshot.data!.snapshot.children.length,
                            itemBuilder: (context, index) {
                              String status = list[index]['status'].toString();
                              String date = list[index]['date'].toString();
                              return Card(
                                  elevation: 10,
                                  shadowColor: Colors.indigo.shade300,
                                  child: Column(
                                      children: [
                                        ListTile(
                                            title: Row(
                                                children: [
                                                  Text('  $status',style: TextStyle(
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
                )

          ],
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
  bool isDisposed = false;

  @override
  void initState() {
    super.initState();
    widget.dateController.text = 'Select Date';
    monthController =
        FixedExtentScrollController(initialItem: selectedDate.month - 1);
    yearController = FixedExtentScrollController(
      initialItem: _getYears().indexOf(selectedDate.year.toString()),
    );
  }

  void updateDateText() {
    if (!isDisposed) {
      final day = selectedDate.day;
      final month = _getMonths()[selectedDate.month - 1];
      final year = selectedDate.year;
      widget.dateController.text = "$day $month $year";
    }
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
          fontSize: 16,
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
    isDisposed = true;
    monthController.dispose();
    yearController.dispose();
    super.dispose();
  }
}

class LargeTextField extends StatelessWidget {
  final double height;
  final String hintText;
  final TextEditingController controller;

  const LargeTextField({
    super.key,
    required this.hintText,
    required this.height,
    required this.controller,
  });

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
        width: 300,
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
