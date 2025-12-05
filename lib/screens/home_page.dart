import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/course.dart';
import '../models/lesson.dart';
import '../widgets/header.dart';
import '../widgets/streak_card.dart';
import '../widgets/stats_row.dart';
import '../widgets/courses_section.dart';
import '../widgets/daily_lessons_section.dart';
import '../widgets/bottom_nav_bar.dart';

class DuolingoHomePage extends StatefulWidget {
  @override
  _DuolingoHomePageState createState() => _DuolingoHomePageState();
}

class _DuolingoHomePageState extends State<DuolingoHomePage> {
  int _selectedIndex = 0;
  late Map<String, dynamic> _userData;
  late List<Course> _courses;
  late List<Lesson> _dailyLessons;

  @override
  void initState() {
    super.initState();
    // Khởi tạo dữ liệu từ DummyData
    _userData = DummyData.getUserData();
    _courses = DummyData.getCourses();
    _dailyLessons = DummyData.getDailyLessons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            DuolingoHeader(
              userName: _userData['name'],
              level: _userData['level'],
            ),
            
            // Streak Card
            StreakCard(
              streakDays: _userData['streakDays'],
              streakProgress: _userData['streakProgress'],
            ),
            
            // Stats Row
            StatsRow(
              xpPoints: _userData['xpPoints'],
              gems: _userData['gems'],
              hearts: _userData['hearts'],
            ),
            
            // Nội dung chính (có thể scroll)
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Courses Section
                    CoursesSection(courses: _courses),
                    SizedBox(height: 24),
                    
                    // Daily Lessons Section
                    DailyLessonsSection(lessons: _dailyLessons),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBar: DuolingoBottomNavBar(
        selectedIndex: _selectedIndex,
        onTabTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}