import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../providers/course_provider.dart';
import '../models/lesson.dart';
import 'lesson_card.dart';

class DailyLessonsSection extends StatelessWidget {
  final List<Lesson> lessons;

  DailyLessonsSection({required this.lessons});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);

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
        ...lessons.map((lesson) => LessonCard(
          lesson: lesson,
          onTap: () {
            // Xử lý khi người dùng tap vào bài học
            if (!lesson.completed) {
              // Kiểm tra còn hearts không
              if (userProvider.useHeart()) {
                // Hoàn thành bài học
                courseProvider.completeLesson(lesson.title, lesson.xp);
                // Thêm XP cho user
                userProvider.addXp(lesson.xp);
                // Thêm gems thưởng
                userProvider.addGems(5);
                
                // Hiển thị thông báo
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Bạn đã hoàn thành bài học và nhận được ${lesson.xp} XP!'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else {
                // Hết hearts
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Bạn đã hết hearts! Hãy chờ hoặc mua thêm.'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          },
        )).toList(),
      ],
    );
  }
}