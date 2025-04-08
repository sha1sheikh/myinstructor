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
        primaryColor: Color(0xFF8B6C42),
        colorScheme: ColorScheme.light(
          primary: Color(0xFF8B6C42),
          secondary: Color(0xFF8B6C42),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFFFF8DC),
          foregroundColor: Colors.black87,
          elevation: 1,
        ),
        scaffoldBackgroundColor: Color(0xFFFFF8DC),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Color(0xFFFFF8DC),
            backgroundColor: Color(0xFF8B6C42),
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}