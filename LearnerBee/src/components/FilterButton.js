// src/components/FilterButton.js
import React from 'react';
import { TouchableOpacity, Text, StyleSheet } from 'react-native';

const FilterButton = ({ title, onPress, isActive = false }) => {
  return (
    <TouchableOpacity
      style={[
        styles.button,
        isActive ? styles.activeButton : styles.inactiveButton
      ]}
      onPress={onPress}
    >
      <Text
        style={[
          styles.buttonText,
          isActive ? styles.activeText : styles.inactiveText
        ]}
      >
        {title}
      </Text>
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  button: {
    paddingHorizontal: 16,
    paddingVertical: 8,
    borderRadius: 20,
    marginRight: 8,
    borderWidth: 1,
  },
  activeButton: {
    backgroundColor: '#4A6FF3',
    borderColor: '#4A6FF3',
  },
  inactiveButton: {
    backgroundColor: 'white',
    borderColor: '#E0E0E0',
  },
  buttonText: {
    fontSize: 14,
  },
  activeText: {
    color: 'white',
  },
  inactiveText: {
    color: '#666',
  },
});

export default FilterButton;