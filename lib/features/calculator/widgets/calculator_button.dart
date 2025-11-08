import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOperator;
  final bool isClearOrDelete;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOperator = false,
    this.isClearOrDelete = false,
  });

  Color _getBackgroundColor(BuildContext context) {
    if (isOperator) {
      return Color(0x00205b7a);
    }
    if (isClearOrDelete) {
      return Color(0xFFA2BBCF);
    }
    return Theme.of(context).colorScheme.surfaceContainerHighest;
  }

  @override
Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: _getBackgroundColor(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(96.0),
        ),
        padding: const EdgeInsets.all(10.0),
        overlayColor: Colors.transparent,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w500,
          color: Color(0xFF000000),
        ),
      ),
    ),
  );
}
}
