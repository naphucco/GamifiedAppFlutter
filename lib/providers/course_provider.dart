import 'package:flutter/material.dart';
import '../models/course.dart';
import '../models/lesson.dart';

class CourseProvider with ChangeNotifier {
  List<Course> _courses = [];
  List<Lesson> _dailyLessons = [];

  CourseProvider() {
    // Khởi tạo dữ liệu mẫu
    _loadCourses();
    _loadDailyLessons();
  }

  // Getter
  List<Course> get courses => _courses;
  List<Lesson> get dailyLessons => _dailyLessons;
  List<Lesson> get completedLessons => 
      _dailyLessons.where((lesson) => lesson.completed).toList();
  List<Lesson> get pendingLessons => 
      _dailyLessons.where((lesson) => !lesson.completed).toList();

  // Tải dữ liệu courses
  void _loadCourses() {
    _courses = [
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

  // Tải dữ liệu daily lessons
  void _loadDailyLessons() {
    _dailyLessons = [
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

  // Cập nhật tiến độ khóa học
  void updateCourseProgress(String courseTitle, double progress) {
    final index = _courses.indexWhere((course) => course.title == courseTitle);
    if (index != -1) {
      // Tạo course mới với progress được cập nhật
      final oldCourse = _courses[index];
      _courses[index] = Course(
        title: oldCourse.title,
        subtitle: oldCourse.subtitle,
        progress: progress,
        color: oldCourse.color,
        icon: oldCourse.icon,
      );
      notifyListeners();
    }
  }

  // Hoàn thành bài học
  void completeLesson(String lessonTitle, int xpReward) {
    final index = _dailyLessons.indexWhere((lesson) => lesson.title == lessonTitle);
    if (index != -1) {
      // Tạo lesson mới với trạng thái completed
      final oldLesson = _dailyLessons[index];
      _dailyLessons[index] = Lesson(
        title: oldLesson.title,
        description: oldLesson.description,
        xp: oldLesson.xp,
        completed: true,
      );
      notifyListeners();
    }
  }

  // Thêm khóa học mới
  void addCourse(Course newCourse) {
    _courses.add(newCourse);
    notifyListeners();
  }

  // Reset tất cả bài học về chưa hoàn thành
  void resetDailyLessons() {
    for (var i = 0; i < _dailyLessons.length; i++) {
      final oldLesson = _dailyLessons[i];
      _dailyLessons[i] = Lesson(
        title: oldLesson.title,
        description: oldLesson.description,
        xp: oldLesson.xp,
        completed: false,
      );
    }
    notifyListeners();
  }

  // Lấy khóa học theo index
  Course getCourse(int index) {
    if (index >= 0 && index < _courses.length) {
      return _courses[index];
    }
    throw RangeError('Index out of bounds');
  }

  // Lấy bài học theo index
  Lesson getLesson(int index) {
    if (index >= 0 && index < _dailyLessons.length) {
      return _dailyLessons[index];
    }
    throw RangeError('Index out of bounds');
  }
}