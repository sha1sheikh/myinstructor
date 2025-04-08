import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/instructor_list_screen.dart';
import 'screens/instructor_detail_screen.dart';
import 'screens/filter_screen.dart';

void main() {
  runApp(DrivingInstructorApp());
}

class DrivingInstructorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DriveMate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF4A6FF3),
        colorScheme: ColorScheme.light(
          primary: Color(0xFF4A6FF3),
          secondary: Color(0xFF4A6FF3),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 1,
        ),
        scaffoldBackgroundColor: Color(0xFFF8F8F8),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Color(0xFF4A6FF3),
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}