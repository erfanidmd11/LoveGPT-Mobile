// button.dart
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool fullWidth;
  final EdgeInsets? margin;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.fullWidth = false,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: fullWidth ? Alignment.center : Alignment.centerLeft,
      margin: margin ?? const EdgeInsets.only(top: 20),
      width: fullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: fullWidth ? const Color(0xFF007BFF) : Colors.transparent,
          padding: fullWidth ? const EdgeInsets.all(15) : EdgeInsets.zero,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(fullWidth ? 10 : 0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: fullWidth ? FontWeight.w600 : FontWeight.normal,
            color: fullWidth ? Colors.white : const Color(0xFF007BFF),
            decoration: fullWidth ? null : TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
