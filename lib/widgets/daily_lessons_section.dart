import 'package:flutter/material.dart';
import '../models/lesson.dart';
import 'lesson_card.dart';

class DailyLessonsSection extends StatelessWidget {
  final List<Lesson> lessons;

  DailyLessonsSection({required this.lessons});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bài học hôm nay',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12),
        ...lessons.map((lesson) => LessonCard(lesson: lesson)).toList(),
      ],
    );
  }
}