import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;
  final Color textColor;

  CustomButton({
    required this.onPressed,
    required this.text,
    this.color = Colors.white,
    this.textColor = Colors.blueAccent,
  });

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        primary: color,
        onPrimary: textColor,
        fixedSize: const Size(300, 50),
      ),
    );
  }
}