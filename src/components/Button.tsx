import React from 'react';
import { TouchableOpacity, Text, View, StyleSheet } from 'react-native';

interface ButtonProps {
  onPress: () => void;
  text: string;
  fullWidth?: boolean; // If true, the button will be full-width (for Next)
  style?: object;
}

const Button: React.FC<ButtonProps> = ({ onPress, text, fullWidth = false, style }) => {
  return (
    <View style={[fullWidth ? styles.fullWidthContainer : styles.container, style]}>
      <TouchableOpacity onPress={onPress} style={fullWidth ? styles.fullWidthButton : styles.backButton}>
        <Text style={fullWidth ? styles.fullWidthButtonText : styles.backButtonText}>
          {text}
        </Text>
      </TouchableOpacity>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    alignItems: 'flex-start', 
  },
  fullWidthContainer: {
    width: '100%',
    marginTop: 20,
  },
  fullWidthButton: {
    backgroundColor: '#007bff',
    padding: 15,
    borderRadius: 10,
    alignItems: 'center',
  },
  fullWidthButtonText: {
    color: '#fff',
    fontWeight: '600',
    fontSize: 16,
  },
  backButton: {
    paddingVertical: 10,
  },
  backButtonText: {
    color: '#007bff',
    fontSize: 16,
    textDecorationLine: 'underline',
  },
});

export default Button;
