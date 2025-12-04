import 'package:flutter/material.dart';

void main() {
  runApp(DuolingoApp());
}

/// Ứng dụng chính Duolingo Style
class DuolingoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Duolingo Style App',
      theme: ThemeData(
        primarySwatch: Colors.green, // Màu chủ đạo giống Duolingo
        fontFamily: 'Roboto', // Font chữ mặc định
      ),
      home: DuolingoHomePage(),
      debugShowCheckedModeBanner: false, // Ẩn banner debug
    );
  }
}

/// Trang Home chính của ứng dụng
class DuolingoHomePage extends StatefulWidget {
  @override
  _DuolingoHomePageState createState() => _DuolingoHomePageState();
}

class _DuolingoHomePageState extends State<DuolingoHomePage> {
  // Biến quản lý tab đang chọn trên bottom navigation
  int _selectedIndex = 0;
  
  // Dữ liệu streak (chuỗi ngày học tập)
  double _streakProgress = 0.7; // Tiến độ streak (0-1)
  int _streakDays = 5; // Số ngày streak hiện tại
  
  // Dữ liệu thống kê người dùng
  int _xpPoints = 1250; // Tổng điểm XP
  int _gems = 45;       // Số gem (tiền tệ trong game)
  int _heart = 5;       // Số mạng (lives)
  
  // Danh sách các khóa học của người dùng
  final List<Course> _courses = [
    Course(
      title: 'Tiếng Anh', 
      subtitle: 'Căn bản', 
      progress: 0.65, 
      color: Colors.blue, 
      icon: Icons.language
    ),
    Course(
      title: 'Tiếng Pháp', 
      subtitle: 'Trung cấp', 
      progress: 0.3, 
      color: Colors.purple, 
      icon: Icons.restaurant
    ),
    Course(
      title: 'Tiếng Nhật', 
      subtitle: 'Mới bắt đầu', 
      progress: 0.15, 
      color: Colors.red, 
      icon: Icons.flag
    ),
  ];
  
