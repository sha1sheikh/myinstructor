// src/services/mockData.js
export const instructors = [
    {
      id: '1',
      name: 'Michael R.',
      location: 'Downtown',
      price: 45,
      duration: '60-min',
      experience: 'Patient driving instructor with 15+ years of experience.',
      rating: 4.9,
      reviewCount: 142,
      isFavorite: true,
      image: 'https://randomuser.me/api/portraits/men/32.jpg'
    },
    {
      id: '2',
      name: 'Sarah L.',
      location: 'East Side',
      price: 38,
      duration: '60-min',
      experience: 'Expert instructor focusing on defensive driving techniques.',
      rating: 4.7,
      reviewCount: 98,
      isFavorite: false,
      image: 'https://randomuser.me/api/portraits/women/44.jpg'
    },
    {
      id: '3',
      name: 'James K.',
      location: 'West Side',
      price: 52,
      duration: '60-min',
      experience: 'Former driving examiner with perfect knowledge of test routes.',
      rating: 5.0,
      reviewCount: 76,
      isFavorite: false,
      image: 'https://randomuser.me/api/portraits/men/45.jpg'
    },
    {
      id: '4',
      name: 'Emma P.',
      location: 'North End',
      price: 40,
      duration: '60-min',
      experience: 'Specialized in helping nervous beginners feel comfortable.',
      rating: 4.8,
      reviewCount: 112,
      isFavorite: false,
      image: 'https://randomuser.me/api/portraits/women/22.jpg'
    },
    {
      id: '5',
      name: 'David T.',
      location: 'South Side',
      price: 42,
      duration: '60-min',
      experience: 'Multilingual instructor with focus on international drivers.',
      rating: 4.6,
      reviewCount: 89,
      isFavorite: false,
      image: 'https://randomuser.me/api/portraits/men/67.jpg'
    },
  ];
  
  export const locations = [
    'Downtown',
    'East Side',
    'West Side',
    'North End',
    'South Side',
    'Suburbs',
    'City Center'
  ];
  
  // API Service Simulation
  export const getInstructors = (filters = {}) => {
    let result = [...instructors];
    
    // Apply location filter
    if (filters.location && filters.location !== 'All Locations') {
      result = result.filter(instructor => instructor.location === filters.location);
    }
    
    // Apply price filter
    if (filters.minPrice !== undefined) {
      result = result.filter(instructor => instructor.price >= filters.minPrice);
    }
    
    if (filters.maxPrice !== undefined) {
      result = result.filter(instructor => instructor.price <= filters.maxPrice);
    }
    
    // Apply rating filter
    if (filters.minRating !== undefined) {
      result = result.filter(instructor => instructor.rating >= filters.minRating);
    }
    
    // Sort by rating (highest first)
    if (filters.sortBy === 'rating') {
      result.sort((a, b) => b.rating - a.rating);
    }
    // Sort by price (lowest first)
    else if (filters.sortBy === 'price') {
      result.sort((a, b) => a.price - b.price);
    }
    
    return result;
  };
  
  export const toggleFavorite = (id) => {
    const index = instructors.findIndex(instructor => instructor.id === id);
    if (index !== -1) {
      instructors[index].isFavorite = !instructors[index].isFavorite;
      return instructors[index].isFavorite;
    }
    return false;
  };