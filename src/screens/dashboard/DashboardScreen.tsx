// DashboardScreen.tsx
import React from 'react';
import { View, Text, StyleSheet } from 'react-native';

const DashboardScreen = () => {
  return (
    <View style={styles.container}>
      <Text style={styles.text}>Welcome to your Dashboard 🎉</Text>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#f2f2f2',
  },
  text: {
    fontSize: 20,
    fontWeight: 'bold',
  },
});

export default DashboardScreen;


// OnboardingStep1.tsx
import React from 'react';
import { View, Text, StyleSheet } from 'react-native';

const OnboardingStep1 = () => {
  return (
    <View style={styles.container}>
      <Text style={styles.text}>Welcome to Onboarding Step 1 🚀</Text>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#e0f7fa',
  },
  text: {
    fontSize: 20,
    fontWeight: 'bold',
  },
});

export default OnboardingStep1;