  // Danh sách bài học hôm nay
  final List<Lesson> _dailyLessons = [
    Lesson(
      title: 'Chào hỏi', 
      description: 'Học cách chào hỏi', 
      xp: 10, 
      completed: true
    ),
    Lesson(
      title: 'Thức ăn', 
      description: 'Từ vựng về đồ ăn', 
      xp: 15, 
      completed: true
    ),
    Lesson(
      title: 'Du lịch', 
      description: 'Câu hỏi thông dụng', 
      xp: 20, 
      completed: false
    ),
    Lesson(
      title: 'Thời tiết', 
      description: 'Miêu tả thời tiết', 
      xp: 15, 
      completed: false
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Nền trắng sáng giống Duolingo
      body: SafeArea(
        child: Column(
          children: [
            // ===== PHẦN 1: HEADER =====
            _buildHeader(),
            
            // ===== PHẦN 2: STREAK CARD =====
            _buildStreakCard(),
            
            // ===== PHẦN 3: STATS ROW (XP, GEMS, HEARTS) =====
            _buildStatsRow(),
            
            // ===== PHẦN 4: NỘI DUNG CHÍNH (CÓ THỂ SCROLL) =====
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ===== PHẦN 4.1: DANH SÁCH KHÓA HỌC =====
                    _buildCoursesSection(),
                    SizedBox(height: 24), // Khoảng cách giữa các section
                    
                    // ===== PHẦN 4.2: BÀI HỌC HÔM NAY =====
                    _buildDailyLessonsSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      
      // ===== PHẦN 5: BOTTOM NAVIGATION BAR =====
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // ====================================================
  // WIDGET 1: HEADER VỚI THÔNG TIN NGƯỜI DÙNG
  // ====================================================
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1), // Shadow nhẹ
            blurRadius: 4,
            offset: Offset(0, 2), // Shadow hướng xuống
          ),
        ],
      ),
      child: Row(
        children: [
          // ----- AVATAR NGƯỜI DÙNG -----
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green, // Màu nền avatar
            ),
            child: Center(
              child: Text(
                'U', // Chữ cái đầu tên người dùng
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          
          SizedBox(width: 12), // Khoảng cách giữa avatar và text
          
          // ----- THÔNG TIN NGƯỜI DÙNG -----
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Xin chào, User!', // Lời chào
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'Level 5', // Level người dùng
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          
          // ----- ICON THÔNG BÁO (CÓ BADGE) -----
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications_none, size: 28),
                onPressed: () {}, // TODO: Thêm logic thông báo
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red, // Dấu chấm đỏ thông báo
                  ),
                ),
              ),
            ],
          ),
          
          // ----- ICON CÀI ĐẶT -----
          IconButton(
            icon: Icon(Icons.settings_outlined, size: 28),
            onPressed: () {}, // TODO: Thêm logic cài đặt
          ),
        ],
      ),
    );
  }

  // ====================================================
  // WIDGET 2: STREAK CARD (CHUỖI NGÀY HỌC TẬP)
  // ====================================================
  Widget _buildStreakCard() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        // Gradient màu xanh giống Duolingo
        gradient: LinearGradient(
          colors: [Colors.blue.shade400, Colors.blue.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20), // Bo góc lớn
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 4), // Tạo hiệu ứng nổi
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ----- DÒNG 1: TIÊU ĐỀ VÀ SỐ NGÀY -----
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Chuỗi ngày học tập',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.local_fire_department, color: Colors.orange),
                  SizedBox(width: 8),
                  Text(
                    '$_streakDays ngày', // Hiển thị số ngày streak
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          SizedBox(height: 16), // Khoảng cách giữa các phần
          
          // ----- PROGRESS BAR -----
          Container(
            height: 12,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3), // Nền trong suốt
              borderRadius: BorderRadius.circular(6),
            ),
            child: Stack(
              children: [
                // Phần progress đã hoàn thành
                Container(
                  width: MediaQuery.of(context).size.width * _streakProgress,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.orange, Colors.yellow], // Màu lửa
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 8),
          
          // ----- DÒNG 3: THÔNG TIN THÊM -----
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tiếp tục duy trì chuỗi!', // Lời động viên
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                ),
              ),
              Text(
                'Mục tiêu: 7 ngày', // Mục tiêu streak
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ====================================================
  // WIDGET 3: HÀNG THỐNG KÊ (XP, GEMS, HEARTS)
  // ====================================================
  Widget _buildStatsRow() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50], // Nền xám nhẹ
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(Icons.star, '$_xpPoints XP', Colors.amber),
          _buildStatItem(Icons.diamond, '$_gems', Colors.blue),
          _buildStatItem(Icons.favorite, '$_heart', Colors.red),
        ],
      ),
    );
  }

  // ====================================================
  // WIDGET CON: MỘT ITEM THỐNG KÊ
  // ====================================================
  Widget _buildStatItem(IconData icon, String value, Color color) {
    return Column(
      children: [
        // ----- BACKGROUND ICON -----
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1), // Nền nhạt theo màu icon
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        
        SizedBox(height: 8), // Khoảng cách giữa icon và text
        
        // ----- GIÁ TRỊ -----
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  // ====================================================
  // WIDGET 4: SECTION KHÓA HỌC
  // ====================================================
  Widget _buildCoursesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ----- TIÊU ĐỀ SECTION -----
        Text(
          'Khóa học của bạn',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        
        SizedBox(height: 12), // Khoảng cách dưới tiêu đề
        
        // ----- DANH SÁCH KHÓA HỌC -----
        ..._courses.map((course) => _buildCourseCard(course)).toList(),
      ],
    );
  }

  // ====================================================
  // WIDGET CON: CARD KHÓA HỌC
  // ====================================================
  Widget _buildCourseCard(Course course) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 3), // Shadow nhẹ phía dưới
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.2)), // Viền mờ
      ),
      child: Row(
        children: [
          // ----- ICON KHÓA HỌC -----
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: course.color.withOpacity(0.1), // Nền theo màu khóa học
              shape: BoxShape.circle,
            ),
            child: Icon(course.icon, color: course.color, size: 24),
          ),
          
          SizedBox(width: 16), // Khoảng cách giữa icon và nội dung
          
          // ----- THÔNG TIN KHÓA HỌC -----
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tên khóa học
                Text(
                  course.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                
                // Mô tả ngắn
                Text(
                  course.subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                
                SizedBox(height: 8), // Khoảng cách trước progress bar
                
                // ----- PROGRESS BAR -----
                Container(
                  height: 6,
                  child: LinearProgressIndicator(
                    value: course.progress, // Tiến độ khóa học (0-1)
                    backgroundColor: Colors.grey[200], // Nền progress bar
                    valueColor: AlwaysStoppedAnimation<Color>(course.color), // Màu progress
                    borderRadius: BorderRadius.circular(3), // Bo góc
                  ),
                ),
              ],
            ),
          ),
          
          // ----- NÚT TIẾP TỤC (PLAY) -----
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: course.color, // Màu nền theo khóa học
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.play_arrow, color: Colors.white), // Icon play
          ),
        ],
      ),
    );
  }

  // ====================================================
  // WIDGET 5: SECTION BÀI HỌC HÔM NAY
  // ====================================================
  Widget _buildDailyLessonsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ----- TIÊU ĐỀ SECTION -----
        Text(
          'Bài học hôm nay',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        
        SizedBox(height: 12), // Khoảng cách dưới tiêu đề
        
        // ----- DANH SÁCH BÀI HỌC -----
        ..._dailyLessons.map((lesson) => _buildLessonCard(lesson)).toList(),
      ],
    );
  }

  // ====================================================
  // WIDGET CON: CARD BÀI HỌC
  // ====================================================
  Widget _buildLessonCard(Lesson lesson) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // ----- TRẠNG THÁI HOÀN THÀNH -----
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // Màu nền khác nhau tùy trạng thái
              color: lesson.completed ? 
                Colors.green.withOpacity(0.1) : 
                Colors.grey.withOpacity(0.1),
            ),
            child: Icon(
              lesson.completed ? Icons.check_circle : Icons.lock_open,
              color: lesson.completed ? Colors.green : Colors.grey,
            ),
          ),
          
          SizedBox(width: 16), // Khoảng cách giữa icon và nội dung
          
          // ----- THÔNG TIN BÀI HỌC -----
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tiêu đề bài học
                Text(
                  lesson.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                
                // Mô tả bài học
                Text(
                  lesson.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          
          // ----- ĐIỂM XP -----
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.1), // Nền vàng nhạt
              borderRadius: BorderRadius.circular(20), // Bo góc tròn
            ),
            child: Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16), // Icon ngôi sao
                SizedBox(width: 4), // Khoảng cách giữa icon và text
                Text(
                  '${lesson.xp} XP', // Số điểm XP
                  style: TextStyle(
                    color: Colors.amber.shade800,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ====================================================
  // WIDGET 6: BOTTOM NAVIGATION BAR
  // ====================================================
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, -2), // Shadow hướng lên
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Cập nhật tab được chọn
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green, // Màu tab được chọn
        unselectedItemColor: Colors.grey, // Màu tab không được chọn
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: [
          // ----- TAB 1: TRANG CHỦ -----
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          
          // ----- TAB 2: HỌC -----
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Học',
          ),
          
          // ----- TAB 3: NÚT HỌC CHÍNH (NỔI BẬT) -----
          BottomNavigationBarItem(
            icon: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.lightGreen],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 4), // Tạo hiệu ứng nổi
                  ),
                ],
              ),
              child: Icon(Icons.play_arrow, color: Colors.white), // Icon play
            ),
            label: '', // Không có label cho nút này
          ),
          
          // ----- TAB 4: BẢNG XẾP HẠNG -----
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Bảng xếp hạng',
          ),
          
          // ----- TAB 5: HỒ SƠ -----
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Hồ sơ',
          ),
        ],
      ),
    );
  }
}

// ====================================================
// MODEL: KHÓA HỌC
// ====================================================
class Course {
  final String title;      // Tên khóa học (ví dụ: "Tiếng Anh")
  final String subtitle;   // Mô tả ngắn (ví dụ: "Căn bản")
  final double progress;   // Tiến độ (0-1)
  final Color color;       // Màu chủ đạo của khóa học
  final IconData icon;     // Icon đại diện

  Course({
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.color,
    required this.icon,
  });
}

// ====================================================
// MODEL: BÀI HỌC
// ====================================================
class Lesson {
  final String title;       // Tên bài học (ví dụ: "Chào hỏi")
  final String description; // Mô tả bài học
  final int xp;             // Điểm XP nhận được khi hoàn thành
  final bool completed;     // Trạng thái hoàn thành

  Lesson({
    required this.title,
    required this.description,
    required this.xp,
    required this.completed,
  });
}