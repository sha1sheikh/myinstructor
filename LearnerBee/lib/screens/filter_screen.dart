import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  final String activeTab;
  final Map<String, dynamic> currentFilters;
  
  FilterScreen({
    this.activeTab = 'price',
    required this.currentFilters,
  });
  
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late String activeTab;
  late Map<String, dynamic> filters;
  
  @override
  void initState() {
    super.initState();
    activeTab = widget.activeTab;
    
    // Initialize filters with defaults and current values
    filters = {
      'minPrice': 0.0,
      'maxPrice': 100.0,
      'minRating': 0.0,
      'sortBy': 'rating',
      ...widget.currentFilters,
    };
    
    // Ensure numeric values are doubles
    filters['minPrice'] = filters['minPrice']?.toDouble() ?? 0.0;
    filters['maxPrice'] = filters['maxPrice']?.toDouble() ?? 100.0;
    filters['minRating'] = filters['minRating']?.toDouble() ?? 0.0;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
      ),
      body: Column(
        children: [
          // Tab bar
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Row(
              children: [
                _buildTabButton('Price', 'price'),
                _buildTabButton('Rating', 'rating'),
                _buildTabButton('Sort', 'sort'),
              ],
            ),
          ),
          
          // Tab content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: _buildActiveTabContent(),
            ),
          ),
          
          // Action buttons
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    onPressed: _resetFilters,
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('Reset'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, filters);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Apply',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTabButton(String title, String tabKey) {
    final isActive = activeTab == tabKey;
    
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            activeTab = tabKey;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive ? Theme.of(context).primaryColor : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isActive ? Theme.of(context).primaryColor : Colors.grey[700],
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
  
  Widget _buildActiveTabContent() {
    switch (activeTab) {
      case 'price':
        return _buildPriceTab();
      case 'rating':
        return _buildRatingTab();
      case 'sort':
        return _buildSortTab();
      default:
        return SizedBox.shrink();
    }
  }
  
  Widget _buildPriceTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price Range',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('\$${filters['minPrice'].toInt()}'),
            Text('\$${filters['maxPrice'].toInt()}'),
          ],
        ),
        SizedBox(height: 8),
        RangeSlider(
          min: 0,
          max: 100,
          divisions: 100,
          values: RangeValues(
            filters['minPrice'].toDouble(),
            filters['maxPrice'].toDouble(),
          ),
          activeColor: Theme.of(context).primaryColor,
          inactiveColor: Colors.grey[300],
          onChanged: (RangeValues values) {
            setState(() {
              filters['minPrice'] = values.start;
              filters['maxPrice'] = values.end;
            });
          },
        ),
        SizedBox(height: 8),
        Text(
          'Price range: \$${filters['minPrice'].toInt()} - \$${filters['maxPrice'].toInt()} per hour',
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
  
  Widget _buildRatingTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Minimum Rating',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [0.0, 3.0, 3.5, 4.0, 4.5, 5.0].map((rating) {
            final isSelected = filters['minRating'] == rating;
            
            return ElevatedButton(
              onPressed: () {
                setState(() {
                  filters['minRating'] = rating;
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
              child: Text(
                rating == 0 ? 'Any' : '$rating★',
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
  
  Widget _buildSortTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sort By',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        _buildSortOption('rating', 'Highest Rating'),
        _buildSortOption('price', 'Lowest Price'),
      ],
    );
  }
  
  Widget _buildSortOption(String value, String label) {
    final isSelected = filters['sortBy'] == value;
    
    return InkWell(
      onTap: () {
        setState(() {
          filters['sortBy'] = value;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[300]!),
          ),
          color: isSelected ? Color(0xFFF0F4FF) : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? Theme.of(context).primaryColor : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
  
  void _resetFilters() {
    setState(() {
      filters = {
        'minPrice': 0.0,
        'maxPrice': 100.0,
        'minRating': 0.0,
        'sortBy': 'rating',
      };
    });
  }
}