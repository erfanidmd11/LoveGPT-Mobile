// waitlist_request.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class WaitlistRequest extends StatefulWidget {
  const WaitlistRequest({super.key});

  @override
  State<WaitlistRequest> createState() => _WaitlistRequestState();
}

class _WaitlistRequestState extends State<WaitlistRequest> {
  final Map<String, String> _form = {
    'firstName': '',
    'lastName': '',
    'phone': '',
    'email': '',
    'instagram': '',
    'location': '',
    'reason': '',
    'heardFrom': '',
    'referredBy': '',
  };
  final Map<String, String?> _errors = {};

  final Map<String, String> placeholders = {
    'firstName': 'First Name',
    'lastName': 'Last Name',
    'phone': 'Phone Number',
    'email': 'Email',
    'instagram': 'Instagram, Facebook or X handle(s)',
    'location': 'Location (auto-filled)',
    'reason': 'Why do you want to join LoveGPT?',
    'heardFrom': 'How did you hear about us?',
    'referredBy': 'Who referred you? (optional)',
  };

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    try {
      final response = await http.get(Uri.parse('https://ipinfo.io/json?token=YOUR_IPINFO_TOKEN'));
      final data = jsonDecode(response.body);
      final locationString = "${data['city']}, ${data['region']}, ${data['country']}";
      setState(() => _form['location'] = locationString);
    } catch (e) {
      setState(() => _form['location'] = 'Location unavailable');
    }
  }

  Map<String, String?> _validate() {
    final errors = <String, String?>{};
    if (_form['firstName']!.isEmpty) errors['firstName'] = 'First name is required';
    if (_form['lastName']!.isEmpty) errors['lastName'] = 'Last name is required';
    if (_form['phone']!.isEmpty) errors['phone'] = 'Phone number is required';
    if (_form['email']!.isEmpty || !_form['email']!.contains('@')) errors['email'] = 'Valid email required';
    if (_form['reason']!.isEmpty) errors['reason'] = 'Please explain why you want to join';
    return errors;
  }

  Future<void> _handleSubmit() async {
    final validationErrors = _validate();
    if (validationErrors.isNotEmpty) {
      setState(() {
        _errors.clear();
        _errors.addAll(validationErrors);
});
      return;
    }

    try {
      // Replace with your API call or Firebase logic
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) Navigator.pushNamed(context, '/Success');
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(title: Text('Error'), content: Text('Could not submit request. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FCFC),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Text(
                          'Join the Waitlist',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Color(0xFF111111)),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF8F0),
                            border: Border(left: BorderSide(color: Color(0xFFF472B6), width: 4)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: const [
                              SizedBox(height: 8),
                              Text(
                                "You're in the right place ✨ Just because you weren’t invited (yet) doesn’t mean you're not important. We're building the first wave of visionaries... That could very well be you. 😉",
                                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Color(0xFF555555)),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Know someone already vibing inside? Don’t be shy — ask them for their invite. 🌟 If not, drop your deets below. If you're meant to be here (and we think you might be), ARIA will find a way.",
                                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Color(0xFF555555)),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 8),
                              Text(
                                '— ARIA 🌸',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Color(0xFFF472B6)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        ..._form.entries.map((entry) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: placeholders[entry.key],
                                  errorText: _errors[entry.key],
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                                maxLines: entry.key == 'reason' ? 4 : 1,
                                onChanged: (val) => setState(() => _form[entry.key] = val),
                              ),
                            )),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _handleSubmit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF007BFF),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('Next', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Back', style: TextStyle(color: Color(0xFF888888), fontSize: 14, decoration: TextDecoration.underline)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
