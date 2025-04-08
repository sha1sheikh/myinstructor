import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  // Filter state variables
  RangeValues _priceRange = RangeValues(30, 80);
  double _minRating = 4.0;
  List<String> _selectedLocations = [];
  List<String> _selectedSpecialties = [];
  
  // Available filter options
  final List<String> _locations = [
    'Downtown',
    'Westside',
    'Eastside',
    'Suburbs',
    'City center',
  ];
  
  final List<String> _specialties = [
    'Beginner drivers',
    'Highway driving',
    'Manual transmission',
    'Teen drivers',
    'Senior refresher',
    'Parallel parking',
    'Defensive driving',
    'Anxiety management',
    'Test preparation',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter Instructors'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _priceRange = RangeValues(30, 80);
                _minRating = 4.0;
                _selectedLocations = [];
                _selectedSpecialties = [];
              });
            },
            child: Text(
              'Reset',
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Price Range
            _buildSectionTitle('Price Range (per hour)'),
            RangeSlider(
              values: _priceRange,
              min: 20,
              max: 100,
              divisions: 16,
              labels: RangeLabels(
                '\$${_priceRange.start.round()}',
                '\$${_priceRange.end.round()}',
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _priceRange = values;
                });
              },
            ),
            
            SizedBox(height: 24),
            
            // Minimum Rating
            _buildSectionTitle('Minimum Rating'),
            Slider(
              value: _minRating,
              min: 3.0,
              max: 5.0,
              divisions: 4,
              label: _minRating.toString(),
              onChanged: (double value) {
                setState(() {
                  _minRating = value;
                });
              },
            ),
            
            SizedBox(height: 24),
            
            // Locations
            _buildSectionTitle('Locations'),
            Wrap(
              spacing: 8,
              children: _locations.map((location) {
                final isSelected = _selectedLocations.contains(location);
                return FilterChip(
                  label: Text(location),
                  selected: isSelected,
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        _selectedLocations.add(location);
                      } else {
                        _selectedLocations.remove(location);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            
            SizedBox(height: 24),
            
            // Specialties
            _buildSectionTitle('Specialties'),
            Wrap(
              spacing: 8,
              children: _specialties.map((specialty) {
                final isSelected = _selectedSpecialties.contains(specialty);
                return FilterChip(
                  label: Text(specialty),
                  selected: isSelected,
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        _selectedSpecialties.add(specialty);
                      } else {
                        _selectedSpecialties.remove(specialty);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            
            SizedBox(height: 40),
            
            // Apply button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Create a map of the current filter settings
                  final Map<String, dynamic> filters = {
                    'priceRange': {
                      'min': _priceRange.start,
                      'max': _priceRange.end,
                    },
                    'minRating': _minRating,
                    'locations': _selectedLocations,
                    'specialties': _selectedSpecialties,
                  };
                  
                  // Return to the instructor list with filters
                  Navigator.pop(context, filters);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Apply Filters',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}