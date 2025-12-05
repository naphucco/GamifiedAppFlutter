import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'screens/home_page.dart';
import 'providers/user_provider.dart';
import 'providers/course_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CourseProvider()),
        // Có thể thêm nhiều Provider khác ở đây
      ],
      child: DuolingoApp(),
    ),
  );
}

class DuolingoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Duolingo Style App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),
      home: DuolingoHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}