import 'package:flutter/material.dart';
import 'instructor_detail_screen.dart';

class InstructorListScreen extends StatelessWidget {
  // Sample instructor data - this would ideally come from your API or database
  final List<Map<String, dynamic>> instructors = [
    {
      'name': 'John Smith',
      'specialty': 'Beginner drivers, anxiety management',
      'experience': '15 years',
      'location': 'Downtown',
      'rating': 4.8,
      'hourlyRate': '\$45',
      'availability': 'Weekdays and Saturday mornings',
    },
    {
      'name': 'Maria Garcia',
      'specialty': 'Highway driving, defensive techniques',
      'experience': '8 years',
      'location': 'Westside',
      'rating': 4.9,
      'hourlyRate': '\$50',
      'availability': 'Afternoons and weekends',
    },
    {
      'name': 'David Chen',
      'specialty': 'Manual transmission, advanced skills',
      'experience': '12 years',
      'location': 'Eastside',
      'rating': 4.7,
      'hourlyRate': '\$55',
      'availability': 'Weekday evenings and Sundays',
    },
    {
      'name': 'Sarah Johnson',
      'specialty': 'Teen drivers, test preparation',
      'experience': '6 years',
      'location': 'Suburbs',
      'rating': 4.6,
      'hourlyRate': '\$40',
      'availability': 'Flexible schedule',
    },
    {
      'name': 'Ahmed Patel',
      'specialty': 'Senior refresher courses, parallel parking',
      'experience': '20 years',
      'location': 'City center',
      'rating': 5.0,
      'hourlyRate': '\$60',
      'availability': 'Mornings only',
    },
  ];

  InstructorListScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Instructors'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              Navigator.pushNamed(context, '/filter');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: instructors.length,
        itemBuilder: (context, index) {
          final instructor = instructors[index];
          return InstructorCard(instructor: instructor);
        },
      ),
    );
  }
}

class InstructorCard extends StatelessWidget {
  final Map<String, dynamic> instructor;

  InstructorCard({required this.instructor});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InstructorDetailScreen(
                instructor: instructor,
              ),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Instructor avatar placeholder
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          instructor['name'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          instructor['specialty'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            SizedBox(width: 4),
                            Text(
                              instructor['rating'].toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Text(
                              instructor['hourlyRate'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '/hour',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 4),
                  Text(
                    instructor['location'],
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(width: 16),
                  Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      instructor['availability'],
                      style: TextStyle(color: Colors.grey[600]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}