import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class OTPVerificationScreen extends StatefulWidget {
  final String phone;
  final ConfirmationResult? confirmation;

  const OTPVerificationScreen({
    super.key,
    required this.phone,
    this.confirmation,
  });

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final TextEditingController _codeController = TextEditingController();
  bool canResend = false;
  bool verifying = false;
  bool resending = false;
  ConfirmationResult? _confirmation;

  @override
  void initState() {
    super.initState();
    _confirmation = widget.confirmation;
    Future.delayed(const Duration(seconds: 30), () {
      if (mounted) setState(() => canResend = true);
    });
  }

  String cleanPhone(String raw) =>
      raw.replaceAll(RegExp(r'\s+'), '').replaceFirst(RegExp(r'^\++'), '+');

  String getStepScreenName(int step) {
    final stepMap = {
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
    return stepMap[step] ?? 'Step2Name';
  }

  Future<void> handleVerify() async {
    final code = _codeController.text.trim();
    if (code.length != 6) {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(title: Text('Invalid code')),
      );
      return;
    }

    setState(() => verifying = true);

    try {
      User? user;

      final isDev = bool.fromEnvironment('dart.vm.product') == false;
      final isTestPhone = widget.phone == '+1555555555';

      if (isDev || isTestPhone) {
        if (code != '123456') throw Exception('Mock: Invalid code.');
        user = FirebaseAuth.instance.currentUser;
        if (user == null) throw Exception('No authenticated user found.');
      } else if (_confirmation?.confirm != null) {
        final result = await _confirmation!.confirm(code);
        user = result.user;
        if (user == null) throw Exception('Verification returned no user.');
      } else {
        throw Exception('OTP confirmation object missing.');
      }

      final uid = user.uid;
      final phoneNumber = cleanPhone(user.phoneNumber ?? widget.phone);
      final userRef = FirebaseFirestore.instance.collection('users').doc(uid);
      final userSnap = await userRef.get();

      if (userSnap.exists) {
        final data = userSnap.data()!;
        if (data['pending18'] == true) {
          Navigator.pushReplacementNamed(context, 'Pending18Screen', arguments: {'uid': uid});
          return;
        }
        final step = data['onboardingStep'] ?? 1;
        final nextScreen = getStepScreenName(step);
        Navigator.pushReplacementNamed(context, nextScreen, arguments: {'uid': uid});
      } else {
        await userRef.set({
          'uid': uid,
          'phone': phoneNumber,
          'createdAt': FieldValue.serverTimestamp(),
          'referralCode': null,
          'referredBy': null,
          'referralPath': [],
          'referrals': [],
          'onboardingStep': 1,
          'onboardingComplete': false,
          'startedAt': FieldValue.serverTimestamp(),
        });
        Navigator.pushReplacementNamed(context, 'Step1InvitationCode', arguments: {'uid': uid});
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Verification Failed'),
          content: Text(e.toString()),
        ),
      );
    } finally {
      setState(() => verifying = false);
    }
  }

  void handleBack() => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FC),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Verify Phone', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text('Enter the code sent to ${widget.phone}', textAlign: TextAlign.center),
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: '6-digit code', border: OutlineInputBorder()),
                controller: _codeController,
                maxLength: 6,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: verifying ? null : handleVerify,
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                child: verifying ? const CircularProgressIndicator() : const Text('Verify & Continue'),
              ),
              const SizedBox(height: 10),
              if (canResend && !resending)
                TextButton(
                  onPressed: () async {
                    setState(() => resending = true);
                    try {
                      final auth = FirebaseAuth.instance;
                      final newConfirmation = await auth.signInWithPhoneNumber(widget.phone);
                      setState(() => _confirmation = newConfirmation);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('OTP resent.')));
                    } catch (e) {
                      showDialog(context: context, builder: (_) => AlertDialog(title: const Text('Error'), content: Text(e.toString())));
                    } finally {
                      setState(() => resending = false);
                    }
                  },
                  child: const Text('Resend Code'),
                ),
              TextButton(onPressed: handleBack, child: const Text('Back')),
            ],
          ),
        ),
      ),
    );
  }
}
