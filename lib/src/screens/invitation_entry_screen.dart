import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class InvitationEntryScreen extends StatefulWidget {
  const InvitationEntryScreen({super.key});

  @override
  State<InvitationEntryScreen> createState() => _InvitationEntryScreenState();
}

class _InvitationEntryScreenState extends State<InvitationEntryScreen> {
  final TextEditingController _codeController = TextEditingController();
  String? _errorText;
  int _attemptCount = 0;
  bool _isLockedOut = false;
  Timer? _lockoutTimer;

  Future<bool> validateCodeWithServer(String code) async {
    try {
      final response = await http.post(
        Uri.parse('https://your-admin-api.lovegpt.ai/validate-invite'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'code': code}),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return result['valid'] == true;
      } else {
        debugPrint('Unexpected response: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      debugPrint('Validation failed: $e');
      return false;
    }
  }

  void _handleContinue() async {
    final code = _codeController.text.trim().toLowerCase();

    if (code.isEmpty) {
      setState(() => _errorText = 'invitation code is required');
      return;
    }

    if (_isLockedOut) {
      setState(() => _errorText = 'too many attempts. try again in 15 minutes.');
      return;
    }

    final isValid = await validateCodeWithServer(code);

    if (isValid) {
      _lockoutTimer?.cancel();
      Navigator.pushNamed(context, '/onboarding_intro', arguments: {'referredBy': code});
    } else {
      _attemptCount++;
      if (_attemptCount >= 5) {
        setState(() {
          _isLockedOut = true;
          _errorText = 'too many incorrect attempts. try again in 15 minutes.';
        });
        _lockoutTimer = Timer(const Duration(minutes: 15), () {
          setState(() {
            _isLockedOut = false;
            _attemptCount = 0;
            _errorText = null;
          });
        });
      } else {
        setState(() => _errorText = 'invalid invitation code. please try again.');
      }
    }
  }

  void _handleJoinWaitlist() {
    Navigator.pushNamed(context, '/waitlist');
  }

  @override
  void dispose() {
    _lockoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FC),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'enter invitation code',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontFamily: 'space_mono',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _codeController,
                decoration: InputDecoration(
                  hintText: 'invitation code',
                  errorText: _errorText,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'continue',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _handleJoinWaitlist,
                child: const Text(
                  "don't have a code? join the waitlist",
                  style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
