import 'package:flutter/material.dart';
import '../models/course.dart';
import '../models/lesson.dart';

class DummyData {
  static List<Course> getCourses() {
    return [
      Course(
        title: 'Tiếng Anh',
        subtitle: 'Căn bản',
        progress: 0.65,
        color: Colors.blue,
        icon: Icons.language,
      ),
      Course(
        title: 'Tiếng Pháp',
        subtitle: 'Trung cấp',
        progress: 0.3,
        color: Colors.purple,
        icon: Icons.restaurant,
      ),
      Course(
        title: 'Tiếng Nhật',
        subtitle: 'Mới bắt đầu',
        progress: 0.15,
        color: Colors.red,
        icon: Icons.flag,
      ),
    ];
  }

  static List<Lesson> getDailyLessons() {
    return [
      Lesson(
        title: 'Chào hỏi',
        description: 'Học cách chào hỏi',
        xp: 10,
        completed: true,
      ),
      Lesson(
        title: 'Thức ăn',
        description: 'Từ vựng về đồ ăn',
        xp: 15,
        completed: true,
      ),
      Lesson(
        title: 'Du lịch',
        description: 'Câu hỏi thông dụng',
        xp: 20,
        completed: false,
      ),
      Lesson(
        title: 'Thời tiết',
        description: 'Miêu tả thời tiết',
        xp: 15,
        completed: false,
      ),
    ];
  }

  // Dữ liệu người dùng
  static Map<String, dynamic> getUserData() {
    return {
      'name': 'User',
      'level': 5,
      'streakDays': 5,
      'streakProgress': 0.7,
      'xpPoints': 1250,
      'gems': 45,
      'hearts': 5,
    };
  }
}