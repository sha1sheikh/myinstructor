// src/screens/InstructorDetailScreen.js
import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  StyleSheet,
  Image,
  ScrollView,
  TouchableOpacity,
  SafeAreaView,
} from 'react-native';
import Icon from 'react-native-vector-icons/FontAwesome';
import { instructors, toggleFavorite } from '../services/mockData';

const InstructorDetailScreen = ({ route }) => {
  const { instructorId } = route.params;
  const [instructor, setInstructor] = useState(null);
  const [isFavorite, setIsFavorite] = useState(false);

  useEffect(() => {
    // Get instructor details from mock data
    const foundInstructor = instructors.find(i => i.id === instructorId);
    if (foundInstructor) {
      setInstructor(foundInstructor);
      setIsFavorite(foundInstructor.isFavorite);
    }
  }, [instructorId]);

  const handleFavoritePress = () => {
    const newState = toggleFavorite(instructorId);
    setIsFavorite(newState);
  };

  if (!instructor) {
    return (
      <View style={styles.loadingContainer}>
        <Text>Loading instructor details...</Text>
      </View>
    );
  }

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView>
        <View style={styles.profileHeader}>
          <Image source={{ uri: instructor.image }} style={styles.profileImage} />
          
          <View style={styles.nameContainer}>
            <Text style={styles.name}>{instructor.name}</Text>
            <Text style={styles.location}>{instructor.location}</Text>
            
            <View style={styles.ratingContainer}>
              <Text style={styles.ratingNumber}>{instructor.rating}</Text>
              <Icon name="star" size={16} color="#FFD700" />
              <Text style={styles.reviewCount}>({instructor.reviewCount} reviews)</Text>
            </View>
          </View>
          
          <TouchableOpacity 
            style={styles.favoriteButton}
            onPress={handleFavoritePress}
          >
            <Icon 
              name={isFavorite ? "heart" : "heart-o"} 
              size={24} 
              color={isFavorite ? "#4A6FF3" : "#8E8E8E"} 
            />
          </TouchableOpacity>
        </View>
        
        <View style={styles.infoSection}>
          <Text style={styles.sectionTitle}>About</Text>
          <Text style={styles.experienceText}>
            {instructor.experience}
          </Text>
        </View>
        
        <View style={styles.infoSection}>
          <Text style={styles.sectionTitle}>Lesson Details</Text>
          
          <View style={styles.detailRow}>
            <Icon name="clock-o" size={20} color="#666" style={styles.detailIcon} />
            <Text style={styles.detailText}>
              {instructor.duration} lessons
            </Text>
          </View>
          
          <View style={styles.detailRow}>
            <Icon name="credit-card" size={20} color="#666" style={styles.detailIcon} />
            <Text style={styles.detailText}>
              ${instructor.price} per lesson
            </Text>
          </View>
          
          <View style={styles.detailRow}>
            <Icon name="map-marker" size={20} color="#666" style={styles.detailIcon} />
            <Text style={styles.detailText}>
              Serves {instructor.location} area
            </Text>
          </View>
        </View>
        
        <View style={styles.reviewsSection}>
          <Text style={styles.sectionTitle}>Reviews</Text>
          
          {/* Placeholder for reviews - would be dynamic in a real app */}
          <View style={styles.reviewItem}>
            <View style={styles.reviewHeader}>
              <Text style={styles.reviewName}>John D.</Text>
              <View style={styles.reviewRating}>
                <Icon name="star" size={14} color="#FFD700" />
                <Icon name="star" size={14} color="#FFD700" />
                <Icon name="star" size={14} color="#FFD700" />
                <Icon name="star" size={14} color="#FFD700" />
                <Icon name="star" size={14} color="#FFD700" />
              </View>
            </View>
            <Text style={styles.reviewText}>
              Amazing instructor! Very patient and great at explaining complex maneuvers.
              Helped me pass my test on the first try.
            </Text>
          </View>
          
          <View style={styles.reviewItem}>
            <View style={styles.reviewHeader}>
              <Text style={styles.reviewName}>Sarah T.</Text>
              <View style={styles.reviewRating}>
                <Icon name="star" size={14} color="#FFD700" />
                <Icon name="star" size={14} color="#FFD700" />
                <Icon name="star" size={14} color="#FFD700" />
                <Icon name="star" size={14} color="#FFD700" />
                <Icon name="star" size={14} color="#FFD700" />
              </View>
            </View>
            <Text style={styles.reviewText}>
              Extremely professional and knowledgeable. Made me feel comfortable
              behind the wheel right from the start.
            </Text>
          </View>
        </View>
      </ScrollView>
      
      <View style={styles.bottomBar}>
        <View style={styles.priceContainer}>
          <Text style={styles.priceLabel}>Price</Text>
          <Text style={styles.price}>${instructor.price}</Text>
          <Text style={styles.pricePer}>per {instructor.duration} lesson</Text>
        </View>
        
        <TouchableOpacity style={styles.bookButton}>
          <Text style={styles.bookButtonText}>Book Lesson</Text>
        </TouchableOpacity>
      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F8F8F8',
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  profileHeader: {
    flexDirection: 'row',
    padding: 16,
    backgroundColor: 'white',
    borderBottomWidth: 1,
    borderBottomColor: '#EEEEEE',
  },
  profileImage: {
    width: 80,
    height: 80,
    borderRadius: 40,
  },
  nameContainer: {
    flex: 1,
    marginLeft: 16,
    justifyContent: 'center',
  },
  name: {
    fontSize: 22,
    fontWeight: 'bold',
    marginBottom: 4,
  },
  location: {
    fontSize: 16,
    color: '#666',
    marginBottom: 4,
  },
  ratingContainer: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  ratingNumber: {
    fontSize: 16,
    fontWeight: 'bold',
    marginRight: 4,
  },
  reviewCount: {
    fontSize: 14,
    color: '#666',
    marginLeft: 4,
  },
  favoriteButton: {
    padding: 8,
  },
  infoSection: {
    padding: 16,
    backgroundColor: 'white',
    marginTop: 12,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 12,
  },
  experienceText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },
  detailRow: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  detailIcon: {
    width: 24,
    marginRight: 12,
  },
  detailText: {
    fontSize: 16,
    color: '#333',
  },
  reviewsSection: {
    padding: 16,
    backgroundColor: 'white',
    marginTop: 12,
    marginBottom: 80, // Add space for the bottom bar
  },
  reviewItem: {
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: '#EEEEEE',
  },
  reviewHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 8,
  },
  reviewName: {
    fontSize: 16,
    fontWeight: 'bold',
  },
  reviewRating: {
    flexDirection: 'row',
  },
  reviewText: {
    fontSize: 14,
    lineHeight: 20,
    color: '#333',
  },
  bottomBar: {
    position: 'absolute',
    bottom: 0,
    left: 0,
    right: 0,
    flexDirection: 'row',
    padding: 16,
    backgroundColor: 'white',
    borderTopWidth: 1,
    borderTopColor: '#EEEEEE',
    alignItems: 'center',
  },
  priceContainer: {
    flex: 1,
  },
  priceLabel: {
    fontSize: 12,
    color: '#666',
  },
  price: {
    fontSize: 20,
    fontWeight: 'bold',
  },
  pricePer: {
    fontSize: 12,
    color: '#666',
  },
  bookButton: {
    backgroundColor: '#4A6FF3',
    paddingVertical: 12,
    paddingHorizontal: 24,
    borderRadius: 8,
  },
  bookButtonText: {
    color: 'white',
    fontSize: 16,
    fontWeight: 'bold',
  },
});

export default InstructorDetailScreen;