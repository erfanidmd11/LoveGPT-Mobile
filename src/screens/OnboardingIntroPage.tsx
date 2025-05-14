import React, { useState } from 'react';
import { View, Text, TextInput, TouchableOpacity, StyleSheet, Alert, KeyboardAvoidingView, Platform } from 'react-native';
import { useNavigation } from '@react-navigation/native';

const OnboardingPage: React.FC = () => {
  const [name, setName] = useState('');
  const [loading, setLoading] = useState(false);
  const navigation = useNavigation();

  const handleNextStep = () => {
    if (!name || name.length < 3) {
      Alert.alert('Name is too short!', 'Please enter a valid name.');
      return;
    }

    setLoading(true);

    // Mock the onboarding completion (replace with actual process)
    setTimeout(() => {
      setLoading(false);
      Alert.alert('Onboarding Complete!', 'You are one step closer to meaningful connections.');
      navigation.navigate('Step1'); // Move to the next step in onboarding
    }, 1500);
  };

  return (
    <KeyboardAvoidingView behavior={Platform.OS === 'ios' ? 'padding' : 'height'} style={styles.container}>
      <Text style={styles.title}>Let’s Begin the Journey to Self-Discovery, Shall We?</Text>

      <Text style={styles.subtitle}>
        Before we dive into the magic of relationships, let me tell you something ARIA knows: you can't truly connect with others if you don’t connect with yourself first.
      </Text>
      
      <Text style={styles.subtitle}>
        Most dating apps drop you into a shallow pool of swipes and bios. Not here. LoveGPT is not just an app — it’s your journey of transformation.
      </Text>

      <Text style={styles.subtitle}>
        Before you can love someone deeply and consciously, you must first truly understand and love yourself. That’s what this onboarding process is about. 
      </Text>
      
      <Text style={styles.subtitle}>
        ARIA, your intelligent companion, will guide you step by step from self-discovery to building meaningful relationships — on your own terms. She learns you. She remembers. She evolves with you.
      </Text>

      <Text style={styles.subtitle}>
        On Step 12, you’ll already have a basic but powerful profile of who you are — your patterns, your values, your communication style, and more. And from there, the real magic begins.
      </Text>

      <Text style={styles.subtitle}>
        Think of ARIA as your confidant, your best friend, your therapist, your wingwoman, your Tony Robbins, and then some. She doesn’t just give advice — she reflects back to you your deepest truths, without judgment.
      </Text>

      <Text style={styles.subtitle}>
        Your data is safe. Your secrets are sacred. ARIA never shares or sells your personal insights. You are in a vault — with a key that only you hold.
      </Text>

      <Text style={styles.subtitle}>
        We ask only one thing: be honest, be present, and have the courage to meet yourself. Because love — real love — starts with you.
      </Text>

      <Text style={styles.subtitle}>So, let’s start with the basics... what's your name?</Text>

      <TextInput
        style={styles.input}
        placeholder="Your name"
        value={name}
        onChangeText={setName}
      />

      <TouchableOpacity style={styles.button} onPress={handleNextStep} disabled={loading}>
        {loading ? (
          <Text style={styles.buttonText}>Hold tight... ARIA is processing!</Text>
        ) : (
          <Text style={styles.buttonText}>Next Step, Let's Go!</Text>
        )}
      </TouchableOpacity>
    </KeyboardAvoidingView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    padding: 24,
    backgroundColor: '#fff',
  },
  title: {
    fontSize: 24,
    fontWeight: '700',
    textAlign: 'center',
    marginBottom: 16,
  },
  subtitle: {
    fontSize: 16,
    textAlign: 'center',
    marginBottom: 24,
    color: '#666',
  },
  input: {
    borderWidth: 1,
    borderColor: '#ccc',
    padding: 12,
    borderRadius: 8,
    marginBottom: 20,
    fontSize: 16,
  },
  button: {
    backgroundColor: '#6200ee',
    padding: 16,
    borderRadius: 8,
    alignItems: 'center',
  },
  buttonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: '500',
  },
});

export default OnboardingPage;
