import React, { useState } from 'react';
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  StyleSheet,
  Keyboard,
  Pressable,
  KeyboardAvoidingView,
  Platform,
} from 'react-native';
import { useNavigation } from '@react-navigation/native';
import BackButton from '@/components/common/BackButton';
// import { validateReferralCode } from '../firebase/admin'; // Uncomment if using real validation

export default function InvitationEntryScreen() {
  const [code, setCode] = useState('');
  const [error, setError] = useState('');
  const navigation = useNavigation();

  const handleContinue = async () => {
    if (!code.trim()) {
      setError('Invitation code is required');
      return;
    }

    const cleanedCode = code.trim().toLowerCase();

    // 🔁 Simulated validation (replace with real logic if needed)
    const isValid = cleanedCode === 'sample123';

    // ✅ Optional: Use Firestore validation instead
    // const isValid = await validateReferralCode(cleanedCode);

    if (isValid) {
      navigation.navigate('Onboarding', { referredBy: cleanedCode });
    } else {
      setError('Invalid invitation code. Please try again.');
    }
  };

  const handleJoinWaitlist = () => {
    navigation.navigate('WaitlistRequest');
  };

  return (
    <Pressable onPress={Keyboard.dismiss} accessible={false}>
      <KeyboardAvoidingView
        behavior={Platform.OS === 'ios' ? 'padding' : undefined}
        style={{ flex: 1 }}
      >
        <View style={styles.container}>
          <View style={styles.inner}>
            <Text style={styles.title}>Enter Invitation Code</Text>

            <TextInput
              style={[styles.input, error && styles.errorInput]}
              placeholder="Invitation Code"
              placeholderTextColor="#555"
              autoCapitalize="none"
              value={code}
              onChangeText={(text) => {
                setCode(text);
                setError('');
              }}
            />

            {error && <Text style={styles.errorText}>{error}</Text>}

            <TouchableOpacity style={styles.button} onPress={handleContinue}>
              <Text style={styles.buttonText}>Continue</Text>
            </TouchableOpacity>

            <TouchableOpacity onPress={handleJoinWaitlist}>
              <Text style={styles.linkText}>Don't have a code? Join the waitlist</Text>
            </TouchableOpacity>
          </View>

          {navigation.canGoBack() && <BackButton />}
        </View>
      </KeyboardAvoidingView>
    </Pressable>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'space-between',
    padding: 24,
    backgroundColor: '#f9f9fc',
  },
  inner: {
    flex: 1,
    justifyContent: 'center',
  },
  title: {
    fontSize: 24,
    fontWeight: '600',
    marginBottom: 20,
    textAlign: 'center',
    color: '#222',
  },
  input: {
    backgroundColor: '#fff',
    borderColor: '#ccc',
    borderWidth: 1.3,
    borderRadius: 12,
    padding: 14,
    fontSize: 16,
    color: '#111',
  },
  errorInput: {
    borderColor: 'red',
  },
  errorText: {
    marginTop: 6,
    color: 'red',
    fontSize: 12,
  },
  button: {
    backgroundColor: '#007bff',
    marginTop: 20,
    padding: 15,
    borderRadius: 12,
    alignItems: 'center',
  },
  buttonText: {
    color: '#fff',
    fontWeight: '700',
    fontSize: 16,
  },
  linkText: {
    marginTop: 25,
    textAlign: 'center',
    fontSize: 14,
    color: '#007bff',
    textDecorationLine: 'underline',
  },
});
