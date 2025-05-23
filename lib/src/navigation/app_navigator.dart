import 'package:flutter/material.dart';
import 'package:lovegpt_mobileapp/src/navigation/app_routes.dart';
import 'package:lovegpt_mobileapp/src/screens/splash_screen.dart';
import 'package:lovegpt_mobileapp/src/screens/phone_entry_page.dart';
import 'package:lovegpt_mobileapp/src/screens/otp_verification_screen.dart';
import 'package:lovegpt_mobileapp/src/screens/invitation_entry_screen.dart';
import 'package:lovegpt_mobileapp/src/screens/waitlist_request.dart';
import 'package:lovegpt_mobileapp/src/screens/success_page.dart';
import 'package:lovegpt_mobileapp/src/screens/dashboard/dashboard_screen.dart';
import 'package:lovegpt_mobileapp/src/screens/onboarding_intro_page.dart';
import 'package:lovegpt_mobileapp/src/onboarding/steps/step1_invitation_code.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.phoneEntry: (context) => const PhoneEntryPage(),
        AppRoutes.otp: (context) => const OTPVerificationScreen(phone: ''), // to be replaced dynamically
        AppRoutes.invitationEntry: (context) => const InvitationEntryScreen(),
        AppRoutes.waitlist: (context) => const WaitlistRequest(),
        AppRoutes.success: (context) => const SuccessPage(),
        AppRoutes.dashboard: (context) => const DashboardScreen(),
        AppRoutes.onboardingIntro: (context) => const OnboardingIntroPage(),
        AppRoutes.step1InvitationCode: (context) => const Step1InvitationCode(),
      },
    );
  }
}
