import React, { useEffect, useState } from 'react';
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  StyleSheet,
  Keyboard,
  Pressable,
  Alert,
  ActivityIndicator,
  Platform,
} from 'react-native';
import { auth, db } from '../firebase/firebaseConfig';
import { doc, getDoc, setDoc, Timestamp } from 'firebase/firestore';
import { ConfirmationResult, User, signInWithPhoneNumber } from 'firebase/auth';
import onboardingMemory from '@/lib/onboardingMemory';
import { useNavigation } from '@react-navigation/native';

interface OTPVerificationScreenProps {
  route: {
    params: {
      confirmation?: ConfirmationResult;
      phone: string;
    };
  };
}

export default function OTPVerificationScreen({ route }: OTPVerificationScreenProps) {
  const { confirmation: initialConfirmation, phone } = route.params || {};
  const [confirmation, setConfirmation] = useState<ConfirmationResult | undefined>(initialConfirmation);
  const [code, setCode] = useState('');
  const [canResend, setCanResend] = useState(false);
  const [verifying, setVerifying] = useState(false);
  const [resending, setResending] = useState(false);
  const navigation = useNavigation();

  useEffect(() => {
    const timer = setTimeout(() => setCanResend(true), 30000);
    return () => clearTimeout(timer);
  }, []);

  const cleanPhone = (raw: string) => raw.replace(/\s+/g, '').replace(/^\++/, '+');

  const getStepScreenName = (step: number): string => {
    const stepMap: Record<number, string> = {
      1: 'Step1InvitationCode',
      2: 'Step2Name',
      3: 'Step3Email',
      4: 'Step4DOB',
      5: 'Step5Location',
      6: 'Step6Gender',
      7: 'Step7RelationshipStatus',
      8: 'Step8Intentions',
      9: 'Step9Readiness',
      10: 'Step10CoreValues',
      11: 'Step11Personality',
      12: 'Step12ProfileReflection',
      13: 'Step13Enneagram',
      14: 'Step14DISC',
      15: 'Step15CoreValueIndex',
      16: 'Step16BigFive',
      17: 'Step17AIConsent',
      18: 'Step18Parenthood',
      19: 'Step19LoveLanguages',
      20: 'Step20InnerConflictStyle',
      21: 'Step21CommunicationStyle',
      22: 'Step22Lifestyle',
      23: 'Step23DealBreakers',
      24: 'Step24ConflictStyle',
      25: 'Step25AttachmentStyle',
      26: 'Step26FinancialPhilosophy',
      27: 'Step27ConflictResolution',
      28: 'Step28PartnershipDynamic',
      29: 'Step29EmotionalTriggers',
      30: 'Step30ConditioningBeliefs',
      31: 'Step31OpennessLevel',
      32: 'Step32ProfileSetup',
    };
    return stepMap[step] || 'Step2Name';
  };

  const handleVerify = async () => {
    if (code.length !== 6) {
      Alert.alert('Invalid Code', 'Please enter the full 6-digit code.');
      return;
    }

    setVerifying(true);

    try {
      let user: User;

      if (__DEV__ || phone === '+1555555555') {
        if (code !== '123456') throw new Error('Mock: Invalid code.');
        user = {
          uid: `test-${phone}`,
          phoneNumber: phone,
        } as User;
      } else if (confirmation?.confirm) {
        const result = await confirmation.confirm(code);
        user = result.user;
      } else {
        throw new Error('⚠️ OTP verification object is missing or invalid.');
      }

      if (!user) {
        Alert.alert('Error', 'User not found after verification.');
        return;
      }

      const phoneNumber = cleanPhone(user.phoneNumber || '');
      const uid = user.uid;
      onboardingMemory.uid = uid;

      const userRef = doc(db, 'users', uid);
      const userSnap = await getDoc(userRef);

      if (userSnap.exists()) {
        const userData = userSnap.data();
        const onboardingStep = userData?.onboardingStep;

        if (userData?.pending18) {
          navigation.replace('Pending18Screen', { uid });
          return;
        }

        const nextStep = getStepScreenName(onboardingStep || 1);
        navigation.replace(nextStep, { uid });
      } else {
        await setDoc(userRef, {
          uid,
          phone: phoneNumber,
          createdAt: Timestamp.now(),
          referralCode: null,
          referredBy: null,
          referralPath: [],
          referrals: [],
          onboardingStep: 1,
          onboardingComplete: false,
          startedAt: Timestamp.now(),
        });

        navigation.replace('Step1InvitationCode', { uid });
      }
    } catch (error: any) {
      console.error('OTP Confirm Error:', error);
      Alert.alert('Verification Failed', error.message || 'The code is incorrect or expired.');
    } finally {
      setVerifying(false);
    }
  };

  const handleResendOTP = async () => {
    if (__DEV__) return;
    try {
      setResending(true);
      const newConfirmation = await signInWithPhoneNumber(auth, phone);
      setConfirmation(newConfirmation);
      setCanResend(false);
      Alert.alert('OTP Sent', 'We sent you a new code.');
    } catch (error: any) {
      Alert.alert('Failed to resend code', error.message || 'Try again.');
    } finally {
      setResending(false);
    }
  };

  const handleBack = () => {
    navigation.goBack();
  };

  return (
    <Pressable onPress={Keyboard.dismiss}>
      <View style={styles.container}>
        <Text style={styles.title}>Verify Phone</Text>
        <Text style={styles.subtitle}>Enter the code sent to {phone}</Text>

        <TextInput
          style={styles.input}
          keyboardType="number-pad"
          placeholder="6-digit code"
          value={code}
          onChangeText={setCode}
          maxLength={6}
        />

        <TouchableOpacity style={styles.button} onPress={handleVerify} disabled={verifying}>
          {verifying ? (
            <ActivityIndicator color="#fff" />
          ) : (
            <Text style={styles.buttonText}>Verify & Continue</Text>
          )}
        </TouchableOpacity>

        {!__DEV__ && canResend && (
          <TouchableOpacity onPress={handleResendOTP} style={styles.resendButton} disabled={resending}>
            <Text style={styles.resendText}>{resending ? 'Sending...' : 'Resend Code'}</Text>
          </TouchableOpacity>
        )}

        <TouchableOpacity onPress={handleBack} style={styles.backContainer}>
          <Text style={styles.backText}>Back</Text>
        </TouchableOpacity>

        {Platform.OS === 'web' && <div id="recaptcha-container"></div>}
      </View>
    </Pressable>
  );
}

