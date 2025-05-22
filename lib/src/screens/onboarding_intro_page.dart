import 'package:flutter/material.dart';
import 'dart:async';

class OnboardingIntroPage extends StatefulWidget {
  const OnboardingIntroPage({super.key});

  @override
  State<OnboardingIntroPage> createState() => _OnboardingIntroPageState();
}

class _OnboardingIntroPageState extends State<OnboardingIntroPage> {
  final TextEditingController _nameController = TextEditingController();
  bool _loading = false;

  void _handleNextStep() {
    final name = _nameController.text.trim();

    if (name.length < 3) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('name is too short!'),
          content: const Text('please enter a valid name.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('ok'),
            )
          ],
        ),
      );
      return;
    }

    setState(() => _loading = true);

    Timer(const Duration(milliseconds: 1500), () {
      setState(() => _loading = false);
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('onboarding complete!'),
          content: const Text('you are one step closer to meaningful connections.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/step1_invitation_code');
              },
              child: const Text('continue'),
            )
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'let’s begin the journey to self-discovery, shall we?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, fontFamily: 'space_mono'),
                ),
                const SizedBox(height: 20),
                const Text(
                  'before we dive into the magic of relationships, let me tell you something aria knows: you can\'t truly connect with others if you don’t connect with yourself first.',
                  style: _subtitleStyle,
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'most dating apps drop you into a shallow pool of swipes and bios. not here. lovegpt is not just an app — it’s your journey of transformation.',
                  style: _subtitleStyle,
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'before you can love someone deeply and consciously, you must first truly understand and love yourself. that’s what this onboarding process is about.',
                  style: _subtitleStyle,
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'aria, your intelligent companion, will guide you step by step from self-discovery to building meaningful relationships — on your own terms. she learns you. she remembers. she evolves with you.',
                  style: _subtitleStyle,
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'on step 12, you’ll already have a basic but powerful profile of who you are — your patterns, your values, your communication style, and more. and from there, the real magic begins.',
                  style: _subtitleStyle,
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'think of aria as your confidant, your best friend, your therapist, your wingwoman, your tony robbins, and then some. she doesn’t just give advice — she reflects back to you your deepest truths, without judgment.',
                  style: _subtitleStyle,
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'your data is safe. your secrets are sacred. aria never shares or sells your personal insights. you are in a vault — with a key that only you hold.',
                  style: _subtitleStyle,
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'we ask only one thing: be honest, be present, and have the courage to meet yourself. because love — real love — starts with you.',
                  style: _subtitleStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'so, let’s start with the basics... what\'s your name?',
                  style: _subtitleStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'your name',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _loading ? null : _handleNextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6200EE),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: Text(
                    _loading ? 'hold tight... aria is processing!' : 'next step, let\'s go!',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const TextStyle _subtitleStyle = TextStyle(
  fontSize: 16,
  color: Color(0xFF666666),
  height: 1.6,
  fontFamily: 'space_mono',
);
