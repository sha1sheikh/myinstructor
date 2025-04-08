// src/navigation/AppNavigator.js
import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';

// Import your screens here
import HomeScreen from '../screens/HomeScreen';
import InstructorListScreen from '../screens/InstructorListScreen';
import InstructorDetailScreen from '../screens/InstructorDetailScreen';
import FilterScreen from '../screens/FilterScreen';

const Stack = createStackNavigator();

const AppNavigator = () => {
  return (
    <NavigationContainer>
      <Stack.Navigator initialRouteName="Home">
        <Stack.Screen 
          name="Home" 
          component={HomeScreen} 
          options={{ title: 'Driving Instructor App' }} 
        />
        <Stack.Screen 
          name="InstructorList" 
          component={InstructorListScreen} 
          options={{ title: 'Find Instructors' }} 
        />
        <Stack.Screen 
          name="InstructorDetail" 
          component={InstructorDetailScreen} 
          options={{ title: 'Instructor Profile' }} 
        />
        <Stack.Screen 
          name="Filter" 
          component={FilterScreen} 
          options={{ title: 'Filter Instructors' }} 
        />
      </Stack.Navigator>
    </NavigationContainer>
  );
};

export default AppNavigator;