const styles = StyleSheet.create({
  container: {
    padding: 24,
    flex: 1,
    justifyContent: 'center',
    backgroundColor: '#f9f9fc',
  },
  title: {
    fontSize: 24,
    fontWeight: '700',
    textAlign: 'center',
    marginBottom: 12,
  },
  subtitle: {
    fontSize: 16,
    textAlign: 'center',
    marginBottom: 24,
  },
  input: {
    backgroundColor: '#fff',
    borderWidth: 1,
    borderColor: '#ccc',
    borderRadius: 10,
    padding: 14,
    fontSize: 18,
    textAlign: 'center',
    marginBottom: 20,
  },
  button: {
    backgroundColor: '#007bff',
    padding: 14,
    borderRadius: 10,
    alignItems: 'center',
    marginBottom: 8,
  },
  buttonText: {
    color: '#fff',
    fontWeight: '600',
    fontSize: 16,
  },
  resendButton: {
    marginTop: 10,
    alignItems: 'center',
  },
  resendText: {
    color: '#ec4899',
    fontSize: 14,
    textDecorationLine: 'underline',
  },
  backContainer: {
    marginTop: 30,
    alignItems: 'flex-start',
  },
  backText: {
    color: '#888',
    fontSize: 14,
    textDecorationLine: 'underline',
  },
});
