import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Hello!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'space_mono',
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Welcome to the app.',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'space_mono',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
