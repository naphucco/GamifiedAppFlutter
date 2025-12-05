class User {
  String name;
  int level;
  int streakDays;
  double streakProgress;
  int xpPoints;
  int gems;
  int hearts;

  User({
    required this.name,
    required this.level,
    required this.streakDays,
    required this.streakProgress,
    required this.xpPoints,
    required this.gems,
    required this.hearts,
  });

  // Phương thức cập nhật XP
  void addXp(int xp) {
    xpPoints += xp;
    // Có thể thêm logic level up ở đây
    if (xpPoints >= 1000) {
      level = (xpPoints ~/ 1000) + 1;
    }
  }

  // Phương thức cập nhật streak
  void updateStreak(int days, double progress) {
    streakDays = days;
    streakProgress = progress;
  }

  // Phương thức cập nhật gems
  void addGems(int amount) {
    gems += amount;
  }

  // Phương thức sử dụng heart
  bool useHeart() {
    if (hearts > 0) {
      hearts--;
      return true;
    }
    return false;
  }

  // Phương thức restore hearts
  void restoreHearts() {
    hearts = 5; // Hoặc giá trị max
  }

  // Copy với giá trị mới
  User copyWith({
    String? name,
    int? level,
    int? streakDays,
    double? streakProgress,
    int? xpPoints,
    int? gems,
    int? hearts,
  }) {
    return User(
      name: name ?? this.name,
      level: level ?? this.level,
      streakDays: streakDays ?? this.streakDays,
      streakProgress: streakProgress ?? this.streakProgress,
      xpPoints: xpPoints ?? this.xpPoints,
      gems: gems ?? this.gems,
      hearts: hearts ?? this.hearts,
    );
  }
}