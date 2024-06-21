import 'package:flutter/material.dart';
 // import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    widget.dateController.text = 'Select Date of Quiz'; // Initial hint text
    monthController =
        FixedExtentScrollController(initialItem: selectedDate.month - 1);
    yearController = FixedExtentScrollController(
        initialItem: _getYears().indexOf(selectedDate.year.toString()));
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

        filled: true, // Enable filling
        fillColor: Colors.grey[200], // Grey background color
        labelStyle: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        border: OutlineInputBorder(
          // Rectangle border
          borderSide: BorderSide.none, // Remove the border
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
      lastDate: DateTime.now().add(Duration(days: 365 * 10)), // Allow selection of dates up to 10 years in the future
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        monthController =
            FixedExtentScrollController(initialItem: selectedDate.month - 1);
        yearController = FixedExtentScrollController(
            initialItem: _getYears().indexOf(selectedDate.year.toString()));
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

// @override
// void dispose() {
//   widget.dateController.dispose();
//   monthController.dispose();
//   yearController.dispose();
//   super.dispose();
// }
}