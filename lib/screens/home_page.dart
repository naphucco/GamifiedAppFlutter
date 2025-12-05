import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../providers/course_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    // Lấy dữ liệu từ Provider
    final userProvider = Provider.of<UserProvider>(context);
    final courseProvider = Provider.of<CourseProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header với dữ liệu từ UserProvider
            DuolingoHeader(
              userName: userProvider.userName,
              level: userProvider.level,
            ),
            
            // Streak Card với dữ liệu từ UserProvider
            StreakCard(
              streakDays: userProvider.streakDays,
              streakProgress: userProvider.streakProgress,
            ),
            
            // Stats Row với dữ liệu từ UserProvider
            StatsRow(
              xpPoints: userProvider.xpPoints,
              gems: userProvider.gems,
              hearts: userProvider.hearts,
            ),
            
            // Nội dung chính
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Courses Section với dữ liệu từ CourseProvider
                    CoursesSection(courses: courseProvider.courses),
                    SizedBox(height: 24),
                    
                    // Daily Lessons Section với dữ liệu từ CourseProvider
                    DailyLessonsSection(lessons: courseProvider.dailyLessons),
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

      // Thêm Floating Action Button để demo cập nhật state
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            heroTag: 'fab1',
            onPressed: () {
              // Demo: Thêm XP khi nhấn nút
              userProvider.addXp(10);
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
          ),
          SizedBox(height: 8),
          FloatingActionButton.small(
            heroTag: 'fab2',
            onPressed: () {
              // Demo: Hoàn thành bài học đầu tiên
              if (courseProvider.pendingLessons.isNotEmpty) {
                final lesson = courseProvider.pendingLessons.first;
                courseProvider.completeLesson(lesson.title, lesson.xp);
                userProvider.addXp(lesson.xp);
              }
            },
            child: Icon(Icons.check),
            backgroundColor: Colors.blue,
          ),
          SizedBox(height: 8),
          FloatingActionButton.small(
            heroTag: 'fab3',
            onPressed: () {
              // Demo: Reset daily lessons
              courseProvider.resetDailyLessons();
              userProvider.restoreHearts();
            },
            child: Icon(Icons.refresh),
            backgroundColor: Colors.orange,
          ),
        ],
      ),
    );
  }
}