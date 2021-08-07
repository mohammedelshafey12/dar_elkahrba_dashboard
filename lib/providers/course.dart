import 'package:flutter/cupertino.dart';

class Course {
  final String id;
  final String title;
  final String instructor;
  final int hours;
  final double price;
  final String description;
  final String pdfUrl;

  Course({
    required this.id,
    required this.title,
    required this.instructor,
    required this.hours,
    required this.price,
    required this.description,
    this.pdfUrl = '',
  });
  Course copyWith(
      {String? id,
      String? title,
      String? description,
      int? hours,
      double? price,
      String? pdfUrl,
      String? instructor}) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      instructor: instructor ?? this.instructor,
      hours: hours ?? this.hours,
      description: description ?? this.description,
      price: price ?? this.price,
      pdfUrl: pdfUrl ?? this.pdfUrl,
    );
  }
}

class CoursesProvider with ChangeNotifier {
  List<Course> _courses = [
    Course(
      id: 'c1',
      title: 'Flutter for beginners ',
      instructor: 'Aasem Hany',
      hours: 30,
      price: 1500,
      description:
          'Create your favorite App on both Android & IOS with only one programming language using the latest Google framework which is called flutter',
    ),
    Course(
      id: 'c2',
      title: 'Flutter advanced',
      instructor: 'Mohamed Elshafey',
      hours: 30,
      price: 1500,
      description:
          'The next level of creating your favorite App on both Android & IOS with only one programming language using the latest Google framework which is called flutter',
    ),
    Course(
      id: 'c3',
      title: 'Machine Learning',
      instructor: 'Mohamed Elshaghnoby',
      hours: 40,
      price: 2000,
      description:
          'Learn how to the Machine is learning and different Learning Algorithms for Machine that will makes you a good ML Engineer',
    ),
    Course(
      id: 'c4',
      title: 'Computer vision',
      instructor: 'Ahmed Fathy',
      hours: 35,
      price: 2000,
      description:
          'Computer Vision Course to help you create applications like snapchat and other visionary interacting applications with the environment around you',
    ),
    Course(
      id: 'c5',
      title: 'Front-End Web development',
      instructor: 'Ahmed Saad',
      hours: 30,
      price: 2200,
      description:
          'Learn how to create websites and design it and deal with APIs, webservices other frameworks to be a Front-End developer',
    ),
  ];

  List<Course> get courses {
    return [..._courses];
  }

  void addCourse(Course course) {
    final newCourse = Course(
      id: DateTime.now().toString(),
      title: course.title,
      instructor: course.instructor,
      hours: course.hours,
      price: course.price,
      description: course.description,
    );
    _courses.add(newCourse);
    notifyListeners();
  }

  void updateCourse(Course editedCourse, String id) {
    final courseIndex = _courses.indexWhere((course) => course.id == id);
    if (courseIndex >= 0) {
      _courses[courseIndex] = editedCourse;
      notifyListeners();
    }
  }

  void deleteCourse(String id) {
    _courses.removeWhere((course) => course.id == id);
    notifyListeners();
  }
}
