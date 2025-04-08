// src/screens/HomeScreen.js
import React from 'react';
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  Image,
  SafeAreaView,
  StatusBar,
} from 'react-native';
import Icon from 'react-native-vector-icons/FontAwesome';

const HomeScreen = ({ navigation }) => {
  return (
    <SafeAreaView style={styles.container}>
      <StatusBar barStyle="dark-content" backgroundColor="#fff" />
      
      <View style={styles.header}>
        <Text style={styles.logo}>DriveMate</Text>
      </View>
      
      <View style={styles.heroSection}>
        <Text style={styles.heroTitle}>Find your perfect driving instructor</Text>
        <Text style={styles.heroSubtitle}>
          Connect with experienced instructors in your area and book lessons with ease
        </Text>
        
        <TouchableOpacity
          style={styles.ctaButton}
          onPress={() => navigation.navigate('InstructorList')}
        >
          <Text style={styles.ctaButtonText}>Find Instructors</Text>
          <Icon name="arrow-right" size={16} color="#fff" style={styles.ctaIcon} />
        </TouchableOpacity>
      </View>
      
      <View style={styles.featuresSection}>
        <View style={styles.featureItem}>
          <View style={styles.featureIconContainer}>
            <Icon name="search" size={24} color="#4A6FF3" />
          </View>
          <Text style={styles.featureTitle}>Browse Instructors</Text>
          <Text style={styles.featureDescription}>
            View profiles, ratings, and pricing to find your perfect match
          </Text>
        </View>
        
        <View style={styles.featureItem}>
          <View style={styles.featureIconContainer}>
            <Icon name="calendar" size={24} color="#4A6FF3" />
          </View>
          <Text style={styles.featureTitle}>Book Lessons</Text>
          <Text style={styles.featureDescription}>
            Schedule lessons directly through the app
          </Text>
        </View>
        
        <View style={styles.featureItem}>
          <View style={styles.featureIconContainer}>
            <Icon name="star" size={24} color="#4A6FF3" />
          </View>
          <Text style={styles.featureTitle}>Rate & Review</Text>
          <Text style={styles.featureDescription}>
            Share your experience with other learners
          </Text>
        </View>
      </View>
      
      <View style={styles.bottomNav}>
        <TouchableOpacity style={styles.navItem}>
          <Icon name="home" size={24} color="#4A6FF3" />
          <Text style={[styles.navText, styles.activeNavText]}>Home</Text>
        </TouchableOpacity>
        
        <TouchableOpacity 
          style={styles.navItem}
          onPress={() => navigation.navigate('InstructorList')}
        >
          <Icon name="search" size={24} color="#999" />
          <Text style={styles.navText}>Search</Text>
        </TouchableOpacity>
        
        <TouchableOpacity style={styles.navItem}>
          <Icon name="bookmark-o" size={24} color="#999" />
          <Text style={styles.navText}>Saved</Text>
        </TouchableOpacity>
        
        <TouchableOpacity style={styles.navItem}>
          <Icon name="user-o" size={24} color="#999" />
          <Text style={styles.navText}>Profile</Text>
        </TouchableOpacity>
      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
  },
  header: {
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#EEEEEE',
  },
  logo: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#4A6FF3',
  },
  heroSection: {
    padding: 24,
    backgroundColor: '#F8F8F8',
  },
  heroTitle: {
    fontSize: 28,
    fontWeight: 'bold',
    marginBottom: 12,
    color: '#333',
  },
  heroSubtitle: {
    fontSize: 16,
    color: '#666',
    lineHeight: 24,
    marginBottom: 24,
  },
  ctaButton: {
    backgroundColor: '#4A6FF3',
    paddingVertical: 14,
    paddingHorizontal: 20,
    borderRadius: 8,
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
  },
  ctaButtonText: {
    color: 'white',
    fontSize: 16,
    fontWeight: 'bold',
  },
  ctaIcon: {
    marginLeft: 8,
  },
  featuresSection: {
    padding: 24,
  },
  featureItem: {
    marginBottom: 24,
  },
  featureIconContainer: {
    width: 48,
    height: 48,
    borderRadius: 24,
    backgroundColor: '#F0F4FF',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 12,
  },
  featureTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 8,
    color: '#333',
  },
  featureDescription: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },
  bottomNav: {
    flexDirection: 'row',
    borderTopWidth: 1,
    borderTopColor: '#EEEEEE',
    position: 'absolute',
    bottom: 0,
    left: 0,
    right: 0,
    backgroundColor: 'white',
  },
  navItem: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    paddingVertical: 12,
  },
  navText: {
    fontSize: 12,
    marginTop: 4,
    color: '#999',
  },
  activeNavText: {
    color: '#4A6FF3',
  },
});

export default HomeScreen;