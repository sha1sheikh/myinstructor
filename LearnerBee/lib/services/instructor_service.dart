import '../models/instructor.dart';

class InstructorService {
  static final List<Instructor> _instructors = [
    Instructor(
      id: '1',
      name: 'Michael R.',
      location: 'Downtown',
      price: 45,
      duration: '60-min',
      experience: 'Patient driving instructor with 15+ years of experience.',
      rating: 4.9,
      reviewCount: 142,
      image: 'https://randomuser.me/api/portraits/men/32.jpg',
      isFavorite: true,
    ),
    Instructor(
      id: '2',
      name: 'Sarah L.',
      location: 'East Side',
      price: 38,
      duration: '60-min',
      experience: 'Expert instructor focusing on defensive driving techniques.',
      rating: 4.7,
      reviewCount: 98,
      image: 'https://randomuser.me/api/portraits/women/44.jpg',
    ),
    Instructor(
      id: '3',
      name: 'James K.',
      location: 'West Side',
      price: 52,
      duration: '60-min',
      experience: 'Former driving examiner with perfect knowledge of test routes.',
      rating: 5.0,
      reviewCount: 76,
      image: 'https://randomuser.me/api/portraits/men/45.jpg',
    ),
  ];

  static List<String> get locations => [
    'All Locations',
    'Downtown',
    'East Side',
    'West Side',
    'North End',
    'South Side',
  ];

  static List<Instructor> getInstructors({
    String? location,
    double? minPrice,
    double? maxPrice,
    double? minRating,
    String? sortBy,
  }) {
    List<Instructor> result = List.from(_instructors);
    
    // Apply location filter
    if (location != null && location != 'All Locations') {
      result = result.where((instructor) => instructor.location == location).toList();
    }
    
    // Apply price filters
    if (minPrice != null) {
      result = result.where((instructor) => instructor.price >= minPrice).toList();
    }
    
    if (maxPrice != null) {
      result = result.where((instructor) => instructor.price <= maxPrice).toList();
    }
    
    // Apply rating filter
    if (minRating != null) {
      result = result.where((instructor) => instructor.rating >= minRating).toList();
    }
    
    // Sort results
    if (sortBy == 'price') {
      result.sort((a, b) => a.price.compareTo(b.price));
    } else if (sortBy == 'rating') {
      result.sort((a, b) => b.rating.compareTo(a.rating));
    }
    
    return result;
  }

  static Instructor getInstructorById(String id) {
    return _instructors.firstWhere((instructor) => instructor.id == id);
  }

  static void toggleFavorite(String id) {
    final index = _instructors.indexWhere((instructor) => instructor.id == id);
    if (index != -1) {
      _instructors[index].isFavorite = !_instructors[index].isFavorite;
    }
  }
}