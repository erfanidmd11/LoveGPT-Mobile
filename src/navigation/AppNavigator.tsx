import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';

import SplashScreen from '../screens/SplashScreen';
import PhoneEntryPage from '../screens/auth/PhoneEntryPage';
import OtpPage from '../screens/auth/OtpPage';
import InvitationEntryScreen from '../screens/onboarding/InvitationEntryScreen';
import WaitlistRequest from '../screens/onboarding/WaitlistRequest';
import SuccessPage from '../screens/SuccessPage';
import DashboardScreen from '../screens/dashboard/DashboardScreen';
import OnboardingIntroPage from '../screens/onboarding/OnboardingIntroPage';
import Step1InvitationCode from '../onboarding/Steps/Step1InvitationCode';
// Add future steps as they are built

const Stack = createNativeStackNavigator();

const AppNavigator = () => {
  return (
    <NavigationContainer>
      <Stack.Navigator initialRouteName="Splash">
        <Stack.Screen name="Splash" component={SplashScreen} options={{ headerShown: false }} />
        <Stack.Screen name="PhoneEntry" component={PhoneEntryPage} options={{ title: 'Enter Phone' }} />
        <Stack.Screen name="OTP" component={OtpPage} options={{ title: 'Verify OTP' }} />
        <Stack.Screen name="InvitationEntry" component={InvitationEntryScreen} options={{ title: 'Enter Invitation Code' }} />
        <Stack.Screen name="Waitlist" component={WaitlistRequest} options={{ title: 'Join the Waitlist' }} />
        <Stack.Screen name="Success" component={SuccessPage} options={{ title: 'Success' }} />
        <Stack.Screen name="DashboardScreen" component={DashboardScreen} options={{ title: 'Dashboard' }} />
        <Stack.Screen name="OnboardingIntro" component={OnboardingIntroPage} options={{ title: 'Welcome to LoveGPT' }} />
        <Stack.Screen name="Step1InvitationCode" component={Step1InvitationCode} options={{ title: 'Step 1: Invitation Code' }} />

        {/* Future screens to be added later */}
        {/* <Stack.Screen name="Auth" component={AuthScreen} /> */}
        {/* <Stack.Screen name="Home" component={HomeScreen} /> */}
        {/* <Stack.Screen name="Onboarding" component={Onboarding} /> */}
        {/* <Stack.Screen name="Welcome" component={WelcomeToLoveGPT} /> */}
        {/* <Stack.Screen name="SupportRequest" component={SupportRequest} /> */}
      </Stack.Navigator>
    </NavigationContainer>
  );
};

export default AppNavigator;
