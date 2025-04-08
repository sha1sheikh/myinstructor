// src/screens/InstructorListScreen.js
import React, { useState, useEffect } from 'react';
import { 
  View, 
  Text, 
  StyleSheet, 
  FlatList, 
  TouchableOpacity, 
  ScrollView,
  SafeAreaView
} from 'react-native';
import Icon from 'react-native-vector-icons/FontAwesome';
import { getInstructors, locations } from '../services/mockData';
import InstructorCard from '../components/InstructorCard';
import FilterButton from '../components/FilterButton';

const InstructorListScreen = ({ navigation, route }) => {
  const [instructors, setInstructors] = useState([]);
  const [selectedLocation, setSelectedLocation] = useState('All Locations');
  const [filters, setFilters] = useState({});
  const [instructorCount, setInstructorCount] = useState(0);

  useEffect(() => {
    // Get filters from route params if they exist
    const routeFilters = route.params?.filters || {};
    setFilters(routeFilters);
    
    // Apply filters
    const filteredInstructors = getInstructors({
      ...routeFilters,
      location: selectedLocation !== 'All Locations' ? selectedLocation : undefined
    });
    setInstructors(filteredInstructors);
    setInstructorCount(filteredInstructors.length);
  }, [route.params, selectedLocation]);

  const renderLocationButton = (location) => {
    return (
      <FilterButton
        key={location}
        title={location}
        isActive={selectedLocation === location}
        onPress={() => setSelectedLocation(location)}
      />
    );
  };

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.instructorCount}>{instructorCount} instructors</Text>
      </View>
      
      <View style={styles.filterBar}>
        <ScrollView horizontal showsHorizontalScrollIndicator={false} contentContainerStyle={styles.filterScroll}>
          <FilterButton
            title="Price"
            onPress={() => navigation.navigate('Filter', { activeTab: 'price', currentFilters: filters })}
          />
          <FilterButton
            title="Rating"
            onPress={() => navigation.navigate('Filter', { activeTab: 'rating', currentFilters: filters })}
          />
          <FilterButton
            title="Location"
            isActive={true}
          />
          <TouchableOpacity
            style={styles.sortButton}
            onPress={() => navigation.navigate('Filter', { activeTab: 'sort', currentFilters: filters })}
          >
            <Icon name="sort" size={16} color="#333" />
            <Text style={styles.sortText}>Sort</Text>
          </TouchableOpacity>
        </ScrollView>
      </View>
      
      <ScrollView 
        horizontal 
        showsHorizontalScrollIndicator={false}
        contentContainerStyle={styles.locationScroll}
      >
        {renderLocationButton('All Locations')}
        {locations.map(location => renderLocationButton(location))}
      </ScrollView>
      
      <FlatList
        data={instructors}
        keyExtractor={(item) => item.id}
        renderItem={({ item }) => <InstructorCard instructor={item} />}
        contentContainerStyle={styles.listContent}
      />
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F8F8F8',
  },
  header: {
    paddingHorizontal: 16,
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: '#EEEEEE',
  },
  instructorCount: {
    fontSize: 24,
    fontWeight: 'bold',
  },
  filterBar: {
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: '#EEEEEE',
  },
  filterScroll: {
    paddingHorizontal: 16,
  },
  locationScroll: {
    paddingVertical: 12,
    paddingHorizontal: 16,
  },
  sortButton: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 16,
    paddingVertical: 8,
    borderRadius: 20,
    borderWidth: 1,
    borderColor: '#E0E0E0',
    backgroundColor: 'white',
  },
  sortText: {
    marginLeft: 4,
    fontSize: 14,
    color: '#333',
  },
  listContent: {
    paddingVertical: 8,
  },
});

export default InstructorListScreen;