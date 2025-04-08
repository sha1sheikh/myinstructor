import 'package:flutter/material.dart';

class InstructorDetailScreen extends StatelessWidget {
  final Map<String, dynamic> instructor;

  InstructorDetailScreen({required this.instructor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instructor Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Instructor header with image and name
            Row(
              children: [
                // Circular avatar (placeholder)
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        instructor['name'],
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 20),
                          SizedBox(width: 4),
                          Text(
                            '${instructor['rating']} / 5.0',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 30),
            
            // Info card
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(Icons.auto_stories, 'Specialty', instructor['specialty']),
                    Divider(),
                    _buildInfoRow(Icons.history, 'Experience', instructor['experience']),
                    Divider(),
                    _buildInfoRow(Icons.location_on, 'Location', instructor['location']),
                    Divider(),
                    _buildInfoRow(Icons.attach_money, 'Rate', instructor['hourlyRate']),
                    Divider(),
                    _buildInfoRow(Icons.access_time, 'Availability', instructor['availability']),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 30),
            
            // About section
            Text(
              'About',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              instructor['about'] ?? 'Professional driving instructor with extensive experience helping students become confident, safe drivers. Specialized in ${instructor['specialty']}.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            
            SizedBox(height: 40),
            
            // Book button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Booking functionality would go here
                  _showBookingDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Book a Lesson',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF8B6C42)),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  void _showBookingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Book a Lesson'),
        content: Text('This is a placeholder for the booking functionality.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              // Booking logic would go here
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Booking request sent!'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }
}