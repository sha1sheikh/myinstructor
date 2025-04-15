import 'package:flutter/material.dart';
import '../models/instructor.dart';
import '../services/instructor_service.dart';
import 'payment_screen.dart';

class InstructorDetailScreen extends StatefulWidget {
  final String instructorId;
  
  InstructorDetailScreen({required this.instructorId});
  
  @override
  _InstructorDetailScreenState createState() => _InstructorDetailScreenState();
}

class _InstructorDetailScreenState extends State<InstructorDetailScreen> {
  late Instructor instructor;
  late bool isFavorite;
  
  @override
  void initState() {
    super.initState();
    instructor = InstructorService.getInstructorById(widget.instructorId);
    isFavorite = instructor.isFavorite;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instructor Profile'),
      ),
      body: Column(
        children: [
          // Instructor profile header
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile image
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    instructor.image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16),
                
                // Instructor info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        instructor.name,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        instructor.location,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            instructor.rating.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          SizedBox(width: 4),
                          Text(
                            '(${instructor.reviewCount} reviews)',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Favorite button
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Theme.of(context).primaryColor : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      InstructorService.toggleFavorite(instructor.id);
                      isFavorite = !isFavorite;
                    });
                  },
                ),
              ],
            ),
          ),
          
          // About section
          Expanded(
            child: ListView(
              children: [
                // About section
                _buildSection(
                  title: 'About',
                  child: Text(
                    instructor.experience,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ),
                
                // Lesson details section
                _buildSection(
                  title: 'Lesson Details',
                  child: Column(
                    children: [
                      _buildDetailRow(Icons.access_time, '${instructor.duration} lessons'),
                      SizedBox(height: 12),
                      _buildDetailRow(Icons.credit_card, '\$${instructor.price.toInt()} per lesson'),
                      SizedBox(height: 12),
                      _buildDetailRow(Icons.location_on, 'Serves ${instructor.location} area'),
                    ],
                  ),
                ),
                
                // Reviews section
                _buildSection(
                  title: 'Reviews',
                  child: Column(
                    children: [
                      // Mock reviews - in a real app, these would come from a service
                      _buildReview(
                        name: 'John D.',
                        rating: 5,
                        comment: 'Amazing instructor! Very patient and great at explaining complex maneuvers. Helped me pass my test on the first try.',
                      ),
                      SizedBox(height: 16),
                      _buildReview(
                        name: 'Sarah T.',
                        rating: 5,
                        comment: 'Extremely professional and knowledgeable. Made me feel comfortable behind the wheel right from the start.',
                      ),
                    ],
                  ),
                ),
                
                // Add space for bottom bar
                SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
      
      // Bottom bar with price and book button
      bottomSheet: Container(
        height: 80,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: Offset(0, -1),
            ),
          ],
        ),
        child: Row(
          children: [
            // Price
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Price',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  '\$${instructor.price.toInt()}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'per ${instructor.duration} lesson',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            SizedBox(width: 16),
            
            // Book button
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(
                        instructor: instructor,
                        lessonDuration: instructor.duration,
                        price: instructor.price,
                      ),
                    ),
                  );
                  // Book lesson functionality would go here
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(content: Text('Booking feature coming soon!')),
                  // );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Book Lesson',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
  
  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey[600],
          size: 20,
        ),
        SizedBox(width: 12),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
  
  Widget _buildReview({
    required String name,
    required int rating,
    required String comment,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    size: 14,
                    color: index < rating ? Colors.amber : Colors.grey[300],
                  );
                }),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            comment,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}