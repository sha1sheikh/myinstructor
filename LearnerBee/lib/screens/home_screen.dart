import 'package:flutter/material.dart';
import 'instructor_list_screen.dart';
import 'filter_screen.dart';
import 'chat_screen.dart'; // Import the new chat screen

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DriveMate'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png', // Make sure you have this asset
              height: 150,
              width: 150,
            ),
            SizedBox(height: 40),
            _buildMenuButton(
              context, 
              'Find Instructors', 
              Icons.search,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InstructorListScreen()),
              )
            ),
            SizedBox(height: 20),
            _buildMenuButton(
              context, 
              'Filter Options', 
              Icons.filter_list,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FilterScreen()),
              )
            ),
            SizedBox(height: 20),
            _buildMenuButton(
              context, 
              'Chat Assistant', 
              Icons.chat,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen()),
              )
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildMenuButton(
    BuildContext context, String label, IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        minimumSize: Size(250, 60),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          SizedBox(width: 15),
          Text(
            label,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}