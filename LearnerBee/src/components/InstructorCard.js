// src/components/InstructorCard.js
import React from 'react';
import { View, Text, StyleSheet, Image, TouchableOpacity } from 'react-native';
import Icon from 'react-native-vector-icons/FontAwesome';
import { useNavigation } from '@react-navigation/native';
import { toggleFavorite } from '../services/mockData';

const InstructorCard = ({ instructor }) => {
  const navigation = useNavigation();
  const [isFavorite, setIsFavorite] = React.useState(instructor.isFavorite);

  const handleFavoritePress = () => {
    const newState = toggleFavorite(instructor.id);
    setIsFavorite(newState);
  };

  return (
    <TouchableOpacity 
      style={styles.card}
      onPress={() => navigation.navigate('InstructorDetail', { instructorId: instructor.id })}
    >
      <View style={styles.rowContainer}>
        <Image source={{ uri: instructor.image }} style={styles.image} />
        
        <View style={styles.infoContainer}>
          <View style={styles.headerRow}>
            <Text style={styles.name}>{instructor.name}</Text>
            <TouchableOpacity onPress={handleFavoritePress}>
              <Icon 
                name={isFavorite ? "heart" : "heart-o"} 
                size={24} 
                color={isFavorite ? "#4A6FF3" : "#8E8E8E"} 
              />
            </TouchableOpacity>
          </View>
          
          <Text style={styles.location}>{instructor.location}</Text>
          
          <View style={styles.priceRow}>
            <Text style={styles.price}>${instructor.price}</Text>
            <Text style={styles.duration}>{instructor.duration}</Text>
          </View>
          
          <Text style={styles.experience} numberOfLines={2}>
            {instructor.experience}
          </Text>
        </View>
      </View>
      
      <View style={styles.ratingContainer}>
        <Text style={styles.ratingNumber}>{instructor.rating}</Text>
        <Icon name="star" size={16} color="#FFD700" />
        <Text style={styles.reviewCount}>({instructor.reviewCount})</Text>
      </View>
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  card: {
    backgroundColor: 'white',
    borderRadius: 8,
    padding: 16,
    marginVertical: 8,
    marginHorizontal: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 2,
  },
  rowContainer: {
    flexDirection: 'row',
  },
  image: {
    width: 80,
    height: 80,
    borderRadius: 40,
    marginRight: 16,
  },
  infoContainer: {
    flex: 1,
  },
  headerRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 4,
  },
  name: {
    fontSize: 18,
    fontWeight: 'bold',
  },
  location: {
    fontSize: 14,
    color: '#666',
    marginBottom: 8,
  },
  priceRow: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 8,
  },
  price: {
    fontSize: 18,
    fontWeight: 'bold',
    marginRight: 8,
  },
  duration: {
    fontSize: 14,
    color: '#666',
  },
  experience: {
    fontSize: 14,
    color: '#333',
    lineHeight: 20,
  },
  ratingContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'flex-end',
    marginTop: 8,
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
});

export default InstructorCard;