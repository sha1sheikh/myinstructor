// src/screens/FilterScreen.js
import React, { useState, useEffect } from 'react';
import { 
  View, 
  Text, 
  StyleSheet, 
  TouchableOpacity,
  SafeAreaView,
  ScrollView,
} from 'react-native';
import Slider from '@react-native-community/slider';

const FilterScreen = ({ navigation, route }) => {
  const { activeTab = 'price', currentFilters = {} } = route.params || {};
  
  const [filters, setFilters] = useState({
    maxPrice: 100,
    minRating: 0,
    sortBy: 'rating',
    ...currentFilters
  });
  
  const [activeTabState, setActiveTabState] = useState(activeTab);

  const applyFilters = () => {
    navigation.navigate('InstructorList', { filters });
  };
  
  const renderPriceTab = () => {
    return (
      <View style={styles.tabContent}>
        <Text style={styles.sectionTitle}>Max Price</Text>
        <View style={styles.priceLabels}>
          <Text>${filters.maxPrice}</Text>
        </View>
        <Slider
          style={styles.slider}
          minimumValue={0}
          maximumValue={100}
          step={1}
          minimumTrackTintColor="#4A6FF3"
          maximumTrackTintColor="#E0E0E0"
          value={filters.maxPrice}
          onValueChange={(value) => setFilters({ ...filters, maxPrice: value })}
        />
        <Text style={styles.helperText}>
          Max Price ${filters.maxPrice} per hour
        </Text>
      </View>
    );
  };
  
  const renderRatingTab = () => {
    return (
      <View style={styles.tabContent}>
        <Text style={styles.sectionTitle}>Minimum Rating</Text>
        <View style={styles.ratingButtons}>
          {[0, 3, 3.5, 4, 4.5, 5].map((rating) => (
            <TouchableOpacity
              key={rating}
              style={[
                styles.ratingButton,
                filters.minRating === rating && styles.activeRatingButton
              ]}
              onPress={() => setFilters({ ...filters, minRating: rating })}
            >
              <Text
                style={[
                  styles.ratingButtonText,
                  filters.minRating === rating && styles.activeRatingText
                ]}
              >
                {rating === 0 ? 'Any' : rating.toString()}
                {rating > 0 && '★'}
              </Text>
            </TouchableOpacity>
          ))}
        </View>
      </View>
    );
  };
  
  const renderSortTab = () => {
    return (
      <View style={styles.tabContent}>
        <Text style={styles.sectionTitle}>Sort By</Text>
        <TouchableOpacity
          style={[
            styles.sortOption,
            filters.sortBy === 'rating' && styles.activeSortOption
          ]}
          onPress={() => setFilters({ ...filters, sortBy: 'rating' })}
        >
          <Text
            style={[
              styles.sortOptionText,
              filters.sortBy === 'rating' && styles.activeSortOptionText
            ]}
          >
            Highest Rating
          </Text>
        </TouchableOpacity>
        
        <TouchableOpacity
          style={[
            styles.sortOption,
            filters.sortBy === 'price' && styles.activeSortOption
          ]}
          onPress={() => setFilters({ ...filters, sortBy: 'price' })}
        >
          <Text
            style={[
              styles.sortOptionText,
              filters.sortBy === 'price' && styles.activeSortOptionText
            ]}
          >
            Lowest Price
          </Text>
        </TouchableOpacity>
      </View>
    );
  };
  
  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.tabBar}>
        <TouchableOpacity
          style={[
            styles.tab,
            activeTabState === 'price' && styles.activeTab
          ]}
          onPress={() => setActiveTabState('price')}
        >
          <Text
            style={[
              styles.tabText,
              activeTabState === 'price' && styles.activeTabText
            ]}
          >
            Price
          </Text>
        </TouchableOpacity>
        
        <TouchableOpacity
          style={[
            styles.tab,
            activeTabState === 'rating' && styles.activeTab
          ]}
          onPress={() => setActiveTabState('rating')}
        >
          <Text
            style={[
              styles.tabText,
              activeTabState === 'rating' && styles.activeTabText
            ]}
          >
            Rating
          </Text>
        </TouchableOpacity>
        
        <TouchableOpacity
          style={[
            styles.tab,
            activeTabState === 'sort' && styles.activeTab
          ]}
          onPress={() => setActiveTabState('sort')}
        >
          <Text
            style={[
              styles.tabText,
              activeTabState === 'sort' && styles.activeTabText
            ]}
          >
            Sort
          </Text>
        </TouchableOpacity>
      </View>
      
      <ScrollView style={styles.content}>
        {activeTabState === 'price' && renderPriceTab()}
        {activeTabState === 'rating' && renderRatingTab()}
        {activeTabState === 'sort' && renderSortTab()}
      </ScrollView>
      
      <View style={styles.footer}>
        <TouchableOpacity
          style={styles.resetButton}
          onPress={() => {
            setFilters({
              minPrice: 0,
              maxPrice: 100,
              minRating: 0,
              sortBy: 'rating'
            });
          }}
        >
          <Text style={styles.resetButtonText}>Reset</Text>
        </TouchableOpacity>
        
        <TouchableOpacity
          style={styles.applyButton}
          onPress={applyFilters}
        >
          <Text style={styles.applyButtonText}>Apply</Text>
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
  tabBar: {
    flexDirection: 'row',
    borderBottomWidth: 1,
    borderBottomColor: '#EEEEEE',
  },
  tab: {
    flex: 1,
    paddingVertical: 16,
    alignItems: 'center',
  },
  activeTab: {
    borderBottomWidth: 2,
    borderBottomColor: '#4A6FF3',
  },
  tabText: {
    fontSize: 16,
    color: '#666',
  },
  activeTabText: {
    color: '#4A6FF3',
    fontWeight: 'bold',
  },
  content: {
    flex: 1,
  },
  tabContent: {
    padding: 16,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 16,
  },
  priceLabels: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 8,
  },
  slider: {
    width: '100%',
    height: 40,
  },
  helperText: {
    marginTop: 8,
    color: '#666',
  },
  ratingButtons: {
    flexDirection: 'row',
    flexWrap: 'wrap',
  },
  ratingButton: {
    paddingHorizontal: 16,
    paddingVertical: 8,
    borderRadius: 20,
    borderWidth: 1,
    borderColor: '#E0E0E0',
    backgroundColor: 'white',
    marginRight: 8,
    marginBottom: 8,
  },
  activeRatingButton: {
    backgroundColor: '#4A6FF3',
    borderColor: '#4A6FF3',
  },
  ratingButtonText: {
    fontSize: 14,
    color: '#666',
  },
  activeRatingText: {
    color: 'white',
  },
  sortOption: {
    paddingVertical: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#EEEEEE',
  },
  activeSortOption: {
    backgroundColor: '#F0F4FF',
  },
  sortOptionText: {
    fontSize: 16,
    color: '#333',
  },
  activeSortOptionText: {
    color: '#4A6FF3',
    fontWeight: 'bold',
  },
  footer: {
    flexDirection: 'row',
    padding: 16,
    borderTopWidth: 1,
    borderTopColor: '#EEEEEE',
  },
  resetButton: {
    flex: 1,
    paddingVertical: 12,
    alignItems: 'center',
    marginRight: 8,
    borderWidth: 1,
    borderColor: '#E0E0E0',
    borderRadius: 8,
  },
  resetButtonText: {
    color: '#666',
    fontSize: 16,
  },
  applyButton: {
    flex: 2,
    paddingVertical: 12,
    alignItems: 'center',
    backgroundColor: '#4A6FF3',
    borderRadius: 8,
  },
  applyButtonText: {
    color: 'white',
    fontSize: 16,
    fontWeight: 'bold',
  },
});

export default FilterScreen;