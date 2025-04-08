// App.tsx
import React from 'react';
import 'react-native-gesture-handler';
import { LogBox } from 'react-native';
import AppNavigator from './src/navigation/AppNavigator';

// Ignore specific warnings if needed during development
LogBox.ignoreLogs([
  'Reanimated 2',
  'VirtualizedLists should never be nested',
]);

const App: React.FC = () => {
  return <AppNavigator />;
};

export default App;