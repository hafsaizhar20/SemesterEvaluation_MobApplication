class CourseModel {
  final Map<String, dynamic> map;

  const CourseModel({this.map = const {}});

  String? get courseCode => map['courseCode'] as String? ?? "";
  String? get uid => map['uid'] as String? ??"";
  String? get courseName => map['courseName'] as String? ?? "";

  List<AttendanceModel> get attendance {
    final attendanceData = map['attendance'] as Map<String, dynamic>;
    return attendanceData.entries.map((entry) {
      return AttendanceModel(map: entry.value as Map<String, dynamic>);
    }).toList();
  }

   
}

class AttendanceModel {
  final Map<String, dynamic> map;

  const AttendanceModel({this.map = const {}});

  String? get date => map['date'] as String? ?? "";
  String? get status => map['status'] as String? ??"";
}

class QuizModel {
  final String key;
  final Map<String, dynamic> map;

  QuizModel({required this.key, required this.map});

  String get topic => map['topic'] ?? '';
  String get date => map['date'] ?? '';
}
