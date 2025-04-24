import 'package:flutter/material.dart';

class ConvertButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const ConvertButton({Key? key, required this.isLoading, required this.onPressed, required BoxDecoration decoration, required TextStyle textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? CircularProgressIndicator()
        : ElevatedButton(
      onPressed: onPressed,
      child: Text('Convert'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
