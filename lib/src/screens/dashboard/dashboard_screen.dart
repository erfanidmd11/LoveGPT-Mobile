// dashboard_screen.dart
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Center(
        child: Text(
          'Welcome to your dashboard 🎉',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'space_mono',
          ),
        ),
      ),
    );
  }
}

// step1_invitation_code.dart
import 'package:flutter/material.dart';

class Step1InvitationCode extends StatelessWidget {
  const Step1InvitationCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA),
      body: Center(
        child: Text(
          'Welcome to onboarding step 1 🚀',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'space_mono',
          ),
        ),
      ),
    );
  }
}
