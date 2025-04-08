 import 'package:flutter/material.dart';
import '../models/instructor.dart';
import '../services/instructor_service.dart';
import '../widgets/instructor_card.dart';
import 'filter_screen.dart';

class InstructorListScreen extends StatefulWidget {
  @override
  _InstructorListScreenState createState() => _InstructorListScreenState();
}

class _InstructorListScreenState extends State<InstructorListScreen> {
  List<Instructor> instructors = [];
  String selectedLocation = 'All Locations';
  Map<String, dynamic> filters = {};
  
  @override
  void initState() {
    super.initState();
    _loadInstructors();
  }
  
  void _loadInstructors() {
    setState(() {
      instructors = InstructorService.getInstructors(
        location: selectedLocation != 'All Locations' ? selectedLocation : null,
        minPrice: filters['minPrice'],
        maxPrice: filters['maxPrice'],
        minRating: filters['minRating'],
        sortBy: filters['sortBy'],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Instructors'),
      ),
      body: Column(
        children: [
          // Instructor count header
          Padding(
            padding: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${instructors.length} instructors',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          
          // Filter buttons
          Container(
            padding: EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildFilterButton('Price', onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FilterScreen(
                          activeTab: 'price',
                          currentFilters: filters,
                        ),
                      ),
                    );
                    
                    if (result != null) {
                      setState(() {
                        filters = result;
                        _loadInstructors();
                      });
                    }
                  }),
                  SizedBox(width: 8),
                  _buildFilterButton('Rating', onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FilterScreen(
                          activeTab: 'rating',
                          currentFilters: filters,
                        ),
                      ),
                    );
                    
                    if (result != null) {
                      setState(() {
                        filters = result;
                        _loadInstructors();
                      });
                    }
                  }),
                  SizedBox(width: 8),
                  _buildFilterButton('Location', isActive: true),
                  SizedBox(width: 8),
                  _buildFilterButton('Sort', icon: Icons.sort, onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FilterScreen(
                          activeTab: 'sort',
                          currentFilters: filters,
                        ),
                      ),
                    );
                    
                    if (result != null) {
                      setState(() {
                        filters = result;
                        _loadInstructors();
                      });
                    }
                  }),
                ],
              ),
            ),
          ),
          
          // Location filter
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: InstructorService.locations.map((location) {
                return Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: _buildLocationButton(location),
                );
              }).toList(),
            ),
          ),
          
          // Instructor list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8),
              itemCount: instructors.length,
              itemBuilder: (context, index) {
                return InstructorCard(instructor: instructors[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String title, {
    IconData? icon, 
    bool isActive = false, 
    VoidCallback? onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: isActive ? Colors.white : Colors.grey[700],
        backgroundColor: isActive ? Theme.of(context).primaryColor : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: isActive ? Colors.transparent : Colors.grey[300]!),
        ),
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16),
            SizedBox(width: 4),
          ],
          Text(title),
        ],
      ),
    );
  }

  Widget _buildLocationButton(String location) {
    final isSelected = selectedLocation == location;
    
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedLocation = location;
          _loadInstructors();
        });
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: isSelected ? Colors.white : Colors.grey[700],
        backgroundColor: isSelected ? Theme.of(context).primaryColor : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: isSelected ? Colors.transparent : Colors.grey[300]!),
        ),
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(location),
    );
  }
}