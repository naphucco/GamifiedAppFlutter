import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User _user;

  UserProvider()
      : _user = User(
          name: 'User',
          level: 5,
          streakDays: 5,
          streakProgress: 0.7,
          xpPoints: 1250,
          gems: 45,
          hearts: 5,
        );

  // Getter để lấy user
  User get user => _user;

  // Getter cho các thuộc tính riêng lẻ (tuỳ chọn)
  String get userName => _user.name;
  int get level => _user.level;
  int get streakDays => _user.streakDays;
  double get streakProgress => _user.streakProgress;
  int get xpPoints => _user.xpPoints;
  int get gems => _user.gems;
  int get hearts => _user.hearts;

  // Các phương thức cập nhật user
  void updateUser(User newUser) {
    _user = newUser;
    notifyListeners(); // Thông báo cho UI cập nhật
  }

  void updateName(String name) {
    _user = _user.copyWith(name: name);
    notifyListeners();
  }

  void addXp(int xp) {
    _user.addXp(xp);
    notifyListeners();
  }

  void updateStreak(int days, double progress) {
    _user.updateStreak(days, progress);
    notifyListeners();
  }

  void addGems(int amount) {
    _user.addGems(amount);
    notifyListeners();
  }

  bool useHeart() {
    final result = _user.useHeart();
    if (result) {
      notifyListeners();
    }
    return result;
  }

  void restoreHearts() {
    _user.restoreHearts();
    notifyListeners();
  }

  // Reset user (cho mục đích debug)
  void resetUser() {
    _user = User(
      name: 'User',
      level: 1,
      streakDays: 0,
      streakProgress: 0.0,
      xpPoints: 0,
      gems: 0,
      hearts: 5,
    );
    notifyListeners();
  }
}