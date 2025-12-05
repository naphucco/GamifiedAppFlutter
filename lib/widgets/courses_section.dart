import 'package:flutter/material.dart';
import '../models/course.dart';
import 'course_card.dart';

class CoursesSection extends StatelessWidget {
  final List<Course> courses;

  CoursesSection({required this.courses});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Khóa học của bạn',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12),
        ...courses.map((course) => CourseCard(course: course)).toList(),
      ],
    );
  }
}