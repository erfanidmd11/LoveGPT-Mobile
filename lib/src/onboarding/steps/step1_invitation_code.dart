import 'package:flutter/material.dart';

class Step1InvitationCode extends StatelessWidget {
  const Step1InvitationCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA),
      body: Center(
        child: Text(
          'Welcome to Onboarding Step 1 🚀',
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

