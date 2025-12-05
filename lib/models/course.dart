import 'package:flutter/material.dart';

class Course {
  final String title;
  final String subtitle;
  final double progress;
  final Color color;
  final IconData icon;

  Course({
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.color,
    required this.icon,
  });
}